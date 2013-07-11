package com.core.Map
{
	import com.core.Basic.XSprite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import starling.textures.TextureAtlas;

	public class XScene extends XSprite
	{		
		protected var atlas:TextureAtlas;
		protected var tileMap:XMap;
		protected var _sceneId:String;
		
		public function XScene(sceneId:String)
		{
			_sceneId = sceneId;
			init();
		}
		
		public function init():void
		{
			
		}
		
		public function setUp():void
		{
			tileMap = new XMap(_sceneId);
		}
		
		override public function dispose():void
		{
			tileMap = null;
			atlas.dispose();
		}
		
	}
}