/**
 * D5Power Studio FPower 2D MMORPG Engine
 * 第五动力FPower 2D 多人在线角色扮演类网页游戏引擎
 * 
 * copyright [c] 2010 by D5Power.com Allrights Reserved.
 */ 
package com.core.Basic
{
	import com.core.Common.Constants;
	import com.core.Controler.BaseControler;
	import com.core.Math.QTree;
	import com.core.Objects.Direction;
	
	import flash.events.Event;
	import flash.geom.Point;

	/**
	 * 游戏对象基类
	 * 游戏中全部对象的根类
	 */ 
	public class XGameObject extends XSprite
	{
		/**
		 * 默认方向配置
		 */ 
		public static var DEFAULT_DIRECTION:Direction = new Direction();
		
		/**
		 * 渲染是否更新,若为true则无需渲染,若为false则需要重新渲染
		 */ 
		public var RenderUpdated:Boolean=false;

		/*** 标识*/ 
		public var ID:uint=0;
		/*** 移动速度*/ 
		public var speed:Number;
		/*** 是否可被攻击 */ 
		public var canBeAtk:Boolean=false;
		/*** 类型名，用于点击区分*/ 
		public var objectName:String;
		
		/** * 深度排序 */ 
		protected var zorder:int = 0;

		/**
		 * 控制器,每个对象都可以拥有控制器。控制器是进行屏幕裁剪后对不在屏幕内
		 * 的对象进行处理的接口。
		 */ 
		protected var _controler:BaseControler;
		/**
		 * 对象定位
		 */ 
		protected var pos:Point;
		
		/**
		 * 排序调整
		 */ 
		protected var _zOrderF:int;
		
		
		
		/**
		 * 记录当前对象所在的象限
		 */ 
		protected var _qTree:QTree;
		
		/**
		 * 最后一次渲染时间
		 */ 
		protected var _lastRender:uint;
		
		/** * 是否正在移出场景 */ 
		protected var _isOuting:Boolean;
		/*** 是否正在移进场景*/ 
		protected var _isIning:Boolean;
		
		protected var _action:int;
		
		protected var _direction:int;
		
		private var _resname:String;
		
		/*** 是否在场景内*/ 
		protected var $inScene:Boolean;

		/**
		 * @param	ctrl	控制器
		 */ 
		public function XGameObject(ctrl:BaseControler = null)
		{
			this.touchable = false;
			pos = new Point(0,0);
			speed = 1.4;
			changeController(ctrl);
		}
		
		/**
		 * 设置动作
		 */ 
		public function set action(u:int):void
		{
			_action = u;
		}
		
		public function get action():int
		{
			return _action;
		}
		
		/**
		 * 设置方向
		 */ 
		public function set direction(u:int):void
		{
			_direction = u;
		}
		
		public function get inScene():Boolean
		{
			return inScene;
		}
		
		/**
		 * 更换控制器
		 */ 
		public function changeController(ctrl:BaseControler):void
		{
			if(_controler!=null)
			{
				_controler.unsetupListener();
			}
			
			if(ctrl!=null)
			{
				_controler = ctrl;
				_controler.me=this;
				_controler.setupListener();
			}
			
		}
		/**
		 * 渲染定位
		 */ 
		public function get renderPos():uint
		{
			return 0;
		}
		
		/**
		 * 设置对象的坐标定位
		 * @param	p
		 */ 
		public function setPos(px:Number,py:Number):void
		{
			pos.x = px;
			pos.y = py;
			zorder = pos.y;
			
			if(!XCamera.needReCut && XCamera.cameraView && XCamera.cameraView.contains(pos.x,pos.y)) 
			{
				XCamera.needReCut = true;
			}
		}
		
		/**
		 * 将对象移动到某一点，并清除当前正在进行的路径
		 */ 
		public function reSetPos(px:Number,py:Number):void
		{
			setPos(px,py);
			if(controler!=null) controler.clearPath();
		}
		
		/**
		 * 当前对象所在的象限
		 */ 
		public function set qTree(q:QTree):void
		{
			_qTree = q;
		}
		
		/**
		 * 获取对象的坐标定位
		 */ 
		public function get PosX():Number
		{
			return pos.x;
		}
		
		/**
		 * 获取对象的坐标定位
		 */ 
		public function get PosY():Number
		{
			return pos.y;
		}
		
		/**
		 * 本坐标仅可用来获取！！！
		 */ 
		public function get _POS():Point
		{
			return pos;
		}
		/**
		 * 深度排序浮动
		 */ 
		public function set zOrderF(val:int):void
		{
			_zOrderF = val;
		}
		/**
		 * 深度排序浮动
		 */
		public function get zOrderF():int
		{
			return _zOrderF;
		}
		
		/**
		 * 获取坐标的深度排序
		 */ 
		public function get zOrder():int
		{
			//return zorder;
			return pos.y+_zOrderF;
		}
		
		public function get controler():BaseControler
		{
			return _controler;
		}
		
		public function runPos():void
		{
			if(_controler) _controler.calcAction();
			
			var targetx:Number;
			var targety:Number;
			var maxX:uint = XWorld.instance.scene.sceneData.mapWidth;
			var maxY:uint = XWorld.instance.scene.sceneData.mapHeight;
			
			if(XWorld.instance.camera.focusObject==this)
			{
				targetx = pos.x<(Constants.STAGE_WIDTH>>1) ? pos.x : (Constants.STAGE_WIDTH>>1);
				targety = pos.y<(Constants.STAGE_HEIGHT>>1) ? pos.y : (Constants.STAGE_HEIGHT>>1);
				
				targetx = pos.x>maxX-(Constants.STAGE_WIDTH>>1) ? pos.x-(maxX-Constants.STAGE_WIDTH) : targetx;
				targety = pos.y>maxY-(Constants.STAGE_HEIGHT>>1) ? pos.y-(maxY-Constants.STAGE_HEIGHT) : targety;
			}else{
//				var target:Point = XWorld.instance.scene.tileMap.getScreenPostion(pos.x,pos.y);
//					WorldMap.me.getScreenPostion(pos.x,pos.y);
//				targetx = target.x;
//				targety = target.y;
			}
			x = Number(targetx.toFixed(1));
			y = Number(targety.toFixed(1));
		}
		
		public function get renderLine():uint
		{
			return 0;
		}
		
		public function get renderFrame():uint
		{
			return 0;
		}
		
		public function get directionNum():int
		{
			return _direction;
		}
		
		public function setDirectionNum(v:int):void
		{
			_direction = v;
		}
		
		public function get directions():Direction
		{
			return DEFAULT_DIRECTION;
		}
		
		public function get Angle():uint
		{
			return 0;
		}

		override public function dispose():void
		{
			removeEventListener(Event.ENTER_FRAME,goOut);
			removeEventListener(Event.ENTER_FRAME,goIn);
			if(_controler) _controler.dispose();
//			Global.GC();
		}
		
		public function isOuting():void
		{
			_isOuting = true;
			_isIning = false;
			
			if(hasEventListener(Event.ENTER_FRAME)) removeEventListener(Event.ENTER_FRAME,goIn);
			if(!hasEventListener(Event.ENTER_FRAME)) addEventListener(Event.ENTER_FRAME,goOut);
		}
		
		public function isIning():void
		{
			_isIning = true;
			_isOuting = false;
			
			if(hasEventListener(Event.ENTER_FRAME)) removeEventListener(Event.ENTER_FRAME,goOut);
			if(!hasEventListener(Event.ENTER_FRAME)) addEventListener(Event.ENTER_FRAME,goIn);
		}
		
		public function get resName():String
		{
			return _resname;
		}
		
		public function set resName(s:String):void
		{
			_resname = s;
		}
		
		/**
		 * 当对象超出渲染范围后后逐渐消失的效果实现
		 */ 
		protected function goOut(e:Event):void
		{
			if(alpha>0)
			{
				alpha-=.01;
			}else{
//				_controler.perception.Scene.pullRenderList(this);
				removeEventListener(Event.ENTER_FRAME,goOut);
			}
		}
		
		/**
		 * 当对象进入渲染范围后后逐渐出现的效果实现
		 */ 
		protected function goIn(e:Event):void
		{
			if(alpha<1)
			{
				alpha+=.01;
			}else{
				removeEventListener(Event.ENTER_FRAME,goIn);
			}
		}
		
		/**
		 * 渲染动作
		 */ 
		protected function renderAction():void
		{
			
		}
		
		/**
		 * 当素材准备好后调用的初始化函数
		 */ 
		protected function build():void
		{
			
		}
	}
}