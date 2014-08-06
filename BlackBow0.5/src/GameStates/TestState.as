package GameStates 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class TestState implements IGameState
	{
		private var mainDisplayContainer:DisplayObjectContainer;
		private var updateRateText:TextField;
		private var updateRateCounter:int;
		
		public function TestState(maindisplay:DisplayObjectContainer) 
		{
			mainDisplayContainer = maindisplay;
			updateRateText = new TextField();
			updateRateCounter = 0;
			
			mainDisplayContainer.addChild(updateRateText);
		}
		
		public function Update(deltaTime:int):void
		{
			updateRateCounter++;
			updateRateText.text = updateRateCounter.toString();
		}
		
		public function Pause():void
		{
			//Do Nothing for now in this test
		}
		
		public function Unpause():void
		{
			//Do Nothing for now in this test
		}
		
		public function AddedToMainState(game:Game):void
		{
			//Do Nothing for now in this test
		}
		
		public function RemovedFromMainState(game:Game):void
		{
			//Do Nothing for now in this test
		}
	}

}