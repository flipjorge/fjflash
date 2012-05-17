package fj.view.views
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Sine;
	
	import fj.view.events.FJItemEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class FJTileList extends FJMovieClip implements IDatable
	{
		public static const VERTICAL:String = "vertical";
		public static const HORIZONTAL:String = "horizontal";
		
		public var item:DisplayObject;
		public var scrollAnimation:Boolean;
		public var scrollAnimationTime:Number;
		public var scrollAnimationEase:Function;
		public var adjustAnimation:Boolean;
		public var adjustAnimationTime:Number;
		public var adjustAnimationEase:Function;
		public var progressiveLoad:Boolean;
		
		private var _itemsWrapper:Sprite;
		
		private var _itemClass:Class;
		private var _data:Array;
		private var _arrayItems:Array;
		private var _rowHeight:Number;
		private var _columnWidth:Number;
		private var _numberOfColumns:uint;
		private var _numberOfRows:uint;
		private var _orientation:String;
		private var _selectedIndex:int;
		private var _selectedColumn:int;
		private var _selectedRow:int;
		private var _selectedGrid:int;
		private var _selectable:Boolean;
		
		public function FJTileList()
		{
			_arrayItems = new Array();
			
			item = searchDisplayObjectByClass( IDatable, this, false );
			if ( item ) {
				if ( item is ISelectable ) _selectable = true;
				_itemClass = Object( item ).constructor;
				removeChild( item );
			}
			
			_itemsWrapper = new Sprite();
			addChild( _itemsWrapper );
			if( item ){
				_rowHeight = item.height;
				_columnWidth = item.width;
			}
			
			_orientation = VERTICAL;
			scrollAnimation = true;
			adjustAnimationTime = scrollAnimationTime = .2;
			adjustAnimationEase = scrollAnimationEase = Sine.easeOut;
		}
		
		public function get data():* { return _data; }
		public function set data( dt:* ):void
		{
			_data = dt;
			_clean();
			if ( _data ) {
				if ( progressiveLoad ) {
					var nItem:IDatable = _addItem( _data[0] );
					MovieClip( nItem ).addEventListener( FJItemEvent.LOADED, _itemLoaded );
				} else {
					for ( var i:uint = 0; i < _data.length; i++ ) {
						_addItem( _data[i] );
					}
				}
				_adjust( true );
			}
		}
		
		public function get itemClass():Class { return _itemClass; }
		public function set itemClass( c:Class ):void
		{
			_itemClass = c;
			
			item = new _itemClass();
			if ( item is ISelectable ) _selectable = true;
			_rowHeight = item.height;
			_columnWidth = item.width;
			removeChild( item );
		}
		
		public function get numberOfColumns():uint { return _numberOfColumns; }
		public function set numberOfColumns( n:uint ):void
		{
			_numberOfColumns = n;
			_adjust();
		}
		
		public function get numberOfRows():uint { return _numberOfRows; }
		public function set numberOfRows( n:uint ):void
		{
			_numberOfRows = n;
			_adjust();
		}
		
		public function get columnsWidth():void { return _columnWidth; }
		public function set columnsHeight( w:Number ):void
		{
			_columnWidth = w;
			_adjust();
		}
		
		public function get orientation():String { return _orientation }
		public function set orientation( o:String ):void
		{
			_orientation = o;
			_adjust();
		}
		
		public function setGrid( numberOfColumns:int, numberOfRows:int, orientation = HORIZONTAL ):void
		{
			_numberOfColumns = numberOfColumns;
			_numberOfRows = numberOfRows;
			_orientation = orientation;
			_adjust();
		}
		
		public function get totalColumns():int
		{
			return Math.ceil( _arrayItems.length / _numberOfRows );
		}
		public function get totalRows():int
		{
			return Math.ceil( _arrayItems.length / _numberOfColumns );
		}
		
		public function get totalGrids():int
		{
			return Math.ceil( _arrayItems.length / ( _numberOfColumns*_numberOfRows ) );
		}
		
		public function get currentGridIndex():int
		{
			return _selectedGrid;
		}
		
		public function get selectedIndex():int
		{
			if ( _selectable )
				return _selectedIndex;
			else
				return -1;
		}
		public function set selectedIndex( index:int ):void
		{
			if ( _selectable ) {
				_selectedIndex = index;
				var item:ISelectable;
				
				for( var i:uint = 0; i < _arrayItems.length; i++ ){
					item = _arrayItems[i] as ISelectable;
					if(item.selected) item.selected = false;
				}
				
				if ( index != -1 ) {
					item = _itemsWrapper.getChildAt(index) as ISelectable;
					item.selected = true;
				}
			}
		}
		
		public function get selectedItem():IDatable
		{
			if ( _selectable )
				return _arrayItems[ _selectedIndex ] as IDatable;
			else
				return null;
		}
		
		public function get selectedItemData():*
		{
			if ( _selectable )
				return IDatable( _arrayItems[ _selectedIndex ] ).data;
			else
				return null;
		}
		
		public function get selectable():Boolean
		{
			return _selectable;
		}
		public function set selectable( b:Boolean ):void
		{
			if ( _selectable && !b ) {
				_selectedIndex = -1;
			}
			_selectable = b;
		}
		
		public function scrollToColumn( column:int, skipAnimation = false ):void
		{
			_selectedColumn = column;
			var dx:Number = - column * _columnWidth;
			if ( scrollAnimation && !skipAnimation ) {
				TweenLite.to( _itemsWrapper, scrollAnimationTime, { x:dx, ease:scrollAnimationEase } );
			} else {
				_itemsWrapper.x = dx;
			}
		}
		
		public function scrollToPreviousColumn( skipAnimation = false ):void
		{
			if ( _selectedColumn > 0 ) {
				_selectedColumn--;
				scrollToColumn( _selectedColumn, skipAnimation );
			}
		}
		
		public function scrollToNextColumn( skipAnimation = false ):void
		{
			if ( _selectedColumn < totalColumns - 1 ) {
				_selectedColumn++;
				scrollToColumn( _selectedColumn, skipAnimation );
			}
		}
		
		public function scrollToRow( row:int, skipAnimation = false ):void
		{
			_selectedRow = row;
			var dy:Number = - row * _rowHeight
			if ( scrollAnimation && !skipAnimation ) {
				TweenLite.to( _itemsWrapper, scrollAnimationTime, { y:dy, ease:scrollAnimationEase } );
			} else {
				_itemsWrapper.y = dy;
			}
		}
		
		public function scrollToPreviousRow( skipAnimation = false ):void
		{
			if ( _selectedRow > 0 ) {
				_selectedRow--;
				scrollToRow( _selectedRow, skipAnimation );
			}
		}
		
		public function scrollToNextRow( skipAnimation = false ):void
		{
			if ( _selectedRow < totalRows - 1 ) {
				_selectedRow++;
				scrollToRow( _selectedRow, skipAnimation );
			}
		}
		
		public function scrollToGrid( index:int, skipAnimation = false ):void
		{
			_selectedGrid = index;
			var dx:Number;
			var dy:Number;
			if ( _orientation == HORIZONTAL ) {
				dx = - _numberOfColumns * _columnWidth * index;
				dy = 0;
			} else {
				dx = 0;
				dy = _numberOfRows * _rowHeight * index;
			}
			if ( scrollAnimation && !skipAnimation ) {
				TweenLite.to( _itemsWrapper, scrollAnimationTime, { x:dx, y:dy, ease:scrollAnimationEase } );
			} else {
				_itemsWrapper.x = dx;
				_itemsWrapper.y = dy;
			}
		}
		
		public function scrollToPreviousGrid( skipAnimation = false ):void
		{
			if ( _selectedGrid > 0 ) {
				_selectedGrid--;
				scrollToGrid( _selectedGrid, skipAnimation );
			}
		}
		
		public function scrollToNextGrid( skipAnimation = false ):void
		{
			if ( _selectedGrid < totalGrids - 1 ) {
				_selectedGrid++;
				scrollToGrid( _selectedGrid, skipAnimation );
			}
		}
		
		override public function destroy():void 
		{
			_itemClass = null;
			item = null;
			_clean();
			super.destroy();
		}
		
		private function _addItem( data:* ):IDatable
		{
			var nItem:IDatable = new _itemClass() as IDatable;
			nItem.data = data;
			if ( nItem is ISelectable ) {
				(nItem as DisplayObject).addEventListener( MouseEvent.CLICK, _itemClick );
			}
			_arrayItems.push( nItem );
			_itemsWrapper.addChild( ( nItem as DisplayObject ) );
			_adjust( true );
			
			return nItem;
		}
		private function _itemClick( e:MouseEvent ):void
		{
			selectedIndex = _itemsWrapper.getChildIndex( e.currentTarget as DisplayObject );
			dispatchEvent( new FJItemEvent( FJItemEvent.CLICKED ) );
		}
		private function _itemLoaded(e:FJItemEvent):void 
		{
			if ( _arrayItems.length < _data.length ) {
				var nItem:IDatable = _addItem( _data[_arrayItems.length - 1] );
				MovieClip( nItem ).addEventListener( FJItemEvent.LOADED, _itemLoaded );
			}
		}
		private function _clean():void
		{
			while ( _arrayItems.length > 0 ) {
				_itemsWrapper.removeChild( _arrayItems.shift() );
			}
		}
		private function _adjust( skipAnimation:Boolean = false ):void
		{
			var nItem:DisplayObject;
			var dx:Number;
			var dy:Number;
			
			for( var i:uint = 0; i < _arrayItems.length; i++ ){
				nItem = _arrayItems[i] as DisplayObject;
				if ( _numberOfColumns > 0 && _numberOfRows > 0 ) {
					if ( _orientation == HORIZONTAL ) {
						dx = i % _numberOfColumns * _columnWidth + Math.floor( i / ( _numberOfColumns * _numberOfRows ) ) * ( _columnWidth * _numberOfColumns );
						dy = _rowHeight * ( Math.floor( i / _numberOfColumns ) % _numberOfRows);
					} else {
						dx = _columnWidth * ( Math.floor( i / _numberOfRows) % _numberOfColumns);
						dy = i % _numberOfRows * _rowHeight + Math.floor( i / ( _numberOfColumns * _numberOfRows ) ) * ( _rowHeight * _numberOfRows );
					}
				} else if ( _numberOfColumns != -1 ) {
					dx = i % _numberOfColumns * _columnWidth;
					dy = Math.floor( i / _numberOfColumns ) * _rowHeight;
				} else if ( _numberOfRows != -1 ) {
					dx = Math.floor( i / _numberOfRows) * _columnWidth;
					dy = i % _numberOfRows * _rowHeight;
				}
				if ( adjustAnimation && !skipAnimation ) {
					TweenLite.to( nItem, adjustAnimationTime, { x:dx, y:dy, ease:adjustAnimationEase } );
				} else {
					nItem.x = dx;
					nItem.y = dy;
				}
			}
		}
	}
}