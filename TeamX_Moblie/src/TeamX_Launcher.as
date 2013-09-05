package
{
	import com.core.Common.Singleton;
	import com.core.Utils.File.OpenFile;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.Capabilities;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
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
			this.addEventListener(Event.ADDED_TO_STAGE, start);
		}
		
		/***logo显示 */		
		private function start(event:Event):void
		{
			// 如果是调试版本 先复制逻辑swf 正式打包版本会直接讲swf放进包里
			Singleton.update.UpDate(onUpDate);
			function onUpDate(cls:Class):void
			{
				clsGame = cls;
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