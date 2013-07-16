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
		
		protected var bakPoint:Point = new Point;
		
		
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
//			this.touchable = false;
//			this.
			_tileMap.addEventListener(TouchEvent.TOUCH,ontouch);
		}
		
		public function ontouch(te:TouchEvent):void
		{
			var touchBegin:Touch = te.getTouch(_tileMap,TouchPhase.BEGAN);
			var touchEnd:Touch = te.getTouch(_tileMap,TouchPhase.ENDED);
			var touchMove:Touch = te.getTouch(_tileMap,TouchPhase.MOVED);
			var p:Point;
			
			if(touchBegin != null)
			{
				bakPoint = _tileMap.globalToLocal(new Point(touchBegin.globalX,touchBegin.globalY));
				
				trace("touch begin: x = " + touchBegin.globalX + ",Y = " + touchBegin.globalY);
			}
			if(touchEnd != null)
			{
				if(_tileMap.x > 0)
				{
					_tileMap.x = 0;
				}
				else if(_tileMap.x < -(_tileMap.mapWidth - Constants.STAGE_WIDTH))
				{
					_tileMap.x = -(_tileMap.mapWidth - Constants.STAGE_WIDTH);
				}
				
				if(_tileMap.y > 0)
				{
					_tileMap.y = 0;
				}
				else if(_tileMap.y < -(_tileMap.mapHeight - Constants.STAGE_HEIGHT))
				{
					_tileMap.y = -(_tileMap.mapHeight - Constants.STAGE_HEIGHT);
				}
				
				p = _tileMap.globalToLocal(new Point(touchEnd.globalX,touchEnd.globalY));
				recut();
				trace("touch end: x = " + touchEnd.globalX + ",Y = " + touchEnd.globalY);
			}
			if(touchMove != null)
			{
				trace("touch Move: x = " + touchMove.globalX + ",Y = " + touchMove.globalY);
				p = _tileMap.globalToLocal(new Point(touchMove.globalX,touchMove.globalY));
				XWorld.instance.camera.setZero((p.x - bakPoint.x),(p.y - bakPoint.y));
				_tileMap.x += p.x - bakPoint.x;
				_tileMap.y += p.y - bakPoint.y;
				trace("touch Move globalToLocal: x = " + p.x + ",Y = " + p.y);
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