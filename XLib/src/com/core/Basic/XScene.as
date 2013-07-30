package com.core.Basic
{
	
	import com.Game.Common.Constants;
	import com.core.Utils.File.OpenFile;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
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
		protected var _tileMap:XMap;
		protected var _sceneId:String;
		
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
		
		public function XScene(sceneId:String)
		{
			_sceneId = sceneId;
			addChild(mapLayer);
			addChild(builderLayer);
			addChild(maskLayer);
			addChild(uintLayer);
			addChild(lightLayer);
		}
		
		public function get tileMap():XMap
		{
			return _tileMap;
		}
		
		public function setUp():void
		{
			_tileMap = new XMap(_sceneId);
			mapLayer.addChild(_tileMap);
			XWorld.instance.camera.lookAt(0,0);
			
			this.addEventListener(TouchEvent.TOUCH,ontouch);
			
			// 创建建筑
			createbuilders();
			
			// 生成遮罩
			createMaskLayer();
			
			// 光影
			createlights();
			
			// 测试寻路
//			testAstar();
		}
		
		/** 创建光影*/		
		public function createlights():void
		{
			var path:String = Constants.resRoot+"/tiles/1/light.atf";
			var ba:ByteArray = OpenFile.open(new File(path));
			var tex:Texture = Texture.fromAtfData(ba);
			var img:Image = new Image(tex);
			img.x = 430;
			img.y = 0;
			
			lights["house_light"] = img;
			lightLayer.addChild(img);
		}
		
		/** 创建建筑*/		
		public function createbuilders():void
		{
			var path:String = Constants.resRoot+"/tiles/1/house_day.atf";
			var ba:ByteArray = OpenFile.open(new File(path));
			var tex:Texture = Texture.fromAtfData(ba);
			var img:Image = new Image(tex);
			img.x = 430;
			img.y = 0;
			
			builders["house_light"] = img;
			builderLayer.addChild(img);
			
		}
		
		/** 创建场景蒙层 比如夜晚*/		
		public function createMaskLayer():void
		{
			// 生成遮罩
			var s:Shape = new Shape();
			s.graphics.beginFill(Constants.SCENE_MASK_COLOR,Constants.SCENE_MASK_APHLA);
			s.graphics.drawRect(0,0,_tileMap.mapWidth,_tileMap.mapHeight);
			s.graphics.endFill();
			var bd:BitmapData = new BitmapData(_tileMap.mapWidth,_tileMap.mapHeight,true,0);
			bd.draw(s);
			
			maskLayerTex = Texture.fromBitmapData(bd);
			maskLayerImg = new Image(maskLayerTex);
//			maskLayerImg.blendMode = BlendMode.ADD;
			
			maskLayer.addChild(maskLayerImg);
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
					// 按照最小的缩放比例约束
					// 如果分辨率长大于高 以较小的高作为缩放标准
					if((_tileMap.mapWidth/Constants.STAGE_WIDTH) > (_tileMap.mapHeight/Constants.STAGE_HEIGHT))
					{
						var sy:Number = this.scaleY * sizeDiff;		
						if(sy < Constants.STAGE_HEIGHT/_tileMap.mapHeight)
						{
							this.scaleY =  Constants.STAGE_HEIGHT/_tileMap.mapHeight;
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
						if(_tileMap.mapWidth*sx < Constants.STAGE_WIDTH )
						{
							this.scaleX =  Constants.STAGE_WIDTH/_tileMap.mapWidth;
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
					
					
					
					
//					var sx:Number = this.scaleX * sizeDiff;
//					// 约束比例
//					var scaleMode:Number = _tileMap.mapWidth/_tileMap.mapHeight;
//					
//					
//					// 约束缩放比例
//					if(_tileMap.mapWidth*sx < Constants.STAGE_WIDTH )
//					{
//						this.scaleX =  Constants.STAGE_WIDTH/_tileMap.mapWidth;
//					}
//					else if(sx > Constants.ZOOM_MAX)
//					{	
//						this.scaleX = Constants.ZOOM_MAX;
//					}
//					else{this.scaleX = sx;}
//					
//					var sy:Number = this.scaleX * sizeDiff * scaleMode*(Constants.STAGE_HEIGHT/Constants.STAGE_WIDTH);
//					
//					if(_tileMap.mapHeight*sy < Constants.STAGE_HEIGHT)
//					{
//						this.scaleY =  Constants.STAGE_HEIGHT/_tileMap.mapHeight;
//					}
//					else if(sy >  this.scaleX*scaleMode)
//					{
//						this.scaleY = this.scaleX*scaleMode;
//					}
//					else{this.scaleY = sy;}
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
				
				// 注册点变更
//				_tileMap.pivotX = _tileMap.x + Constants.STAGE_WIDTH >>1;
//				_tileMap.pivotY = _tileMap.y + Constants.STAGE_HEIGHT >>1;
				

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
				trace("touch : x = " + xoff + ",Y = " + yoff);
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