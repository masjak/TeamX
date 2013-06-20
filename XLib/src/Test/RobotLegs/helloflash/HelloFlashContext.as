/*
 * Copyright (c) 2009 the original author or authors
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package Test.RobotLegs.helloflash
{
	import flash.display.DisplayObjectContainer;
	
	import Test.RobotLegs.helloflash.controller.CreateBallCommand;
	import Test.RobotLegs.helloflash.controller.HelloFlashEvent;
	import Test.RobotLegs.helloflash.model.StatsModel;
	import Test.RobotLegs.helloflash.view.Ball;
	import Test.RobotLegs.helloflash.view.BallMediator;
	import Test.RobotLegs.helloflash.view.Readout;
	import Test.RobotLegs.helloflash.view.ReadoutMediator;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	
	public class HelloFlashContext extends Context
	{
		public function HelloFlashContext(contextView:DisplayObjectContainer)
		{
			super(contextView);
		}
		
		override public function startup():void
		{
			// Map some Commands to Events
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, CreateBallCommand, ContextEvent, true);
			commandMap.mapEvent(HelloFlashEvent.BALL_CLICKED, CreateBallCommand, HelloFlashEvent );
			
			// Create a rule for Dependency Injection
//			injector.mapSingleton(StatsModel);
			
			injector.mapClass(StatsModel,StatsModel);
			
			// Here we bind Mediator Classes to View Classes:
			// Mediators will be created automatically when
			// view instances arrive on stage (anywhere inside the context view)
			mediatorMap.mapView(Ball, BallMediator);
			mediatorMap.mapView(Readout, ReadoutMediator);
			
			// Manually add something to stage
			contextView.addChild(new Readout());
			
			// And we're done
			super.startup();
		}
	
	}
}