package com.core.Basic
{
	
	import com.Game.Globel.Constants;
	import com.core.Common.Singleton;
	import com.core.Common.DataStruct.SceneBuildersVO;
	import com.core.Common.DataStruct.SceneDataVO;
	import com.core.Common.DataStruct.SceneLightsVO;
	import com.core.Common.DataStruct.buildersVO;
	import com.core.Common.DataStruct.lightsVO;
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import starling.display.BlendMode;
	import starling.display.Quad;
	import starling.display.QuadBatch;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureAtlas;

	public class XScene extends XSprite
	{		
		protected var atlas:TextureAtlas;
		protected var state:int;
		protected var _tileMap:XMap;
		protected var _sds:SceneDataVO;
		
		/**地图层*/	
		protected var mapLayer:XSprite = new XSprite;
		/**特殊场合蒙层*/	
		protected var maskLayer:XSprite = new XSprite;
		/**建筑层*/
		protected var builderLayer:XSprite = new XSprite;
		/**光效层*/	
		protected var lightLayer:XSprite = new XSprite;
		
		/**场景额外的遮罩层*/		
		protected var maskImg:QuadBatch;
		
		/**建筑*/	
		protected var builders:Object = new Object;
		/**光影*/	
		protected var lights:Object = new Object;
		
		// 测试数据
		protected var _testQuad:Quad;
		
		public function XScene(sds:SceneDataVO)
		{
			_sds = sds;
			state = _sds.initState;
			
//			mapLayer.touchable = false;
			addChild(mapLayer);
			maskLayer.touchable = false;
			addChild(maskLayer);	
			
			addChild(builderLayer);
			
			lightLayer.touchable = false;
			addChild(lightLayer);
			setUp();
		}
		
		public function get sceneData():SceneDataVO{return _sds;}
		public function get sceneState():int{ return state; }
		public function set sceneState(s:int):void
		{
			if(s == state)
			{
				return;
			}
			state = s;
			init();
		}
		
		/** 构建场景*/
		private function setUp():void
		{
			_tileMap = new XMap(_sds);
			mapLayer.addChild(_tileMap);
			mapLayer.flatten();
			this.addEventListener(TouchEvent.TOUCH,ontouch);
			
			// 完成初始化的时候显示核心区域
			this.x -= _sds.initRect.x;
			this.y -= _sds.initRect.y;
			if((_sds.initRect.width/Constants.STAGE_WIDTH) > (_sds.initRect.height/Constants.STAGE_HEIGHT))
			{
				var scaley:Number = Constants.STAGE_HEIGHT/_sds.initRect.height;
				Constants.SCENE_ZOOM_MAX = ((scaley > Constants.SCENE_ZOOM_MAX)?scaley:Constants.SCENE_ZOOM_MAX);
				this.scaleX = scaley;
				this.scaleY = this.scaleX;
			}
			else
			{
				var scalex:Number = Constants.STAGE_WIDTH/_sds.initRect.width;
				Constants.SCENE_ZOOM_MAX = ((scalex > Constants.SCENE_ZOOM_MAX)?scalex:Constants.SCENE_ZOOM_MAX);
				this.scaleY = scalex;
				this.scaleX = this.scaleY;
			}
			adjustMapPos();
			init();
			
			// 测试可拖动区域
			var qb:QuadBatch = new QuadBatch();
			addChild(qb);
			var q:Quad = new Quad(32,32,0x00ff00);
			for(var i:int = 0; i < _sds.terrainHeight; i++)
			{
				for(var j:int = 0; j < _sds.terrainWidth; j++)
				{
					if(_sds.terrainData[j*_sds.terrainHeight + i] != 0)
					{
						q.x = j*_sds.terrainTileWidth;
						q.y = i*_sds.terrainTileHeight;
						qb.addQuad(q);
					}
				}
			}
			// 初始化完成之后 通知主屏幕
			Singleton.signal.dispatchSignal(Constants.SIGNAL_SCENE_CREATE_COMPLETE,this);
		}
		
		protected function init():void
		{
			//			createbuilders();// 创建建筑
			createMaskLayer();// 生成遮罩
			//			createlights();// 光影
			// 测试寻路
			//			testAstar();
		}
		
		/** 根据名字获取灯光*/		
		public function getLightByName(s:String):XLight
		{
			return lights[s];
		}
		
		/** 根据名字获取建筑*/
		public function getBuilderByName(s:String):XBuilder
		{
			return builders[s];
		}
		
		public function getSceneBuilderVO(s:String):SceneBuildersVO
		{
			var sbvo:SceneBuildersVO;
			for (var str:String in _sds.builders)
			{
				if(s == (_sds.builders[str] as SceneBuildersVO).sceneName)
				{
					sbvo = _sds.builders[str];
					break;
				}
			}
			return sbvo;
		}
		
		/** 根据建筑名字获取灯光*/		
		public function getLightByBuilderSceneName(s:String):XLight
		{
			
			var sbvo:SceneBuildersVO = getSceneBuilderVO(s);
			if(sbvo != null)
			{
				return getLightByName(sbvo.blindLight);
			}
			
			return null;
		}
		
		
		
		/** 创建光影组*/		
		protected function createlights():void
		{
			var lo:Object = _sds.lights;
			for (var s:String in lo)
			{
				createlight(lo[s]);
			}
		}
		
		/** 创建光影*/		
		protected function createlight(slvo:SceneLightsVO):void
		{
			if(slvo.State != slvo.State)
			{
				return;
			}
			
			var l:XLight = lights[slvo.sceneName];
			if(l == null)
			{
				var lvo:lightsVO = Singleton.lights.getLightVO(slvo.name);
				if(lvo == null)
				{
					throw new Error("不存在的灯光名字：" + slvo.name);
					return ;
				}
				l = new XLight(lvo);
				lights[slvo.sceneName] = l;	
			}
			l.x = slvo.PosX;
			l.y = slvo.PosY;

			if(!lightLayer.contains(l))
			{
				lightLayer.addChild(l);
			}
			
		}
		
		/** 创建建筑群*/		
		protected function createbuilders():void
		{
			var bo:Object = _sds.builders;
			for (var s:String in bo)
			{
				createbuilder(bo[s]);
			}
		}
		
		/** 创建建筑*/
		public function createbuilder(sbvo:SceneBuildersVO):void
		{
			var b:XBuilder = builders[sbvo.sceneName];
			if(b == null)
			{
				var bvo:buildersVO = Singleton.builders.getBuilderVO(sbvo.name);
				bvo.sceneName = sbvo.sceneName;
				
				if(bvo == null)
				{
					throw new Error("不存在的建筑名字：" + sbvo.name);
					return ;
				}
				b = new XBuilder(bvo);
				builders[sbvo.sceneName] = b;	
			}
			b.x = sbvo.PosX;
			b.y = sbvo.PosY;
			b.State = this.state;
			b.Click = sbvo.bclick;
			if(!builderLayer.contains(b))
			{
				builderLayer.addChild(b);
			}
			
		}
		
		/** 创建场景蒙层 比如夜晚*/		
		protected function createMaskLayer():void
		{
			// 晚上变白天 遮罩要去掉
			var bDay:Boolean = false;
			if(this.state == Constants.SCENE_STATE_DAY)
			{
//				createbuilders();// 创建建筑
//				createlights();// 光影
//				return;
				bDay = true;
			}
			
			
			// 生成遮罩
			if(maskImg == null)
			{
				maskImg = new QuadBatch();
				var q:Quad = new Quad(_sds.tileWidth,_sds.tileHeight,Constants.SCENE_MASK_COLOR,true);
				var maxY:uint = _sds.heightNum;
				var maxX:uint = _sds.widthNum;
				for(var y:int=0;y<maxY;y++)
				{
					for(var x:int=0;x<maxX;x++)
					{	
						q.x = x*_sds.tileWidth;
						q.y = y*_sds.tileHeight;
						maskImg.addQuad(q);
					}
				}
				
				maskImg.alpha = 0;
			}
			if(!maskLayer.contains(maskImg))
			{
				maskLayer.addChild(maskImg);
			}

			var ter:Timer = new Timer(50,10);
			ter.addEventListener(TimerEvent.TIMER,ontimer);
			ter.addEventListener(TimerEvent.TIMER_COMPLETE,oncomplete);
			ter.start();
			
			function ontimer(te:TimerEvent):void
			{
				if(bDay)
				{
					maskImg.alpha -= Constants.SCENE_MASK_APHLA/10;
				}
				else
				{
					maskImg.alpha += Constants.SCENE_MASK_APHLA/10;
				}
			}
			
			function oncomplete(te:TimerEvent):void
			{
				ter.removeEventListener(TimerEvent.TIMER,ontimer);
				ter.removeEventListener(TimerEvent.TIMER_COMPLETE,oncomplete);
				if(bDay)
				{
					removeChild(maskImg);
				}
				createbuilders();// 创建建筑
				createlights();// 光影
			}
			
			
		}
		
		public function testAstar():void
		{
			if(_testQuad == null)
			{
				_testQuad = new Quad(100,100,0xff0000);
			}
			_testQuad.x = 718;
			_testQuad.y = 387;
			_testQuad.blendMode = BlendMode.ADD;
			this.addChild(_testQuad);
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

					var bakScaleX:Number = this.scaleX;
					var bakScaleY:Number = this.scaleY;
					
					// 如果分辨率长大于高 以较小的高作为缩放标准
					if((_sds.mapWidth/Constants.STAGE_WIDTH) > (_sds.mapHeight/Constants.STAGE_HEIGHT))
					{
						var sy:Number = this.scaleY * sizeDiff;		
						if(sy < Constants.STAGE_HEIGHT/_sds.mapHeight)
						{
							this.scaleY =  Constants.STAGE_HEIGHT/_sds.mapHeight;
						}
						else if(sy >  Constants.SCENE_ZOOM_MAX)
						{
							this.scaleY = Constants.SCENE_ZOOM_MAX;
						}
						else
						{
							this.scaleY = sy;
						}
						this.scaleX = this.scaleY;
					}
					else
					{
						var sx:Number = this.scaleX * sizeDiff;	
						if(_sds.mapWidth*sx < Constants.STAGE_WIDTH )
						{
							this.scaleX =  Constants.STAGE_WIDTH/_sds.mapWidth;
						}
						else if(sx > Constants.SCENE_ZOOM_MAX)
						{	
							this.scaleX = Constants.SCENE_ZOOM_MAX;
						}
						else
						{
							this.scaleX = sx;
						}
						this.scaleY =this.scaleX;
					}
					
					// 缩放后对坐标进行补偿 看起来是按照中心点缩放的
					var offerX:Number = (this.scaleX - bakScaleX)*_sds.mapWidth/2;
					var offerY:Number = (this.scaleY - bakScaleY)*_sds.mapHeight/2;
					trace("offerX:" + offerX + ",offerY:" + offerY);
					
					this.x -= offerX;
					this.y -= offerY;
					adjustMapPos();			
				}
			}
			else if ( touches.length == 1 )
			{
				// 再判定触控响应
				var touchBegin:Touch = te.getTouch(this,TouchPhase.BEGAN);
				var touchEnd:Touch = te.getTouch(this,TouchPhase.ENDED);
				var touchMove:Touch = te.getTouch(this,TouchPhase.MOVED);
				var p:Point;
				var bp:Point;
				
				// 触摸开始
				if(touchBegin != null)
				{
					//				p = touchBegin.getLocation(this);
					//				var aPath:Array = XMap.AStar.find(_testQuad.x,_testQuad.y,p.x,p.y);
					//				if(aPath != null)
					//				{
					//					_testQuad.x = p.x;
					//					_testQuad.y = p.y;
					//				}
					
					
				}
				// 触摸结束
				if(touchEnd != null)
				{
					adjustMapPos();
				}
				// 触摸滑动
				if(touchMove != null)
				{
					p = touchMove.getLocation(this);
					bp = touchMove.getPreviousLocation(this);
					var xoff:Number = (this.x + p.x - bp.x);
					var yoff:Number = (this.y + p.y - bp.y);
					
					
					if(xoff > 0)
					{
						xoff = 0;
					}
					else if(xoff < -(_sds.mapWidth*this.scaleX - Constants.STAGE_WIDTH))
					{
						xoff = -(_sds.mapWidth*this.scaleX - Constants.STAGE_WIDTH);
					}
					
					if(yoff > 0)
					{
						yoff = 0;
					}
					else if(yoff < -(_sds.mapHeight*this.scaleY - Constants.STAGE_HEIGHT))
					{
						yoff = -(_sds.mapHeight*this.scaleY - Constants.STAGE_HEIGHT);
					}
					
					
					this.x = xoff;
					this.y = yoff;
					trace("touch : xoff = " + xoff + ",yoff = " + yoff);
				}
			}
			
			
			
		}
		
		private function adjustMapPos():void
		{
			// 设置地图位置
			if(this.x > 0)
			{
				this.x = 0;
			}
			else if(this.x < -(_sds.mapWidth*this.scaleX - Constants.STAGE_WIDTH))
			{
				this.x = -(_sds.mapWidth*this.scaleX - Constants.STAGE_WIDTH);
			}
			
			if(this.y > 0)
			{
				this.y = 0;
			}
			else if(this.y < -(_sds.mapHeight*this.scaleY - Constants.STAGE_HEIGHT))
			{
				this.y = -(_sds.mapHeight*this.scaleY - Constants.STAGE_HEIGHT);
			}
		}
		
	
		override public function dispose():void
		{
			_tileMap = null;
			atlas.dispose();
		}
		
	}
}