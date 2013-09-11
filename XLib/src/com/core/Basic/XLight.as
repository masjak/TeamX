package com.core.Basic
{
	import com.Game.Globel.Constants;
	import com.core.Common.DataStruct.LightsVO;
	import com.core.Utils.File.OpenFile;
	
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	
	import starling.display.Image;
	import starling.textures.Texture;

	/**
	 * 
	 * @author 场景中灯光
	 * 
	 */	
	public class XLight extends XPSprite
	{
	
		private var _body:Image;				// 建筑生成后的显示图
		private var _lo:LightsVO;
		
		public function XLight(lvo:LightsVO)
		{
			super();
			_lo = lvo;
			
			var path:String = Constants.resRoot+lvo.path;
			var ba:ByteArray = OpenFile.open(new File(path));
			var tex:Texture = Texture.fromAtfData(ba);
			_body = new Image(tex);
			
			addChild(_body);
		}
		
		/*** 销毁 */		
		override public function dispose():void
		{
			_lo = null;
			_body.dispose();
		}
		
	}
}