package com.core.Basic
{

	import com.Game.Common.Constants;
	
	import flash.geom.Rectangle;

	[Event(name="cameraUpdate", type="com.byxb.extensions.starling.events.CameraUpdateEvent")]
	/**
	 * A display object rig to access pan, rotation and zoom actions.
	 * @author Justin Church  - Justin [at] byxb [dot] com 
	 * 
	 */
	public class XCamera
	{
		/*** 视口左上角对应的世界坐标X */ 
		protected var _zeroX:Number = 0;
		/***视口左上角对应的世界坐标Y*/ 
		protected var _zeroY:Number = 0;
		/***摄像机视口*/ 
		private var _cameraView:Rectangle;
		/*** 主场景 */ 
		protected var _scene:XScene;

		public function XCamera(scene:XScene):void
		{
			_scene = scene;
			if(_cameraView==null) 
			{
				_cameraView = new Rectangle(0,0,Constants.STAGE_WIDTH,Constants.STAGE_HEIGHT);
			}	
		}
		
		public function get viewport():Rectangle  { return _cameraView};
		public function get zeroX():uint{return _zeroX;}
		public function get zeroY():uint{return _zeroY;}
		
//		/**移动到某距离*/	
//		public function moveTo(x:Number,y:Number):void
//		{
//			_zeroX = x;
//			_zeroY = y;
//		}
		
		public function setZero(x:int,y:int):void
		{
			_zeroX = x;
			_zeroY = y;
			
			var value:Number = _scene.tileMap.mapWidth - Constants.STAGE_WIDTH;
			_zeroX = _zeroX<0 ? 0 : _zeroX;
			_zeroX = _zeroX>value ? value : _zeroX;
			
			value = _scene.tileMap.mapHeight - Constants.STAGE_HEIGHT;
			_zeroY = _zeroY<0 ? 0 : _zeroY;
			_zeroY = _zeroY>value ? value : _zeroY;
		}
		
		/*** 镜头观察某点*/ 
		public function lookAt(x:uint,y:uint):void
		{
//			this.focus(null);
			setZero(x-(Constants.STAGE_WIDTH>>1),y-(Constants.STAGE_HEIGHT>>1));
			_scene.recut();
		}
		
		/**是否需要重新裁切*/		
		public function recut():void
		{
			_scene.recut();
		}
		
		public function dispose():void
		{
			
		}
		
	}
}

