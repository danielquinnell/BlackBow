package  
{
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class Game 
	{
		public var StateManager:GameStateManager;
		private var lastUpdate:int;
		private var updateTicks:int;
		
		//Time (in milliseconds) of how delay per each game update
		//This is not directly tied to the frame rate but can (and mostly like will) be the same
		public var UpdateRate:int;
		
		public function Game(updateRate:int = 33) //Default Update Rate is 33 milliseconds (30 updates per second) 
		{
			StateManager = new GameStateManager();
			lastUpdate = getTimer();
			UpdateRate = updateRate;
		}
		
		public function SetFrontGameState(gamestate:IGameState):void
		{
			StateManager.AddStateToFront(gamestate);
		}
		
		public function Update(event:Event):void
		{
			var currentTime:int = getTimer();
			updateTicks += (currentTime - lastUpdate);
			lastUpdate = currentTime;
			
			for (; updateTicks >= UpdateRate; updateTicks -= UpdateRate)
			{
				StateManager.UpdateAllStates(UpdateRate);
			}
		}
	}

}