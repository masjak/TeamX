package
{
	import com.core.Common.Constants;
	import com.core.Common.Singleton;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import Test.XGameTest;
	
	import starling.core.Starling;
	
//	[SWF(width="800", height="600",frameRate="60",  backgroundColor="#cccccc")]
	[SWF(width="800", height="600",frameRate="60",  backgroundColor="#0")]
	public class TeamX_Test extends Sprite
	{
		private var _starling:Starling;
		public function TeamX_Test()
		{
			
			if(this.stage)
			{
				this.stage.scaleMode = StageScaleMode.NO_SCALE;
				this.stage.align = StageAlign.TOP_LEFT;
			}
			this.mouseEnabled = this.mouseChildren = false;
			this.loaderInfo.addEventListener(Event.COMPLETE, starlingInit);
		}
		
		private function starlingInit(e:Event):void 
		{	
			Starling.handleLostContext = !(Singleton.platform.Platform == Constants.PLATFORM_IOS);
			
			Starling.multitouchEnabled = true;
			
			_starling = new Starling(XGameTest,stage);
			_starling.enableErrorChecking = false;
			_starling.showStats = true;
			_starling.start();
			
			this.stage.addEventListener(Event.RESIZE, stage_resizeHandler, false, int.MAX_VALUE, true);
			this.stage.addEventListener(Event.DEACTIVATE, stage_deactivateHandler, false, 0, true);
		}
		
		/** 舞台大小重置*/		
		private function stage_resizeHandler(event:Event):void
		{
			this._starling.stage.stageWidth = this.stage.stageWidth;
			this._starling.stage.stageHeight = this.stage.stageHeight;
			
			const viewPort:Rectangle = this._starling.viewPort;
			viewPort.width = this.stage.stageWidth;
			viewPort.height = this.stage.stageHeight;
			
			// 调整舞台宽高
			Constants.STAGE_WIDTH = this.stage.stageWidth;
			Constants.STAGE_HEIGHT = this.stage.stageHeight;
			
			try
			{
				this._starling.viewPort = viewPort;
			}
			catch(error:Error) {}
		}
		
		/** 舞台失去焦点*/	
		private function stage_deactivateHandler(event:Event):void
		{
			this._starling.stop();
			this.stage.addEventListener(Event.ACTIVATE, stage_activateHandler, false, 0, true);
		}
		
		/** 舞台激活*/	
		private function stage_activateHandler(event:Event):void
		{
			this.stage.removeEventListener(Event.ACTIVATE, stage_activateHandler);
			this._starling.start();
		}
		
	}
}