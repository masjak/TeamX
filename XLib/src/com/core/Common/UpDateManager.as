package  com.core.Common
{
	import com.Game.Globel.Constants;
	import com.core.Utils.File.OpenFile;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;

	public class UpDateManager implements IDispose
	{
		private var completeFun:Function;
		public function UpDateManager()
		{
			
		}
		
		
		/**执行更新*/		
		public function UpDate(onComplete:Function):void
		{
			completeFun = onComplete;
			// 如果是debug 则每次都覆盖更新逻辑swf 
			// 后面还会添加版本比对
			if(Singleton.platform.Debug && !(Singleton.platform.Platform == Constants.PLATFORM_ANDROID))
			{
				updateLogicSWF(onSWFSaveComplete);
			}
			else
			{
				loaderLogicSWF();
			}
			
			function onSWFSaveComplete(e:Event):void
			{
				loaderLogicSWF();
			}
			
			function onSWFLoaderComplete(e:Event):void
			{
				loaderLogicSWF();
			}
			
			
		}
		
		/***加载逻辑SWF */	
		private function loaderLogicSWF():void
		{
			var path:String = File.applicationDirectory.resolvePath("asset").url + "/TeamX_Moblie.swf";
			var request:URLRequest = new URLRequest(path);
			var context:LoaderContext = new LoaderContext();
			context.applicationDomain = ApplicationDomain.currentDomain;
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE , onComplete);
			loader.load(request,context);	
			
			function onComplete(e:Event):void
			{
				if(completeFun != null)
				{
					completeFun(context.applicationDomain.getDefinition("TeamX_Moblie"));
				}
			}
		}
		
		
		/***更新逻辑SWF */	
		private function updateLogicSWF(onFileOpenedToSave:Function):void
		{
			var path:String = File.applicationDirectory.resolvePath("asset").url  + "/TeamX_Moblie.swf";
			var f:File = new File(path);
			if(f.exists)
			{
				trace("逻辑swf已经存在！");
				f.deleteFile();
			}
			var name:String = File.applicationDirectory.url + "TeamX_Moblie.swf";
			f = new File(name);
			var ba:ByteArray = OpenFile.open(f);
			OpenFile.writeAsync(ba,path,onFileOpenedToSave);
		}
		
		public function dispose():void
		{
			completeFun = null;
			
		}
		
	}
}