package
{
	import com.Game.StarlingGame;
	
	import flash.display.Sprite;
	
	import starling.core.Starling;
	
	[SWF(width="800", height="600",frameRate="30",  backgroundColor="#cccccc")]
	public class TeamX_Web extends Sprite
	{
		public function TeamX_Web()
		{
			starlingInit();
		}
		
		
		private function starlingInit():void 
		{
			var _starling:Starling = new Starling(StarlingGame, stage);
			//			_starling.antiAliasing = 1;
			_starling.showStats = true;
			_starling.start();
		}
		
	}
}