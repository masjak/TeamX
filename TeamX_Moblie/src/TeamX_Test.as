package
{
	import com.Game.StarlingGame;
	import com.Game.StarlingGameTest;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.system.Security;
	
	import Test.RobotLegs.HelloFlash;
	import Test.RobotLegs.helloflash.HelloFlashContext;
	
	import starling.core.Starling;
	
	[SWF(width="800", height="600",frameRate="60",  backgroundColor="#cccccc")]
	public class TeamX_Test extends Sprite
	{
		
		public function TeamX_Test()
		{
			super();
			
//			Security.allowDomain("*");
			// 支持 autoOrient
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			starlingInit();
			
			test();
			
		}
		
		
		private function test():void
		{
			
			
		}
		
		private function starlingInit():void 
		{
			var _starling:Starling = new Starling(StarlingGameTest, stage);
//			_starling.antiAliasing = 1;
			_starling.showStats = true;
			_starling.start();
		}
		
	}
}