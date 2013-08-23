package com.core.Basic
{
	import com.Game.Globel.Constants;
	import com.core.Common.BuilderManager;
	import com.core.Common.SceneManager;
	import com.core.Common.Singleton;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.VideoLoader;
	import com.greensock.loading.XMLLoader;
	
	import flash.system.System;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class XGame extends Sprite
	{	
//		/**主舞台*/
		protected var xStage:XStage;
		protected var xmlLoader:XMLLoader;
		
		public function XGame()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			init();
		}
		
		private function init():void 
		{
			LoaderMax.activate([ImageLoader, SWFLoader, VideoLoader,XMLLoader]); 
			xmlLoader = new XMLLoader(Constants.resRoot + "/initData.xml", { onComplete:completeHandler, estimatedBytes:50000,onProgress:progressHandler } );
			xmlLoader.load();
			
//			// 始化屏幕管理	
//			ScreenManager.init();
			
			xStage =new XStage;
			addChild(xStage);
		
			
			
		}
		
		private function progressHandler(event:LoaderEvent):void 
		{ 
			trace("progress:" +  event.target.progress); 
		}
		
		private function completeHandler(event:LoaderEvent):void 
		{ 
			// 加载初始化配置表
			var loader:XMLLoader = LoaderMax.getLoader("Constants");
			Constants.readXml(loader.content);
			System.disposeXML(loader.content);
			
			// 加载场景列表
			loader = LoaderMax.getLoader("sceneConfig");
			SceneManager.readXml(loader.content);
			
			// 加载建筑列表
			loader = LoaderMax.getLoader("builders");
			Singleton.builders.readXml(loader.content);
			
			// 加载灯光列表
			loader = LoaderMax.getLoader("lights");
			Singleton.lights.readXml(loader.content);
			
			// 加载单位列表
			loader = LoaderMax.getLoader("units");
			//			SceneManager.readXml(loader.content);
			
			System.disposeXML(loader.content);
			
			// 加载配置完成之后释放所有资源
			xmlLoader.dispose();
		} 
		
		
	}
}