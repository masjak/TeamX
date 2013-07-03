package
{
	import com.Game.StarlingGame;
	import com.Game.StarlingGameTest;
	import com.Game.Common.Constants;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.system.Security;
	
	import Test.RobotLegs.HelloFlash;
	import Test.RobotLegs.helloflash.HelloFlashContext;
	
	import feathers.examples.helloWorld.Main;
	
	import starling.core.Starling;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	
	[SWF(width="800", height="600",frameRate="60",  backgroundColor="#cccccc")]
	public class TeamX_Moblie extends Sprite
	{
		private var _starling:Starling;
		
		public function TeamX_Moblie()
		{
			super();
			
			if(this.stage)
			{
				this.stage.scaleMode = StageScaleMode.NO_SCALE;
				this.stage.align = StageAlign.TOP_LEFT;
			}
			this.mouseEnabled = this.mouseChildren = false;
			this.loaderInfo.addEventListener(Event.COMPLETE, starlingInit);
			
			//测试函数 
			test();
			
		}
		
		private function starlingInit(event:Event):void 
		{
//			var viewPort:Rectangle = RectangleUtil.fit(
//				new Rectangle(0, 0, Constants.STAGE_WIDTH, Constants.STAGE_HEIGHT), 
//				new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight), 
//				ScaleMode.SHOW_ALL);
				
			
			Starling.handleLostContext = true;
			Starling.multitouchEnabled = true;
			
			_starling = new Starling(StarlingGameTest,stage);
			_starling.enableErrorChecking = false;
			_starling.showStats = true;
			_starling.start();
			
			this.stage.addEventListener(Event.RESIZE, stage_resizeHandler, false, int.MAX_VALUE, true);
			this.stage.addEventListener(Event.DEACTIVATE, stage_deactivateHandler, false, 0, true);
		}
		
		
		private function stage_resizeHandler(event:Event):void
		{
			this._starling.stage.stageWidth = this.stage.stageWidth;
			this._starling.stage.stageHeight = this.stage.stageHeight;
			
			const viewPort:Rectangle = this._starling.viewPort;
			viewPort.width = this.stage.stageWidth;
			viewPort.height = this.stage.stageHeight;
			try
			{
				this._starling.viewPort = viewPort;
			}
			catch(error:Error) {}
		}
		
		private function stage_deactivateHandler(event:Event):void
		{
			this._starling.stop();
			this.stage.addEventListener(Event.ACTIVATE, stage_activateHandler, false, 0, true);
		}
		
		private function stage_activateHandler(event:Event):void
		{
			this.stage.removeEventListener(Event.ACTIVATE, stage_activateHandler);
			this._starling.start();
		}
		
		
		/***测试函数都可以写在这里 */		
		private function test():void
		{
			
			//			trace(Capabilities.manufacturer);
		}
		
	}
}