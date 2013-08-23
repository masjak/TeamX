package com.core.Basic
{
	import com.Game.Globel.Constants;
	import com.core.Common.DataStruct.buildersVO;
	import com.core.Effect.ClickEffect;
	import com.core.Utils.File.OpenFile;
	
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	/**
	 * 
	 * @author 场景中建筑类
	 * 
	 */	
	public class XBuilder extends XSprite
	{
		private var _state:int = 0;				// 建筑的状态 跟地图 白天黑夜等相匹配
		private var _body:Image;				// 建筑生成后的显示图
//		private var _blindLightName:String;	// 
		private var _vo:buildersVO;
		
		public function XBuilder(bds:buildersVO)
		{
			super();
			_vo = bds;
			
			var path:String = Constants.resRoot+bds.path;
			var ba:ByteArray = OpenFile.open(new File(path));
			var tex:Texture = Texture.fromAtfData(ba);
			_body = new Image(tex);
			
			addChild(_body);
		}
		
		/** 获取 建筑配置*/		
		public function get vo():buildersVO
		{
			return _vo;
		}
		
		/** 设置建筑当前的场景状态 比如白天 黑夜 */		
		public function set State(s:int):void
		{
			this._state = s;
//			StateManager.SetBuilderState(this,s);
		}
		
		/** 设置建筑是否可以点击 */	
		public function set Click(b:Boolean):void
		{
			if(b)
			{
				this.touchable = true;
				this.addEventListener(TouchEvent.TOUCH,onTouch);
			}
			else
			{
				this.touchable = false;
				this.removeEventListener(TouchEvent.TOUCH,onTouch);
			}
		}
		
		protected function onTouch(te:TouchEvent):void
		{
			te.stopPropagation();
			var touchBegin:Touch = te.getTouch(this,TouchPhase.BEGAN);
			if(touchBegin != null)
			{
				trace("builder name is " + this._vo.name);
				
				ClickEffect.playEffect(this, this._vo.clickEffect);
				
				
				return;
			}
			
			var touchMove:Touch = te.getTouch(this,TouchPhase.MOVED);
			if(this._vo.canMove && touchMove != null )
			{
				trace("touchMove! builder name is " + this._vo.name);
			}
			
			
		}
		
		/*** 销毁 */		
		override public function dispose():void
		{
			_vo = null;
			_body.dispose();
		}
		
	}
}