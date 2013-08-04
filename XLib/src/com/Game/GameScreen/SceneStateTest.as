package com.Game.GameScreen
{
	import com.core.Basic.XWorld;
	import com.Game.Globel.Constants;
	import com.core.Common.SceneManager;
	import com.core.Common.ScreenManager;
	import com.core.Common.Singleton;
	
	import feathers.controls.Button;
	import feathers.controls.Screen;
	
	import starling.events.Event;
	
	public class SceneStateTest extends Screen
	{
		
		protected var btnChageState:Button;
		protected var btnCreate:Button;
		protected var btnClose:Button;
		
		public function SceneStateTest()
		{
			super();
			init();
		}
		
		
		
		public function init():void 
		{
			// 初始化按钮
			btnCreate = new Button();
			btnCreate.label = "创建场景";
			addChild(btnCreate);
			btnCreate.addEventListener(Event.TRIGGERED, onTriggeredCreate);
			btnCreate.x = (Constants.STAGE_WIDTH - Constants.STAGE_WIDTH*0.15);
			btnCreate.y = (Constants.STAGE_HEIGHT - Constants.STAGE_HEIGHT*0.1);
			btnCreate.validate();
			addChild(btnCreate);
			
			btnChageState = new Button();
			btnChageState.label = "改变属性";
			addChild(btnChageState);
			btnChageState.addEventListener(Event.TRIGGERED, onChageState);
			btnChageState.x = btnCreate.x - Constants.STAGE_WIDTH*0.2;
			btnChageState.y = btnCreate.y;
			btnChageState.validate();
			addChild(btnChageState);

			btnClose = new Button();
			btnClose.label = "关闭";
			btnClose.x = (Constants.STAGE_WIDTH - Constants.STAGE_WIDTH*0.15);
			addChild(btnClose);
			btnClose.addEventListener(Event.TRIGGERED, onTriggeredClose);
			addChild(btnClose);
			
			
		}
		
		private function onChageState(event:Event):void
		{
			if(XWorld.instance.scene == null)
			{
				return;
			}
			
			if(XWorld.instance.scene.sceneState == 1)
			{
				XWorld.instance.scene.sceneState = 2;
			}
			else
			{
				XWorld.instance.scene.sceneState = 1;
			}

		} 
		
		private function onTriggeredCreate(event:Event):void
		{	
			XWorld.instance.enterScene("1");
		}
		
		private function onTriggeredClose(event:Event):void
		{
			ScreenManager.clearScreen();
		}
		
		
		override public function dispose():void
		{
			
		}
		
	}
}