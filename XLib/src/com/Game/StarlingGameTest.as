package com.Game
{
	import Test.Scene.ResManager;
	
	import dragonBones.Armature;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class StarlingGameTest extends Sprite
	{
		private var knight:Armature;
		private var cyborg:Armature;
		private var dargon:Armature;
		public function StarlingGameTest()
		{
			test();
		}
		
		private function test():void 
		{
			addscene();
		}

		private function addscene():void 
		{	
			ResManager.initBlock();
			for(var i:int = 0; i < 10; i++)
			{
				var name:String = "block" + (i%7 +1);
				var img:Image = ResManager.getImageByName(name);
				img.x = 100*i;
				addChild(img);
			}
			
		}
	}
}