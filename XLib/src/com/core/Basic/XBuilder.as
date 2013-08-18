package com.core.Basic
{
	import com.Game.Globel.Constants;
	import com.core.Common.DataStruct.buildersVO;
	import com.core.Utils.File.OpenFile;
	
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	/**
	 * 
	 * @author 场景中建筑类
	 * 
	 */	
	public class XBuilder extends XSprite
	{
		private var _state:int = 0;
		private var img:Image;
		private var name:String;
		private var canMove:Boolean = false;
		
		public function XBuilder(bds:buildersVO)
		{
			super();
			var path:String = Constants.resRoot+bds.path;
			name = bds.name;
			canMove =  bds.canMove;
			var ba:ByteArray = OpenFile.open(new File(path));
			var tex:Texture = Texture.fromAtfData(ba);
			img = new Image(tex);
			
			addChild(img);
		}
		
		
		public function set State(s:int):void
		{
			this._state = s;
//			StateManager.SetBuilderState(this,s);
		}
		
		
		public function set Click(b:Boolean):void
		{
			if(b)
			{
				this.addEventListener(TouchEvent.TOUCH,onTouch);
			}
			else
			{
				this.removeEventListener(TouchEvent.TOUCH,onTouch);
			}
		}
		
		protected function onTouch(te:TouchEvent):void
		{
			te.stopPropagation();
			var touchBegin:Touch = te.getTouch(this,TouchPhase.BEGAN);
			if(touchBegin != null)
			{
				trace("builder name is " + this.name);
				return;
			}
			
			var touchMove:Touch = te.getTouch(this,TouchPhase.MOVED);
			if(canMove && touchMove != null )
			{
				trace("touchMove! builder name is " + this.name);
			}
			
			
		}
		
	}
}