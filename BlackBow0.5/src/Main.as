package 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.*;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	import GameEvents.GameObjectAddedEvent;
	import GameEvents.GameObjectRemovedEvent;
	import GameStates.MainGameState;
	import GameStates.TestState;
	import GameSystems.RenderingSystem;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	[SWF(backgroundColor="0x999999")]
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
			var game:Game = new Game(33);
			
			//Set second parameter to 'true' for debug drawing, 'false' for non debug drawing
			game.SetFrontGameState(new MainGameState(this, true));
			
			addEventListener(Event.ENTER_FRAME, game.Update);
		}
	}
	
}