package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.*;
	import flash.utils.getTimer;
	import GameStates.TestState;
	
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class Main extends Sprite 
	{
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);  
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var game:Game = new Game();
			game.SetFrontGameState(new TestState(this, 100, 100));
			game.StateManager.AddStateToBack(new TestState(this, 20, 20));
			
			addEventListener(Event.ENTER_FRAME, game.Update);
		}
	}
	
}