package com.core.Basic
{
	import com.Game.Globel.Constants;
	import com.core.Common.Singleton;
	import com.core.Common.DataStruct.BuildersVO;
	import com.core.Effect.ClickEffect;
	import com.core.Utils.File.OpenFile;
	
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import feathers.dragDrop.DragData;
	import feathers.dragDrop.DragDropManager;
	import feathers.dragDrop.IDragSource;
	import feathers.dragDrop.IDropTarget;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	/**
	 * 
	 * @author 场景中建筑类
	 * 
	 */	
	public class XBuilder extends XPSprite implements IDragSource,IDropTarget
	{
		private static var allowImage:Image;
		private static var forbidImage:Image;
		
		/**数据* */		
		private var _state:int = 0;				// 建筑的状态 跟地图 白天黑夜等相匹配
		private var _vo:BuildersVO;
		
		/**逻辑*/		
		private var _moveLayer:Sprite;		// 移动时候底座 红色或者绿色
		private var _body:Image;				// 建筑生成后的显示图
		private var localPoint:Point; 		// 按下去的时候 坐标
		private var _isPlayEffect:Boolean; // 是否正在播放效果  （某些操作在播放效果时候不能操作）
		
		public function XBuilder(bds:BuildersVO)
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
		public function get vo():BuildersVO
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
//			te.stopPropagation();
			var touchBegin:Touch = te.getTouch(this,TouchPhase.BEGAN);
			if(touchBegin != null)
			{
				onTouchBegin(te);
			}
			
			var touchMove:Touch = te.getTouch(this,TouchPhase.MOVED);
			if(this._vo.canMove && touchMove != null )
			{
				onTouchMove(te);
			}
			
			var touchEnd:Touch = te.getTouch(this,TouchPhase.ENDED);
			if(touchEnd != null )
			{
				onTouchEnd(te);
			}
		}
		
		/*** 按下去事件 */	
		protected function onTouchBegin(te:TouchEvent):void
		{
			ClickEffect.playEffect(this, this._vo.clickEffect,onEffectComplete);
			_isPlayEffect = true;
			function onEffectComplete():void
			{
				_isPlayEffect = false;
			}
			
			var touchBegin:Touch = te.getTouch(this,TouchPhase.BEGAN);
			localPoint =touchBegin.getLocation(this);
		}
		
		/*** 移动事件 */	
		protected function onTouchMove(te:TouchEvent):void
		{
			// 移动事件
			var l:XLight;
			var touchMove:Touch = te.getTouch(this,TouchPhase.MOVED);
//			te.stopPropagation();
			// 移动的时候把绑定的灯光关掉
			l = XWorld.instance.scene.getLightByBuilderSceneName(_vo.sceneId);
			if(l != null)
			{
				l.visible = false;
			}
			// 按下的点有值 并且不再播放效果 并且拖动没有开始
			if(localPoint != null && !DragDropManager.isDragging)
			{
				ClickEffect.stopPlayEffect(this);
				var dragData:DragData = Constants.DRAG_DATA;
				// 开始拖动
				this.scaleX = XWorld.instance.scene.scaleX;
				this.scaleY = XWorld.instance.scene.scaleY;
				var ox:Number = -localPoint.x*this.scaleX;
				var oy:Number = -localPoint.y*this.scaleY;
				
				dragData.setDataForFormat("XBuilder", {build:this,offerX:-localPoint.x,offerY:-localPoint.y});
				DragDropManager.startDrag(this, touchMove, dragData, this, ox ,oy);
				trace("startDrag");
				
			}
		}
		
		/*** 抬起事件处理 */	
		protected function onTouchEnd(te:TouchEvent):void
		{
			_moveLayer.removeChildren();
			localPoint = null;
		}
		
		/*** 更新底部可建筑状态 */	
		public function upDatamoveLayer(canBuilder:Boolean):void
		{
			// 判断可移动的底座
			_moveLayer.removeChildren();
			if( canBuilder)
			{
				_moveLayer.addChild(allowImage);
			}
			else
			{
				_moveLayer.addChild(forbidImage);
			}
			_moveLayer.x = (this.width/this.scaleX - _moveLayer.width) >>1;
			_moveLayer.y = (this.height/this.scaleY - _moveLayer.height);
		}
		
		/*** 销毁 */		
		override public function dispose():void
		{
			_vo = null;
			_body.dispose();
			removeEventListener(TouchEvent.TOUCH, onTouch);
		}
		
	}
}