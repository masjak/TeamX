package com.core.Basic
{
	
	import com.Game.Common.Constants;
	
	import flash.geom.Point;
	
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureAtlas;

	public class XScene extends XSprite
	{		
		protected var atlas:TextureAtlas;
		protected var _tileMap:XMap;
		protected var _sceneId:String;
		
		public function XScene(sceneId:String)
		{
			_sceneId = sceneId;
			init();
		}
		
		public function init():void
		{
			
		}
		
		public function get tileMap():XMap
		{
			return _tileMap;
		}
		
		public function setUp():void
		{
			_tileMap = new XMap(_sceneId);
			addChild(_tileMap);
			XWorld.instance.camera.lookAt(0,0);
			
			this.addEventListener(TouchEvent.TOUCH,ontouch);
		}
		
		public function ontouch(te:TouchEvent):void
		{
			// 先判定多点触摸
			var touches:Vector.<Touch> = te.touches; 
			// 2根指头
			if ( touches.length == 2 )
			{
				var finger1:Touch = touches[0]; 
				var finger2:Touch = touches[1];
				var distance:int; 
				var dx:int;
				var dy:int;
				if ( finger1.phase == TouchPhase.MOVED && finger2.phase == TouchPhase.MOVED ) 
				{
//					dx = Math.abs ( finger1.globalX - finger2.globalX );
//					dy = Math.abs ( finger1.globalY - finger2.globalY );
//					distance = Math.sqrt(dx*dx+dy*dy); 
//					trace ( distance );
					
					//A点的当前和上一个坐标
					var currentPosA:Point  = finger1.getLocation(this);
					var previousPosA:Point = finger1.getPreviousLocation(this);
					//B点的当前和上一个坐标
					var currentPosB:Point  = finger2.getLocation(this);
					var previousPosB:Point = finger2.getPreviousLocation(this);
					//计算两个点之间的距离
					var currentVector:Point  = currentPosA.subtract(currentPosB);
					var previousVector:Point = previousPosA.subtract(previousPosB);
					//缩放
					var sizeDiff:Number = currentVector.length / previousVector.length;
					var sx:Number = this.scaleX * sizeDiff;
					// 约束比例
					var scaleMode:Number = _tileMap.mapWidth/_tileMap.mapHeight;
					var sy:Number = sx * scaleMode*(Constants.STAGE_HEIGHT/Constants.STAGE_WIDTH);
					
					// 约束缩放比例
					if(_tileMap.mapWidth*sx < Constants.STAGE_WIDTH )
					{
						this.scaleX =  Constants.STAGE_WIDTH/_tileMap.mapWidth;
					}
					else if(sx > Constants.ZOOM_MAX)
					{	
						this.scaleX = Constants.ZOOM_MAX;
					}
					else{this.scaleX = sx;}
					
					if(_tileMap.mapHeight*sy < Constants.STAGE_HEIGHT)
					{
						this.scaleY =  Constants.STAGE_HEIGHT/_tileMap.mapHeight;
					}
					else if(sy >  Constants.ZOOM_MAX*scaleMode)
					{
						this.scaleY = Constants.ZOOM_MAX*scaleMode;
					}
					else{this.scaleY = sy;}
				}
				
				adjustMapPos();
				return;
			}
			
			
			
			// 再判定触控响应
			var touchBegin:Touch = te.getTouch(this,TouchPhase.BEGAN);
			var touchEnd:Touch = te.getTouch(this,TouchPhase.ENDED);
			var touchMove:Touch = te.getTouch(this,TouchPhase.MOVED);
			var p:Point;
			var bp:Point;
			
			// 触摸开始
			if(touchBegin != null)
			{
//				bakPoint = _tileMap.globalToLocal(new Point(touchBegin.globalX,touchBegin.globalY));
				
				trace("touch begin: x = " + touchBegin.globalX + ",Y = " + touchBegin.globalY);
			}
			// 触摸结束
			if(touchEnd != null)
			{
				adjustMapPos();
				
				XWorld.instance.camera.setZero(-_tileMap.x,-_tileMap.y );
				XWorld.instance.camera.update();
				recut();
				
				// 注册点变更
//				_tileMap.pivotX = _tileMap.x + Constants.STAGE_WIDTH >>1;
//				_tileMap.pivotY = _tileMap.y + Constants.STAGE_HEIGHT >>1;
				
				trace("touch end: x = " + touchEnd.globalX + ",Y = " + touchEnd.globalY);
			}
			// 触摸滑动
			if(touchMove != null)
			{
				trace("touch Move: x = " + touchMove.globalX + ",Y = " + touchMove.globalY);
//				p = _tileMap.globalToLocal(new Point(touchMove.globalX,touchMove.globalY));
				p = touchMove.getLocation(this);
				bp = touchMove.getPreviousLocation(this);
				var xoff:Number = (this.x + p.x - bp.x);
				var yoff:Number = (this.y + p.y - bp.y);
				
				
				if(xoff > 0)
				{
					xoff = 0;
				}
				else if(xoff < -(_tileMap.mapWidth*this.scaleX - Constants.STAGE_WIDTH))
				{
					xoff = -(_tileMap.mapWidth*this.scaleX - Constants.STAGE_WIDTH);
				}
				
				if(yoff > 0)
				{
					yoff = 0;
				}
				else if(yoff < -(_tileMap.mapHeight*this.scaleY - Constants.STAGE_HEIGHT))
				{
					yoff = -(_tileMap.mapHeight*this.scaleY - Constants.STAGE_HEIGHT);
				}
				
				
				this.x = xoff;
				this.y = yoff;
				trace("touch Move globalToLocal: x = " + p.x + ",Y = " + p.y);
			}
		}
		
		private function adjustMapPos():void
		{
			// 设置地图位置
			if(this.x > 0)
			{
				this.x = 0;
			}
			else if(this.x < -(_tileMap.mapWidth*this.scaleX - Constants.STAGE_WIDTH))
			{
				this.x = -(_tileMap.mapWidth*this.scaleX - Constants.STAGE_WIDTH);
			}
			
			if(this.y > 0)
			{
				this.y = 0;
			}
			else if(this.y < -(_tileMap.mapHeight*this.scaleY - Constants.STAGE_HEIGHT))
			{
				this.y = -(_tileMap.mapHeight*this.scaleY - Constants.STAGE_HEIGHT);
			}
		}
		
		/**是否需要重新裁切*/		
		public function recut():void
		{
			_tileMap.recut();
		}
		
		override public function dispose():void
		{
			_tileMap = null;
			atlas.dispose();
		}
		
	}
}