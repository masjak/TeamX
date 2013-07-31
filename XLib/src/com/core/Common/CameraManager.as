package com.core.Common
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.MediaEvent;
	import flash.media.CameraRoll;
	import flash.media.CameraUI;
	import flash.media.MediaPromise;
	import flash.media.MediaType;
	

	public class CameraManager implements IDispose
	{
		private var _cameraRoll:CameraRoll;
		private var _cameraUI:CameraUI;
		
		private var sureCallBack:Function;
		private var cancelCallBack:Function;
		
		public function CameraManager()
		{
			init();
		}
		
		public function init():void
		{
			
		}
		
		/** 设备是否支持相册功能*/		
		public function isSupportsCaremaPhoto():Boolean
		{
			return CameraRoll.supportsBrowseForImage;
		}
		
		/** 设备是否支持拍照功能*/	
		public function isSupportsCarema():Boolean
		{
			return CameraUI.isSupported;
		}
		
		/** 打开拍照功能*/	
		public function OpenCarema(f:Function = null,c:Function = null):void
		{
			SetCallBack(f,c);
			if(isSupportsCarema())
			{
				_cameraUI = new CameraUI();
			}
			else
			{
				trace("不支持拍照！");
				return;
			}
			
			_cameraUI.addEventListener(MediaEvent.COMPLETE, mediaSelected);
			_cameraUI.addEventListener(Event.CANCEL, onCancel);
			_cameraUI.addEventListener(ErrorEvent.ERROR, onError);
			_cameraUI.launch(MediaType.IMAGE);
			
		}
		
		/** 打开相册功能*/	
		public function OpenCaremaPhoto(f:Function = null,c:Function = null):void
		{
			SetCallBack(f,c);
			if(isSupportsCaremaPhoto())
			{
				_cameraRoll = new CameraRoll();
			}
			else
			{
				trace("不支持手机相册！");
				return;
			}
			_cameraRoll.addEventListener(MediaEvent.SELECT, mediaSelected);
			_cameraRoll.addEventListener(Event.CANCEL, onCancel);
			_cameraRoll.addEventListener(ErrorEvent.ERROR, onError);
			_cameraRoll.browseForImage();
		}
		
		/** 拍照完成 或者 选取完照片*/	
		private function mediaSelected(e:MediaEvent):void 
		{
			var mediaPromise:MediaPromise = e.data;
			var loader:Loader=new Loader();
			loader.loadFilePromise(mediaPromise);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onMediaPromiseLoaded);
			removeEvent();
		}
		
		/** 取消操作*/
		private function onCancel(event:Event):void 
		{
			trace("取消照片！");
			if(cancelCallBack != null)
			{
				cancelCallBack.call(null);
				cancelCallBack = null;
			}
			removeEvent();
		}
		
		/** 出错*/
		private function onError(event:ErrorEvent):void 
		{
			trace(event.text);
		}
		
		/** 从系统中读取照片信息*/
		private function onMediaPromiseLoaded(e:Event):void 
		{
			var loaderInfo:LoaderInfo = e.target as LoaderInfo;
			
			// 回调
			if(sureCallBack != null)
			{
				sureCallBack.call(null,loaderInfo.content);
				sureCallBack = null;
			}
			
			removeEvent();
		}
		
		/** 移除事件监听*/
		private function removeEvent():void 
		{
			if(_cameraRoll != null)
			{
				_cameraRoll.removeEventListener(MediaEvent.SELECT, mediaSelected);
				_cameraRoll.removeEventListener(Event.CANCEL, onCancel);
				_cameraRoll.removeEventListener(ErrorEvent.ERROR, onError);
			}
			if(_cameraUI != null)
			{
				_cameraUI.removeEventListener(MediaEvent.COMPLETE, mediaSelected);
				_cameraUI.removeEventListener(Event.CANCEL, onCancel);
				_cameraUI.removeEventListener(ErrorEvent.ERROR, onError);
			}
		}
		
		/** 设置回调*/
		private function SetCallBack(f:Function,c:Function):void 
		{
			sureCallBack = f;
			cancelCallBack = c;
		}
		
		/** 释放资源*/
		public function dispose():void
		{
			// TODO Auto Generated method stub
			sureCallBack = null;
			cancelCallBack = null;
			_cameraRoll = null;
			_cameraUI = null;
		}
	}
}