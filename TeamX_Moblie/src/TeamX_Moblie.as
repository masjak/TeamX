package
{
	import com.Game.StarlingGame;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.system.Security;
	
	import starling.core.Starling;
	
	//[SWF(width="800", height="600", frameRate="30", backgroundColor="#cccccc")]
	[SWF(width="800", height="600",frameRate="60",  backgroundColor="#cccccc")]
	public class TeamX_Moblie extends Sprite
	{
		public function TeamX_Moblie()
		{
			super();
			
//			Security.allowDomain("*");
			// 支持 autoOrient
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
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