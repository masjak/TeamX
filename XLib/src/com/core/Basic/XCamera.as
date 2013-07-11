package com.core.Basic
{

	import com.D5Power.scene.BaseScene;
	import com.core.Map.XScene;
	import com.core.geom.InfiniteRectangle;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import feathers.utils.math.clamp;
	
	import starling.animation.DelayedCall;
	import starling.animation.Juggler;
	import starling.display.Sprite;

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
			if(_cameraView==null) _cameraView = new Rectangle();
			_cameraView = new Rectangle();
		}
		
		public function get viewport():Rectangle  { return _cameraView};
		public function get zeroX():uint{return _zeroX;}
		public function get zeroY():uint{return _zeroY;}
			
		

		public function dispose():void
		{
			
		}
		
	}
}

