package com.core.Basic
{

	import com.Game.Common.Constants;
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;

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
		/***摄像机可视区域*/ 
		private static var  _cameraView:Rectangle;
		
		/*** 是否需要重新裁剪 */ 
		public static var needReCut:Boolean;
		private var _cameraCutView:Rectangle;
		
		/*** 摄像机移动速度 */ 
		protected var _moveSpeed:uint;
		
		/** * 镜头注视*/ 
		protected var _focus:XGameObject;
		
		/*** 主场景 */ 
		protected var _scene:XScene;

		protected var _timer:Timer;
		private var _moveStart:Point;
		private var _moveEnd:Point;
		private var _moveAngle:Number=0;
		private var _moveCallBack:Function;
		
		
		public function XCamera(scene:XScene):void
		{
			_scene = scene;
			if(_cameraView==null) _cameraView = new Rectangle();
			_cameraCutView = new Rectangle();	
		}
		
		public function get viewport():Rectangle  { return _cameraView};
		/*** 视口左上角对应的世界坐标X */ 
		public function get zeroX():uint{return _zeroX;}
		/***视口左上角对应的世界坐标Y*/ 
		public function get zeroY():uint{return _zeroY;}
		/*** 获取镜头注释目标 */ 
		public function get focusObject():XGameObject {return _focus;}	
		/*** 镜头移动速度 */ 
		public function set moveSpeed(s:uint):void{_moveSpeed = s;}
		
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
		
		public function update():void
		{
			if(_focus)
			{
				_zeroX = _focus.PosX - (Constants.STAGE_WIDTH>>1);
				_zeroY = _focus.PosY - (Constants.STAGE_HEIGHT>>1);
				
				var value:Number = _scene.tileMap.mapWidth - Constants.STAGE_WIDTH;
				_zeroX = _zeroX<0 ? 0 : _zeroX;
				_zeroX = _zeroX>value ? value : _zeroX;
				
				value = _scene.tileMap.mapHeight - Constants.STAGE_HEIGHT;
				_zeroY = _zeroY<0 ? 0 : _zeroY;
				_zeroY = _zeroY>value ? value : _zeroY;
			}
			
			_cameraView.x = _zeroX;
			_cameraView.y = _zeroY;
			
			_cameraView.width = Constants.STAGE_WIDTH;
			_cameraView.height = Constants.STAGE_HEIGHT;
		}
		
		/*** 镜头注视*/ 
		public function focus(o:XGameObject=null):void
		{
			_focus = o;
			update();
			recut();
		}
		
		/**
		 * 镜头视野矩形
		 * 返回镜头在世界地图内测区域
		 */ 
		public static function get cameraView():Rectangle
		{
			return _cameraView;
		}
		
		/** * 镜头裁剪视野 */ 
		public function get cameraCutView():Rectangle
		{
			var zero_x:int = _zeroX;
			var zero_y:int = _zeroY;
			
			zero_x-=_scene.tileMap.tileWidth*2;
			zero_y-=zero_y-_scene.tileMap.tileHeight*2;
			
			zero_x = zero_x<0 ? 0 : zero_x;
			zero_y = zero_y<0 ? 0 : zero_y;
			
			
			_cameraCutView.x = zero_x;
			_cameraCutView.y = zero_y;
			_cameraCutView.width = Constants.STAGE_WIDTH+_scene.tileMap.tileWidth*2;
			_cameraCutView.height = Constants.STAGE_HEIGHT+_scene.tileMap.tileHeight*2;
			
			return _cameraCutView;
		}
		
		/**
		 * 镜头向上
		 * @param	k	倍率
		 */ 
		public function moveNorth(k:uint=1):void
		{
			if(_moveSpeed==0 || _zeroY==0) return;
			this.focus(null);
			setZero(_zeroX,_zeroY-_moveSpeed*k);
			recut();
		}
		/**
		 * 镜头向下
		 */
		public function moveSourth(k:uint=1):void
		{
			if(_moveSpeed==0) return;
			this.focus(null);
			setZero(_zeroX,_zeroY+_moveSpeed*k);
			recut();
		}
		/**
		 * 镜头向左
		 */
		public function moveWest(k:uint=1):void
		{
			if(_moveSpeed==0 || _zeroX==0) return;
			this.focus(null);
			setZero(_zeroX-_moveSpeed*k,_zeroY);
			recut();
		}
		/**
		 * 镜头向右
		 */
		public function moveEast(k:uint=1):void
		{
			if(_moveSpeed==0) return;
			this.focus(null);
			setZero(_zeroX+_moveSpeed*k,_zeroY);
			recut();
		}
		
		public function move(xdir:int,ydir:int,k:uint=1):void
		{
			this.focus(null);
			setZero(_zeroX+_moveSpeed*xdir*k,_zeroY+_moveSpeed*ydir*k);
			recut();
		}
		
		/*** 镜头观察某点*/ 
		public function lookAt(x:uint,y:uint):void
		{
//			this.focus(null);
			setZero(x-(Constants.STAGE_WIDTH>>1),y-(Constants.STAGE_HEIGHT>>1));
			recut();
		}
		
		/**是否需要重新裁切*/		
		public function recut():void
		{
			_scene.recut();
		}
		
		public function flyTo(x:uint,y:uint,callback:Function=null):void
		{
			if(_timer!=null)
			{
				trace("[D5Camera] Camera is moving,can not do this operation.");
				return;
			}
			this.focus(null);
			_moveCallBack = callback;
			
			_moveStart = new Point(_zeroX-(Constants.STAGE_WIDTH>>1),_zeroY-(Constants.STAGE_HEIGHT>>1));
			
			_moveEnd = new Point(x-(Constants.STAGE_WIDTH>>1),y-(Constants.STAGE_HEIGHT>>1));
			
			_timer = new Timer(50);
			_timer.addEventListener(TimerEvent.TIMER,moveCamera);
			_timer.start();
		}
		
		protected function moveCamera(e:TimerEvent):void
		{
			var xspeed:Number = (_moveEnd.x-_moveStart.x)/5;
			var yspeed:Number = (_moveEnd.y-_moveStart.y)/5;
			_moveStart.x += xspeed;
			_moveStart.y += yspeed;
			setZero(_moveStart.x,_moveStart.y);
			if((xspeed>-.5 && xspeed<.5) && (yspeed>-.5 && yspeed<.5))
			{
				//_scene.Map.$Center = _moveEnd;
				_moveEnd = null;
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER,moveCamera);
				_timer = null;
				recut();
				if(_moveCallBack!=null) 
				{
					_moveCallBack();
					_moveCallBack = null;
				}
					
			}
		}
		
		public function dispose():void
		{
			
		}
		
	}
}

