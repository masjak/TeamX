package com.core.Basic
{
	
	import com.core.Common.Constants;
	import com.core.Common.DataStruct.SceneDataStruct;
	import com.core.Common.DataStruct.buildersDataStruct;
	import com.core.Common.DataStruct.lightsDataStruct;
	import com.core.Utils.File.OpenFile;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class XScene extends XSprite
	{		
		protected var atlas:TextureAtlas;
		protected var state:int;
		protected var _tileMap:XMap;
		protected var _sds:SceneDataStruct;
		
		/**地图层*/	
		protected var mapLayer:XSprite = new XSprite;
		/**建筑层*/
		protected var builderLayer:XSprite = new XSprite;
		/**特殊场合蒙层*/	
		protected var maskLayer:XSprite = new XSprite;
		/**单位层*/	
		protected var uintLayer:XSprite = new XSprite;
		/**光效层*/	
		protected var lightLayer:XSprite = new XSprite;
		
		/**场景额外的遮罩层*/		
		protected var maskLayerTex:Texture;
		protected var maskLayerImg:Image;
		
		/**建筑*/	
		protected var builders:Object = new Object;
		/**光影*/	
		protected var lights:Object = new Object;
		
		// 测试数据
		protected var _testQuad:Quad;
		
		public function XScene(sds:SceneDataStruct)
		{
			_sds = sds;
			state = _sds.initState;
			addChild(mapLayer);
			addChild(builderLayer);
			addChild(maskLayer);
			addChild(uintLayer);
			addChild(lightLayer);
		}
		
		public function get sceneData():SceneDataStruct{return _sds;}
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
		
		public function setUp():void
		{
			_tileMap = new XMap(_sds);
			mapLayer.addChild(_tileMap);
			XWorld.instance.camera.lookAt(0,0);
			this.addEventListener(TouchEvent.TOUCH,ontouch);
			
			init();
		}
		
		protected function init():void
		{
//			createbuilders();// 创建建筑
			createMaskLayer();// 生成遮罩
//			createlights();// 光影
			// 测试寻路
			//			testAstar();
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
		protected function createlight(los:lightsDataStruct):void
		{
			var img:Image = lights[los.name];
			if(img != null)
			{
				if((los.State & this.state))
				{
					if(!lightLayer.contains(img))
					{
						lightLayer.addChild(img);
					}
				}
				else
				{
					lightLayer.removeChild(img);
				}
			}
			else
			{
				var path:String = Constants.resRoot+los.path;
				var ba:ByteArray = OpenFile.open(new File(path));
				var tex:Texture = Texture.fromAtfData(ba);
				img = new Image(tex);
				img.x = los.PosX;
				img.y = los.PosY;
				lights[los.name] = img;
				if((los.State & this.state))
				{
					if(!lightLayer.contains(img))
					{
						lightLayer.addChild(img);
					}
				}
				else
				{
					lightLayer.removeChild(img);
				}
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
		public function createbuilder(bds:buildersDataStruct):void
		{
			var img:Image = builders[bds.name];
			if(img != null)
			{
				if((bds.State & this.state))
				{
					if(!builderLayer.contains(img))
					{
						builderLayer.addChild(img);
					}
				}
				else
				{
					builderLayer.removeChild(img);
				}
			}
			else
			{
				var path:String = Constants.resRoot+bds.path;
				var ba:ByteArray = OpenFile.open(new File(path));
				var tex:Texture = Texture.fromAtfData(ba);
				img = new Image(tex);
				img.x = bds.PosX;
				img.y = bds.PosY;
				builders[bds.name] = img;
				if((bds.State & this.state))
				{
					if(!builderLayer.contains(img))
					{
						builderLayer.addChild(img);
					}
				}
				else
				{
					builderLayer.removeChild(img);
				}
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
			if(maskLayerImg == null)
			{
				var s:Shape = new Shape();
				s.graphics.beginFill(Constants.SCENE_MASK_COLOR,Constants.SCENE_MASK_APHLA);
				s.graphics.drawRect(0,0,_sds.mapWidth,_sds.mapHeight);
				s.graphics.endFill();
				var bd:BitmapData = new BitmapData(_sds.mapWidth,_sds.mapHeight,true,0);
				bd.draw(s);
				maskLayerTex = Texture.fromBitmapData(bd);
				maskLayerImg = new Image(maskLayerTex);
				maskLayerImg.alpha = 0;
			}
			if(!maskLayer.contains(maskLayerImg))
			{
				maskLayer.addChild(maskLayerImg);
			}

			var ter:Timer = new Timer(50,10);
			ter.addEventListener(TimerEvent.TIMER,ontimer);
			ter.addEventListener(TimerEvent.TIMER_COMPLETE,oncomplete);
			ter.start();
			
			function ontimer(te:TimerEvent):void
			{
				if(bDay)
				{
					maskLayerImg.alpha -= .1;
				}
				else
				{
					maskLayerImg.alpha += .1;
				}
			}
			
			function oncomplete(te:TimerEvent):void
			{
				ter.removeEventListener(TimerEvent.TIMER,ontimer);
				ter.removeEventListener(TimerEvent.TIMER_COMPLETE,oncomplete);
				if(bDay)
				{
					removeChild(maskLayerImg);
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
						else if(sy >  Constants.ZOOM_MAX)
						{
							this.scaleY = Constants.ZOOM_MAX;
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
						else if(sx > Constants.ZOOM_MAX)
						{	
							this.scaleX = Constants.ZOOM_MAX;
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
					
					XWorld.instance.camera.setZero(-this.x,-this.y );
					XWorld.instance.camera.update();
					recut();
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
					trace("touch : x = " + xoff + ",Y = " + yoff);
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