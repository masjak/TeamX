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
			
		

		public function dispose():void
		{
			
		}
		
	}
}

