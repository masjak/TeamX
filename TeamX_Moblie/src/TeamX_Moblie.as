package
{
	import com.Game.StarlingGame;
	import com.Game.Common.Constants;
	import com.Game.Common.Singleton;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import Welcome.Welcome;
	
	import org.osflash.signals.events.GenericEvent;
	
	import starling.core.Starling;
	
//	[SWF(width="800", height="600",frameRate="60",  backgroundColor="#cccccc")]
	[SWF(width="800", height="600",frameRate="60",  backgroundColor="#0")]
	public class TeamX_Moblie extends Sprite
	{
		private var _starling:Starling;
		private var wel:Welcome;
		
		public function TeamX_Moblie()
		{
			super();
			
			if(this.stage)
			{
				this.stage.scaleMode = StageScaleMode.NO_SCALE;
				this.stage.align = StageAlign.TOP_LEFT;
			}
			this.mouseEnabled = this.mouseChildren = false;
			this.loaderInfo.addEventListener(Event.COMPLETE, logo);
		}
		
		private function starlingInit():void 
		{	
			Starling.handleLostContext = !(Singleton.platform.Platform == Constants.PLATFORM_IOS);
			
			Starling.multitouchEnabled = true;
			
			_starling = new Starling(StarlingGame,stage);
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
		
		
		/***logo显示 */		
		private function logo(event:Event):void
		{
			// 在显示logo的时候去初始化 starling引擎 当引擎初始化完毕之后出去logo显示
			wel = new Welcome;
			addChild(wel);
			
			//添加事件监听  
			Singleton.signal.addSignal(Constants.SIGNAL_STARLING_INIT,this);
			Singleton.signal.registerSignalListener(Constants.SIGNAL_STARLING_INIT,StarlingInitComplete);
			
			// 初始化starling 引擎
			starlingInit();
			
		}
		
		// 引擎初始化完毕
		private function StarlingInitComplete(e:GenericEvent,o:Object):void
		{
			this.removeChild(wel);
			wel.dispose();
			Singleton.signal.removeSignal(Constants.SIGNAL_STARLING_INIT);
		}
		
	}
}