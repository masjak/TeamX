package com.core.Basic
{
	import com.D5Power.core.SilzAstar;
	import com.Game.Common.Constants;
	import com.core.Astar.SilzAstar;
	import com.core.Math.FastRectangleTools;
	import com.core.Utils.File.OpenFile;
	import com.core.loader.XLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.system.System;
	import flash.utils.ByteArray;
	
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.utils.RectangleUtil;

	public class XMap extends XSprite
	{
		public static var LIB_DIR:String = '/asset/';
		
		/**地图ID*/
		public var _mapid:String;
		/**tile 背景*/
		public var loopBg:String;
		/**tile*/
		public var _hasTile:uint;
		/*** 大地图循环块的格式 */ 
		private var _tileFormat:String = 'png';
		/**tile Map横向的宽度*/
		public var mapWidth:Number;
		/**tile Map纵向的高度*/
		public var mapHeight:Number;
		/**tile 的宽*/
		public var tileWidth:Number;
		/**tile 的高*/
		public var tileHeight:Number;	
		//////////////////////////////////////////////////////////////////////////
		
		/** * 缓存起始X位置，在makeData中放置多次生成占用过多CPU*/ 
		protected var _nowStartX:uint;
		/** * 缓存起始Y位置，在makeData中放置多次生成占用过多CPU*/
		protected var _nowStartY:uint;
		/** * 显示区域X数量*/
		private var _areaX:uint;	
		/** *	显示区域Y数量*/ 
		private var _areaY:uint;
		/*** 当前屏幕正在渲染的坐标记录*/ 
		private var posFlush:Array;
		/*** 保存已经加载完成的资源*/ 
		protected var casheMap:Object;
		/*** 加载队列*/ 
		private var _loadList:Vector.<XLoader> = new Vector.<XLoader>;
		/*** 地图数组 */ 
		private var _arry:Array;	
		/** * 循环背景数据 */ 
		protected var _loop_bg_data:BitmapData;
		
		
		/*** 用于返回数据的点对象，已防止转换坐标的时候重复进行new操作*/ 
		private var _turnResult:Point;
		/*** 常量 寻路格子宽度*/
		public static var pathTileWidth:uint = 15;
		/*** 常量 寻路格子高度 */ 
		public static var pathTileHeight:uint = 15;
		/*** 寻路*/ 
		private static var _AStar:SilzAstar;
		/*** 摄像机范围扩展*/ 
		public static var cameraAdd:uint = 100;
		/*** 路点位图与地图总尺寸的比例*/  
		private var _roadK:Number;
		/*** 路点位图*/ 
		private var _roadMap:BitmapData;
		
		public function XMap(mapId:String)
		{
			_mapid = mapId;
			casheMap = {tiles:new Object()};
			_arry = new Array;
			praseData();
		}
		
		public function praseData():void
		{
			var f:File = new File(Constants.resRoot + "/tiles/" + _mapid +"/mapconf.d5"); 
			var ba:ByteArray = OpenFile.open(f);
			ba.uncompress();
			var str:String = ba.readUTFBytes(ba.bytesAvailable);
			var xml:XML = new XML(str);
			trace(xml.toXMLString());
			
			_mapid =  xml.id;
			_hasTile = xml.hasTile;
			_tileFormat =  xml.tileFormat;
			loopBg = xml.loopbg;
			mapWidth = xml.mapW;
			mapHeight = xml.mapH;
			tileWidth = xml.tileX;
			tileHeight = xml.tileY;
			
			// 释放XML资源
			System.disposeXML(xml);
//			makeData();
			loadRoadMap();
		}
				
		/*** 获取寻路对象 */ 
		public static function get AStar():SilzAstar {return _AStar;}
		protected function flushAstar():void{_AStar = new SilzAstar(_arry);}
		
		private function updateAstar():void
		{
			var h:int = int(mapHeight/pathTileHeight);
			var w:int = int(mapWidth/pathTileWidth);
			
			for(var y:uint = 0;y<h;y++)
			{
				for(var x:uint = 0;x<w;x++)
				{
					_arry[y][x] = _roadMap.getPixel(int(tileWidth*x*_roadK),int(tileHeight*y*_roadK))==0 ? 1 : 0;
				}
			}
			_AStar = new SilzAstar(_arry);
		}
		
		/*** 读取地图路点图 */ 
		protected function loadRoadMap():void
		{
			// 根据宽高自动计算所能容纳的最大地图数
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,configRoadMap);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,RoadLoadError);
			loader.load(new URLRequest(LIB_DIR+"RoadMap/map"+_mapid+".png"));
		}
		
		/*** 重置地图数据*/ 
		protected function resetRoad():void
		{
			_arry=[];
			// 定义临时地图数据
			var h:int =int(mapHeight/pathTileHeight);
			var w:int = int(mapWidth/pathTileWidth);
			for(var y:uint = 0;y<h;y++)
			{
				var arr:Array = new Array();
				for(var x:uint = 0;x<w;x++)
				{
					arr.push(0);
				}
				_arry.push(arr);
			}
		}
	
		/*** 路点加载完成，更新路点*/ 
		private function configRoadMap(e:Event):void
		{
			var loadinfo:LoaderInfo = e.target as LoaderInfo;
			
			loadinfo.removeEventListener(Event.COMPLETE,configRoadMap);
			loadinfo.removeEventListener(IOErrorEvent.IO_ERROR,RoadLoadError);
			
			resetRoad();
			_roadMap = (loadinfo.content as Bitmap).bitmapData;
			_roadK =  _roadMap.width/mapHeight;
			
			loadinfo.loader.unload();
			updateAstar();
			
//			dispatchEvent(new Event(Event.COMPLETE));
//			if(_mapComplate!=null) _mapComplate();
		}
		
		/*** 路点不存在，设置路点可行 */ 
		private function RoadLoadError(e:ErrorEvent):void
		{
			var loadinfo:LoaderInfo = e.target as LoaderInfo;
			
			loadinfo.removeEventListener(Event.COMPLETE,configRoadMap);
			loadinfo.removeEventListener(IOErrorEvent.IO_ERROR,RoadLoadError);
			
			resetRoad();
			
			_roadMap = new BitmapData(int(mapWidth*.1),int(mapHeight*.1),false,0xffffff);
			_roadK =  _roadMap.width/mapWidth;
			
			updateAstar();
			
//			dispatchEvent(new Event(Event.COMPLETE));
//			if(_mapComplate!=null) _mapComplate();
		}
		
		public function recut():void
		{
			makeData();
//			draw();
		}
		
		public function draw():void
		{
			var cameraView:Rectangle = XWorld.instance.camera.cameraCutView;
			var num:int = this.numChildren;
			for(var i:int = 0; i < num; i++)
			{
				var img:Image = this.getChildAt(i) as Image;
				if(img == null) continue;
				var bDraw:Boolean = FastRectangleTools.intersects(cameraView,new Rectangle(img.x,img.y,img.width,img.height));
				img.visible = bDraw;
			}
		}
		
		public function reset():void
		{
			clear();
		}
		
		/**
		 * 更新当前需要读取的地图数据
		 * @param	mustFlush	强制刷新
		 */ 
		protected function makeData(startx:int=-1,starty:int=-1):void
		{
			// 根据00点坐标，计算地图渲染的开始区块坐标
			if(startx==-1)
			{
				startx = XWorld.instance.camera.zeroX/tileHeight;
				starty = XWorld.instance.camera.zeroY/tileWidth;
			}
						
			_nowStartX = startx;
			_nowStartY = starty;
			
			if(posFlush!=null)
			{
				posFlush.splice(0,posFlush.length);
			}else{
				posFlush = new Array();
			}
			
//			fillSmallMap(startx,starty);
			
			_areaX = Math.ceil(XWorld.instance.camera.viewport.width/tileWidth)+1;
			_areaY = Math.ceil(XWorld.instance.camera.viewport.height/tileHeight)+1;
			
			var maxY:uint = Math.min(starty+_areaY,int(mapHeight/tileHeight));
			var maxX:uint = Math.min(startx+_areaX,int(mapWidth/tileWidth));
			
			for(var y:int=starty;y<maxY;y++)
			{
				var temp:Array = new Array;
				
				for(var x:int=startx;x<maxX;x++)
				{	
					var name:String = y + "_" + x;
					temp.push(name);
				}
				posFlush.push(temp);
			}
			loadTites();
			
		}
		
		/**
		 * 加载当前需要渲染的地图素材
		 */ 
		protected function loadTites():void
		{
			var arr:Array;
			
			var y:uint = 0;
			for(var k:String in posFlush)
			{
				var _data:Array = posFlush[k];
				var x:uint = 0;
				var atf:ByteArray;
				
				for(var s:String in _data)
				{
					try
					{
						// 先复制循环背景图名字
						arr = _data[s].split('_');
						
						var name:String = Constants.resRoot+"/tiles/"+_mapid+"/"+_data[s]+".atf";
						if( casheMap.tiles[_data[s]]==null)
						{
							atf = OpenFile.open(new File(name));
							var tex:Texture = Texture.fromAtfData(atf);
							var img:Image = new Image(tex);
							casheMap.tiles[_data[s]]= img;			

							img.x = arr[1]*tileWidth;
							img.y = arr[0]*tileHeight;
							addChild(img);
						}
						else if(casheMap.tiles[_data[s]]!=null)
						{		
							addChild(casheMap.tiles[_data[s]]);
						}
						
					}catch(e:Error){
						trace(e.message);
					}
					x++;
				}
				y++;
			}
			
//			drawLoopGround();
//			startLoad();
		}
		
//		private function updateLoopBg(e:Event):void
//		{
//			var l:LoaderInfo=e.target as LoaderInfo;
//			var loader:XLoader = l.loader as XLoader;
//			
//			l.removeEventListener(Event.COMPLETE,tilesCompele);
//			l.removeEventListener(IOErrorEvent.IO_ERROR,error);
//			
//			var img:Bitmap = l.content as Bitmap;
//			if(_loop_bg_data!=null) _loop_bg_data.dispose();
//			_loop_bg_data = new BitmapData(tileWidth,tileHeight,false,0);
//			_loop_bg_data.draw(img,new Matrix(_loop_bg_data.width/img.width,0,0,_loop_bg_data.height/img.height),null,null,null,true);
//			img.bitmapData = null;
//			img = null;
//			loader.unload();
//			
//			drawLoopGround();
//		}
//		
//		private function drawLoopGround():void
//		{
//			if(_loop_bg_data==null) return;
//			
//			buffer.fillRect(buffer.rect,0);
//			for(var i:uint=0,j:uint=Math.ceil(buffer.width/tileWidth);i<j;i++)
//			{
//				for(var m:uint=0,n:uint=Math.ceil(buffer.height/tileHeight);m<n;m++)
//				{
//					buffer.copyPixels(_loop_bg_data,_loop_bg_data.rect,new Point(tileWidth*i,tileHeight*m));
//				}
//			}
//		}
//		
		
		/*** 根据世界坐标获取在屏幕内的坐标 */ 
		public function getScreenPostion(x:Number,y:Number):Point
		{			
			_turnResult.x = x - XWorld.instance.camera.zeroX;
			_turnResult.y = y - XWorld.instance.camera.zeroY;
			return _turnResult;
		}
		
		/*** 根据路点获得世界（全地图）内的坐标*/ 
		public function tile2WorldPostion(x:Number,y:Number):Point
		{
			_turnResult.x = x*pathTileWidth+pathTileWidth*.5;
			_turnResult.y = y*pathTileHeight+pathTileHeight*.5;
			return _turnResult;
		}
		
		/*** 世界地图到路点的转换*/ 
		public function Postion2Tile(px:uint,py:uint):Point
		{
			_turnResult.x = int(px/pathTileWidth);
			_turnResult.y = int(py/pathTileHeight);
			return _turnResult;
		}
		
		
		/*** 清空内存*/ 
		private function clear():void
		{
			while(posFlush.length) posFlush.shift();
			while(_arry.length) _arry.shift();
			this.removeChildren();
			this.removeFromParent();
//			Global.CLEAR();
		}
		
		override public function dispose():void
		{
			clear();
			casheMap = null;
		}
		
	}
}