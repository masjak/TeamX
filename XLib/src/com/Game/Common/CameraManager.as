package com.Game.Common
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.MediaEvent;
	import flash.media.CameraRoll;
	import flash.media.MediaPromise;
	

	public class CameraManager implements IDispose
	{
		private var cameraRoll:CameraRoll;
		private var callBack:Function;
		
		public function CameraManager()
		{
			init();
		}
		
		public function init():void
		{
			if(CameraRoll.supportsBrowseForImage)
			{
				cameraRoll = new CameraRoll();
			}
			else
			{
				trace("不支持手机相册！");
			}
			
		}
		
		public function supportsBrowseForImage():Boolean
		{
			return CameraRoll.supportsBrowseForImage;
		}
		
		public function browseImage(f:Function = null):void
		{
			cameraRoll.addEventListener(MediaEvent.SELECT, mediaSelected);
			cameraRoll.addEventListener(ErrorEvent.ERROR, onError);
			cameraRoll.browseForImage();
			this.callBack = f;
		}
		
		public function mediaSelected(e:MediaEvent):void 
		{
			cameraRoll.removeEventListener(MediaEvent.SELECT, mediaSelected);
			cameraRoll.removeEventListener(ErrorEvent.ERROR, onError);
			var mediaPromise:MediaPromise = e.data;
			var loader:Loader=new Loader();
			loader.loadFilePromise(mediaPromise);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onMediaPromiseLoaded);
			
		}
		
		public function onError(event:ErrorEvent):void 
		{
			trace("调用相册失败");
		}
		
		public function onMediaPromiseLoaded(e:Event):void 
		{
			var loaderInfo:LoaderInfo = e.target as LoaderInfo;
//			image.source = loaderInfo.loader;
			
			// 回调
			if(callBack != null)
			{
				callBack.call(null,loaderInfo.content);
				callBack = null;
			}
		}
		
		public function dispose():void
		{
			// TODO Auto Generated method stub
			callBack = null;
			cameraRoll = null;
			
		}
	}
}