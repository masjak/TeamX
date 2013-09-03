package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
//	[SWF(width="800", height="600",frameRate="60",  backgroundColor="#cccccc")]
	[SWF(width="800", height="600",frameRate="60",  backgroundColor="#0")]
	public class TeamX_Launcher extends Sprite
	{
		private var clsGame:Class;
		
		public function TeamX_Launcher()
		{
			super();
			
			if(this.stage)
			{
				this.stage.scaleMode = StageScaleMode.NO_SCALE;
				this.stage.align = StageAlign.TOP_LEFT;
			}
			this.mouseEnabled = this.mouseChildren = false;
			this.addEventListener(Event.ADDED_TO_STAGE, logo);
		}
		
		/***logo显示 */		
		private function logo(event:Event):void
		{
			loaderLogicSWF();
		}
		
		/***加载逻辑SWF */	
		private function loaderLogicSWF():void
		{
			var request:URLRequest = new URLRequest("TeamX_Moblie.swf");
			var context:LoaderContext = new LoaderContext();
			context.applicationDomain = ApplicationDomain.currentDomain;
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE , onComplete);
			loader.load(request,context);	
			
			function onComplete(e:Event):void
			{
				clsGame = context.applicationDomain.getDefinition("TeamX_Moblie") as Class;
				init();
			}
		}
		
		/***加载逻辑SWF */	
		private function init():void
		{
			this.stage.addChild(new clsGame);
		}
		
		
	}
}