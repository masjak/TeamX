/**
 *	Copyright (c) 2013 Devon O. Wolfgang
 *
 *	Permission is hereby granted, free of charge, to any person obtaining a copy
 *	of this software and associated documentation files (the "Software"), to deal
 *	in the Software without restriction, including without limitation the rights
 *	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *	copies of the Software, and to permit persons to whom the Software is
 *	furnished to do so, subject to the following conditions:
 *
 *	The above copyright notice and this permission notice shall be included in
 *	all copies or substantial portions of the Software.
 *
 *	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *	THE SOFTWARE.
 */


package 
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	
	/**
	 * Entry point of particle editor
	 * @author Devon O.
	 */

	[SWF(width='1400', height='750', backgroundColor='#232323', frameRate='60')]
	public class Main extends Sprite 
	{
		
		public static var PARTICLE_SETTINGS:NullSprite;
		
		private var mStarling:Starling;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			PARTICLE_SETTINGS = new NullSprite();
			PARTICLE_SETTINGS.x = 400;
			addChild(PARTICLE_SETTINGS);
			
			initStage();
			initParticleDisplay();
		}
		
		private function initStage():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.showDefaultContextMenu = false;
		}
		
		private function initParticleDisplay():void {
			mStarling = new Starling(ParticleDisplay, stage, new Rectangle(0, 0, 400, 500));
			mStarling.antiAliasing = 4;
			mStarling.stage.color = 0x000000;
			mStarling.enableErrorChecking = false;
			mStarling.start();
		}
		
	}
	
}