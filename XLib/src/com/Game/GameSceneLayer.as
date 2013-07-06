package com.Game
{
	import com.Game.Common.SceneManager;
	import com.core.TileMap.TileScene;
	
	import starling.display.Sprite;
	
	public class GameSceneLayer extends Sprite
	{
		protected var scene:TileScene;
		public function GameSceneLayer()
		{
			super();
			init();
		}
		
		public function init():void
		{
			scene = SceneManager.createTileScene("2");
			addChild(scene);
		}
		
		override public function dispose():void
		{
			if(scene != null)
			{
				scene.dispose();
				scene = null;
			}
		}
	}
}