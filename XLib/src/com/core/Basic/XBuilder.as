package com.core.Basic
{
	import com.Game.Globel.Constants;
	import com.core.Common.Singleton;
	import com.core.Common.DataStruct.buildersVO;
	import com.core.Effect.ClickEffect;
	import com.core.Utils.File.OpenFile;
	
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	/**
	 * 
	 * @author 场景中建筑类
	 * 
	 */	
	public class XBuilder extends XSprite
	{
		private static var allowImage:Image;
		private static var forbidImage:Image;
		
		/**数据* */		
		private var _state:int = 0;				// 建筑的状态 跟地图 白天黑夜等相匹配
		private var _vo:buildersVO;
		
		/**逻辑*/		
		private var _moveLayer:Sprite;		// 移动时候底座 红色或者绿色
		private var _body:Image;				// 建筑生成后的显示图
		
		public function XBuilder(bds:buildersVO)
		{
			super();
			_vo = bds;
			
			var path:String = Constants.resRoot+bds.path;
			var ba:ByteArray = OpenFile.open(new File(path));
			var tex:Texture = Texture.fromAtfData(ba);
			
			// 创建显示移动层
			_moveLayer = new Sprite;
			_moveLayer.touchable = false;
			if(allowImage == null)
			{
				allowImage = new Image(Singleton.assets.getTexture("builderAllow"));
			}
			if(forbidImage == null)
			{
				forbidImage = new Image(Singleton.assets.getTexture("builderForbid"));
			}
			
			_body = new Image(tex);
			addChild(_moveLayer);
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
				// 点击建筑的时候 判断可移动的底座
				_moveLayer.addChild(allowImage);
				_moveLayer.x = (this.width - _moveLayer.width) >>1;
				_moveLayer.y = (this.height - _moveLayer.height);
				ClickEffect.playEffect(this, this._vo.clickEffect);
				trace("touchBegin! builder name is " + this._vo.name);
//				return;
			}
			
			var touchMove:Touch = te.getTouch(this,TouchPhase.MOVED);
			if(this._vo.canMove && touchMove != null )
			{
				// 移动的时候把绑定的灯光关掉
				var l:XLight = XWorld.instance.scene.getLightByBuilderSceneName(_vo.sceneName);
				if(l != null)
				{
					l.visible = false;
				}
				trace("touchMove! builder name is " + this._vo.name);
			}
			
			var touchEnd:Touch = te.getTouch(this,TouchPhase.ENDED);
			if(touchEnd != null )
			{
				_moveLayer.removeChildren();
				// 移动结束后 把绑定的灯光还原回去
				var l:XLight = XWorld.instance.scene.getLightByBuilderSceneName(_vo.sceneName);
				if(l != null)
				{
					l.visible = true;
				}
				trace("touchEnd! builder name is " + this._vo.name);
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