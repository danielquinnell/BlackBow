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
		private var currentGameState:IGameState;
		private var lastUpdate:int;
		private var updateTicks:int;
		
		//Time (in milliseconds) of how delay per each game update
		//This is not directly tied to the frame rate but can (and mostly like will) be the same
		public var UpdateRate:int;
		
		public function Game(updateRate:int = 33) //Default Update Rate is 33 milliseconds (30 updates per second) 
		{
			UpdateRate = updateRate;
			currentGameState = null;
			lastUpdate = getTimer();
		}
		
		public function SetGameState(gamestate:IGameState):void
		{
			if (currentGameState != null)
			{
				currentGameState.RemovedFromMainState(this);
			}
			
			currentGameState = gamestate;
			currentGameState.AddedToMainState(this);
		}
		
		public function Update(event:Event):void
		{
			var currentTime:int = getTimer();
			updateTicks += (currentTime - lastUpdate);
			lastUpdate = currentTime;
			
			for (; updateTicks >= UpdateRate; updateTicks -= UpdateRate)
			{
				if (currentGameState != null)
				{
					currentGameState.Update(UpdateRate);
				}
			}
		}
	}

}