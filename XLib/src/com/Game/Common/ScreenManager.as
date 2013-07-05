package com.Game.Common
{
	import com.Game.GameStage;
	import com.Game.Common.DataStruct.AtlasStruct;
	import com.Game.Common.DataStruct.BlockStruct;
	import com.Game.Common.DataStruct.SceneStruct;
	import com.core.Utils.Util;
	import com.core.Utils.File.OpenFile;
	
	import flash.filesystem.File;
	import flash.system.System;
	
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	
	import starling.textures.TextureAtlas;

	public class ScreenManager 
	{
		protected static var _navigator:ScreenNavigator;
		/**altas数据*/		
		protected static var vTexs:Vector.<AtlasStruct> = new Vector.<AtlasStruct>;
		/**altas数据*/		
		protected static var vblock:Vector.<BlockStruct> = new Vector.<BlockStruct>;
		
		public function ScreenManager()
		{
		}
		
		/** 初始化列表*/		
		public static function init():void
		{
			var f:File = new File(Constants.resRoot + "/Atlas/AtlasList.xml");
			var xml:XML = new XML(OpenFile.open(f));
			var len:int = xml.Tex.length();
			for(var i:int = 0; i < len; i++)
			{
				var ts:AtlasStruct = new AtlasStruct;
				ts.texId = xml.Tex[i].@Id;
				ts.texPath = xml.Tex[i].@path;
				ts.texPngName = xml.Tex[i].@PngName;
				ts.texXmlName = xml.Tex[i].@AtlasName;
				vTexs.push(ts);
			}
			System.disposeXML(xml);
			
			// 解析blockz
			f = new File(Constants.resRoot + "/Atlas/BlockMapList.xml");
			xml = new XML(OpenFile.open(f));
			len = xml.Block.length();
			for( i = 0; i < len; i++)
			{
				var bs:BlockStruct = new BlockStruct;
				bs.BlockName = xml.Block[i].@Id;
				bs.AtlasName = xml.Block[i].@AltasName;
				vblock.push(bs);
			}
			System.disposeXML(xml);
			// 
		}
		
		public static function getTextureByBLock(blockName:String,fun:Function):void
		{
			var atlasName:String = getAtlasNameByBLock(blockName);
			if(atlasName != null)
			{
				var atlas:TextureAtlas = Singleton.assets.getTextureAtlas(atlasName);
				if(atlas != null)
				{
					fun && fun.call(null,atlas.getTexture(blockName));
				}
				else
				{
					var ts:AtlasStruct = getAtlasData(atlasName);
					if(ts != null)
					{
						Util.LoadAtlasTexture((Constants.resRoot + ts.texPath + ts.texPngName),
							(Constants.resRoot + ts.texPath + ts.texXmlName),compl);
						function compl(ta:TextureAtlas):void
						{
							fun && fun.call(null,ta.getTexture(blockName));
						}
						
					}
				}
			}
			
		}
		
		protected static function addAtlasTex(name:String):void
		{
			
		}
		
		protected static function getAtlasNameByBLock(blockName:String):String
		{
			for each(var bs:BlockStruct in vblock)
			{
				if(bs.BlockName == blockName)
				{
					return bs.AtlasName;
				}
			}
			return null;
		}
		
		protected static function getAtlasData(atlasName:String):AtlasStruct
		{
			for each(var ts:AtlasStruct in vTexs)
			{
				if(ts.texId == atlasName)
				{
					return ts;
				}
			}
			return null;
		}
		
		public static function addScreen(id:String, item:ScreenNavigatorItem):void
		{
			_navigator.addScreen(id,item);
		}
		
		public static function showScreen(id:String):void
		{
			_navigator.showScreen(id);
			_navigator.visible =true;
		}
		
		public static function removeScreen(id:String):void
		{
			_navigator.removeScreen(id);
		}
		
		public static function clearScreen():void
		{
			_navigator.clearScreen();
			_navigator.visible = false;
		}
		
		public static function get screenNavigator():ScreenNavigator
		{
			if(_navigator == null)
			{
				_navigator = new ScreenNavigator;
			}
			return _navigator;
		}
		
		/** 释放资源*/
		public static function dispose():void
		{
			if(_navigator != null)
			{
				_navigator.clearScreen();
				_navigator.dispose();
				_navigator = null;
			}
			
		}
	}
}