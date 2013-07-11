package com.core.Map
{
	import com.D5Power.D5Game;
	import com.D5Power.Controler.Actions;
	import com.Game.XStage;
	import com.Game.XWorld;
	import com.Game.Common.Constants;
	import com.core.Basic.XSprite;
	import com.core.Utils.File.OpenFile;
	import com.core.loader.XLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.LoaderInfo;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.system.System;
	import flash.utils.ByteArray;

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
		/**tile Map横向的格子数*/
		public var mapWidth:Number;
		/**tile Map纵向的格子数*/
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
		protected var MapResource:Object;
		/*** 加载队列*/ 
		private var _loadList:Vector.<XLoader> = new Vector.<XLoader>;
		/*** 地图数组 */ 
		private var _arry:Array;	
		/** * 地图缓冲区（源地图） */
		protected var buffer:BitmapData;
		/*** 地图绘制区*/ 
		protected var _dbuffer:Shape;
		/** * 循环背景数据 */ 
		protected var _loop_bg_data:BitmapData;
		
		public function XMap(mapId:String)
		{
			_mapid = mapId;
			_dbuffer = new Shape;
			MapResource = {tiles:new Object()};
			praseData();
		}
		
		public function praseData():void
		{
			var f:File = new File(Constants.resRoot + "/" + _mapid +".d5"); 
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
			
			resize();
			makeData();
			
		}
				
		public function resize():void
		{
			if(buffer) buffer.dispose();
			buffer=new BitmapData(mapWidth+tileWidth,mapHeight+tileHeight,false);
			
//			if(_smallMap)
//			{
//				var per:Number = _smallMap.width/Global.MAPSIZE.x;
//				_scache = new BitmapData(buffer.width*per,buffer.height*per,false,0);
//			}
			
			
			// 根据宽高自动计算所能容纳的最大地图数
			_areaX = Math.ceil(mapWidth/tileWidth)+1;
			_areaY = Math.ceil(mapHeight/tileHeight)+1;
			
			if(_dbuffer)
			{
				_dbuffer.graphics.clear();
				_dbuffer.graphics.beginBitmapFill(buffer);
				_dbuffer.graphics.drawRect(0,0,buffer.width,buffer.height);
				renderSelf(true);
			}
		}
		
		/*** 渲染*/ 
		public function renderSelf(mustFlush:Boolean=false):void
		{
//			if(D5Game.me.camera.focusObject!=null && D5Game.me.camera.focusObject.action==Actions.Wait && !mustFlush) return;
			
			var startx:int = int(XWorld.instance.camera.zeroX/tileWidth);
			var starty:int = int(XWorld.instance.camera.zeroY/tileHeight);
			
			makeData(startx,starty,mustFlush); // 只有在采用大地图背景的前提下才不断修正数据
			
			if(_nowStartX==startx && _nowStartY==starty && posFlush!=null)
			{
				var zero_x:int = XWorld.instance.camera.zeroX%tileWidth;
				var zero_y:int = XWorld.instance.camera.zeroY%tileHeight;
				_dbuffer.x = -zero_x;
				_dbuffer.y = -zero_y;
			}
			
//			rendSwitch = false;
//			renderAction();
		}
		
		public function reset():void
		{
			clear();
			buffer.fillRect(buffer.rect,0);
		}
		
		/**
		 * 更新当前需要读取的地图数据
		 * @param	mustFlush	强制刷新
		 */ 
		protected function makeData(startx:int=-1,starty:int=-1,mustFlush:Boolean=false):void
		{
			// 根据00点坐标，计算地图渲染的开始区块坐标
			if(startx==-1)
			{
				startx = int(XWorld.instance.camera.zeroX/tileHeight);
				starty = int(XWorld.instance.camera.zeroY/tileWidth);
			}
			
			
			if(_nowStartX==startx && _nowStartY==starty && posFlush!=null && !mustFlush) return;
			
			_nowStartX = startx;
			_nowStartY = starty;
			
			if(posFlush!=null)
			{
				posFlush.splice(0,posFlush.length);
			}else{
				posFlush = new Array();
			}
			
//			fillSmallMap(startx,starty);
			
			var maxY:uint = Math.min(starty+_areaY,int(mapHeight/tileHeight));
			var maxX:uint = Math.min(startx+_areaX,int(mapWidth/tileWidth));
			
			for(var y:int=starty;y<maxY;y++)
			{
				var temp:Array = new Array();
				for(var x:int=startx;x<maxX;x++)
				{
					if(x<0 || y<0)
					{
						temp.push(null);
					}else{
						temp.push(y+'_'+x);
					}
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
			
//			_dbuffer.cacheAsBitmap=false;
			for(var k:String in posFlush)
			{
				var _data:Array = posFlush[k];
				var x:uint = 0;
				
				for(var s:String in _data)
				{
					try
					{
						// 先复制循环背景图
						arr = _data[s].split('_');
						
						if(_data[s]==null) continue;
						if( MapResource.tiles[_data[s]]==null)
						{
							var load:XLoader=new XLoader();
							load.name = LIB_DIR+"tiles/"+_mapid+"/"+_data[s]+"."+_tileFormat;
							//							trace("tiles/"+_mapid);
							load.data = _data[s];
							_loadList.push(load);
						}else if(MapResource.tiles[_data[s]]!=null){
							buffer.copyPixels(MapResource.tiles[_data[s]],MapResource.tiles[_data[s]].rect,new Point(x*tileWidth,y*tileHeight));
						}
						
					}catch(e:Error){
						
					}
					x++;
				}
				y++;
			}
			
			drawLoopGround();
			startLoad();
		}
		
		private function startLoad():void
		{
			if(_loadList.length==0) return;
			var loader:XLoader = _loadList[0];
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,tilesCompele);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,error);
			loader.load(new URLRequest(loader.name));
			
			_loadList.splice(0,1);
		}
		
		/**
		 * 数据加载结束后入库 */ 
		private function tilesCompele(e:Event):void
		{
			var l:LoaderInfo=e.target as LoaderInfo;
			var loader:XLoader = l.loader as XLoader;
			
			MapResource.tiles[loader.data]= (l.content as Bitmap).bitmapData;
			
			l.removeEventListener(Event.COMPLETE,tilesCompele);
			l.removeEventListener(IOErrorEvent.IO_ERROR,error);
			loader.unload();
			
			var pos:Array = loader.data.split('_');
			buffer.copyPixels(MapResource.tiles[loader.data],MapResource.tiles[loader.data].rect,new Point(int(pos[1]-_nowStartX)*tileWidth,int(pos[0]-_nowStartY)*tileHeight));
			
			if(_loadList.length>0)
			{
				startLoad();
			}else{
				_dbuffer.cacheAsBitmap=true;
			}
		}		
		
		private function updateLoopBg(e:Event):void
		{
			var l:LoaderInfo=e.target as LoaderInfo;
			var loader:XLoader = l.loader as XLoader;
			
			l.removeEventListener(Event.COMPLETE,tilesCompele);
			l.removeEventListener(IOErrorEvent.IO_ERROR,error);
			
			var img:Bitmap = l.content as Bitmap;
			if(_loop_bg_data!=null) _loop_bg_data.dispose();
			_loop_bg_data = new BitmapData(tileWidth,tileHeight,false,0);
			_loop_bg_data.draw(img,new Matrix(_loop_bg_data.width/img.width,0,0,_loop_bg_data.height/img.height),null,null,null,true);
			img.bitmapData = null;
			img = null;
			loader.unload();
			
			drawLoopGround();
		}
		
		private function drawLoopGround():void
		{
			if(_loop_bg_data==null) return;
			
			buffer.fillRect(buffer.rect,0);
			for(var i:uint=0,j:uint=Math.ceil(buffer.width/tileWidth);i<j;i++)
			{
				for(var m:uint=0,n:uint=Math.ceil(buffer.height/tileHeight);m<n;m++)
				{
					buffer.copyPixels(_loop_bg_data,_loop_bg_data.rect,new Point(tileWidth*i,tileHeight*m));
				}
			}
		}
		
		private function error(e:IOErrorEvent):void
		{
			try
			{
				var l:LoaderInfo=e.target as LoaderInfo;
				l.removeEventListener(Event.COMPLETE,tilesCompele);
				l.removeEventListener(IOErrorEvent.IO_ERROR,error);
			}catch(e:Error){
				
			}
			trace("加载出错:"+l.loader.name);
		}
		
		/*** 清空内存*/ 
		private function clear():void
		{
			while(posFlush.length) posFlush.shift();
			while(_arry.length) _arry.shift();
//			Global.CLEAR();
		}
		
		override public function dispose():void
		{
			clear();
			MapResource = null;
		}
		
	}
}