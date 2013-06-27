package com.Game
{
	import Test.Scene.ResManager;
	
	import dragonBones.Armature;
	
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class StarlingGameTest extends Sprite
	{
		private var knight:Armature;
		private var cyborg:Armature;
		private var dargon:Armature;
		
		/**feathers UI 主题 */		
		protected var theme:MetalWorksMobileTheme;
		
		public function StarlingGameTest()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			theme = new MetalWorksMobileTheme(this.stage);
			test();
		}
		
		private function test():void 
		{
			addscene();
			addBtn();
			
		}

		private function addBtn():void 
		{
			var btn:Button = new Button();
			btn.label = "Click Me";
			btn.validate();
			addChild(btn);
			
			//center the button
			btn.x = (stage.stageWidth -btn.width) / 2;
			btn.y = (stage.stageHeight - btn.height) / 2;
			
			btn.addEventListener(Event.TRIGGERED, button_triggeredHandler);
			
			function button_triggeredHandler(event:Event):void
			{
				const label:Label = new Label();
				label.text = "Hi, I'm Feathers!\nHave a nice day.";
				Callout.show(label, btn);
			}
		}
		
		private function addscene():void 
		{	
			ResManager.initBlock();
			for(var i:int = 0; i < 10; i++)
			{
				var name:String = "block" + (i%7 +1);
				var img:Image = ResManager.getImageByName(name);
				img.x = 100*i;
				addChild(img);
			}
			
		}
	}
}