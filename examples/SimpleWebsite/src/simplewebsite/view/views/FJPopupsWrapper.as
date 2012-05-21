package simplewebsite.view.views
{
	import com.greensock.TweenLite;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import fj.view.events.FJPopupEvent;
	import fj.view.views.FJMovieClip;
	import fj.view.views.FJPopup;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	public class FJPopupsWrapper extends FJMovieClip
	{
		public var modalTransitionTime:Number;
		
		private var _modal:Sprite;
		private var _popupsWrapper:Sprite;
		private var _popupsDictionary:Dictionary;
		private var _center:Boolean;
		private var _alphaModal:Number;
		private var _colorModal:int;
		private var _modalActive:Boolean;
		
		public function FJPopupsWrapper()
		{
			TweenPlugin.activate([AutoAlphaPlugin]);
			
			_modal = new Sprite();
			addChild(_modal);
			TweenLite.to(_modal, 0, { autoAlpha:0 });
			setChildIndex( _modal, 0 );
			
			_popupsWrapper = new Sprite();
			addChild(_popupsWrapper);
			
			_popupsDictionary = new Dictionary(true);
			
			_center = true;
			
			_alphaModal = .3;
			_colorModal = 0x000000;
			_modalActive = true;
			modalTransitionTime = .3;
		}
		
		public function createPopup( name:String, popupClass:Class, autoOpen:Boolean = false ):*
		{
			var popup:Object = new popupClass();
			if ( !popup is FJPopup ) {
				throw new Error( Object( popup ).constructor + " must extend FJPopup class" );
			}
			_popupsDictionary[name] = popup;
			if ( autoOpen ) {
				openPopup( name );
			}
			
			return popup;
		}
		
		public function openPopup( name:String ):FJPopup
		{
			var popup:FJPopup = _popupsDictionary[name];
			_popupsWrapper.addChild( popup );
			popup.open();
			if ( _modalActive ) {
				TweenLite.to( _modal, modalTransitionTime, {autoAlpha:1} );
			}
			popup.addEventListener( FJPopupEvent.CLOSED, _popupClosed );
			
			return popup;
		}
		
		public function closePopup( name:String ):FJPopup
		{
			var popup:FJPopup = _popupsDictionary[name];
			popup.close();
			
			return popup;
		}
		
		public function getPopup( name:String ):FJPopup
		{
			return _popupsDictionary[name] as FJPopup;
		}
		
		public function removePopup( name:String ):void
		{
			var popup:FJPopup = _popupsDictionary[name];
			popup.close();
			_popupsDictionary[name] = null;
			
			popup.addEventListener( FJPopupEvent.CLOSED, _popupClosed );
		}
		
		public function set center( b:Boolean ):void
		{
			_center = b;
			if ( _center ) {
				onStageResize( null );
			} else {
				_popupsWrapper.x = 0;
				_popupsWrapper.y = 0;
			}
		}
		public function get center():Boolean
		{
			return _center;
		}
		
		public function set modal( b:Boolean ):void
		{
			if ( b ) {
				_modalActive = true;
				_modal.visible = true;
			} else {
				_modalActive = false;
				_modal.visible = false;
			}
		}
		
		public function set alphaModal( n:Number ):void
		{
			_alphaModal = n;
			_fillModal();
		}
		public function get alphaModal():Number
		{
			return _alphaModal;
		}
		
		public function set colorModal( n:int ):void
		{
			_colorModal = n;
			_fillModal();
		}
		public function get colorModal():int
		{
			return _colorModal;
		}
		override protected function onStageResize(e:Event):void 
		{
			if ( _center ) {
				_popupsWrapper.x = stage.stageWidth / 2;
				_popupsWrapper.y = stage.stageHeight / 2;
			}
			_fillModal();
		}
		
		
		private function _popupClosed( e:FJPopupEvent ):void
		{
			if ( _popupsWrapper.getChildByName( e.target.name ) ) {
				_popupsWrapper.removeChild( e.target as DisplayObject );
			}
			if ( _popupsWrapper.numChildren == 0 ) {
				if ( _modalActive ) {
					TweenLite.to( _modal, modalTransitionTime, {autoAlpha:0} );
				}
			}
		}
		private function _fillModal():void
		{
			if ( stage ) {
				_modal.graphics.clear();
				_modal.graphics.beginFill( _colorModal, alphaModal );
				_modal.graphics.drawRect( 0, 0, stage.stageWidth, stage.stageHeight )
				_modal.graphics.endFill();
			}
		}
	}
}