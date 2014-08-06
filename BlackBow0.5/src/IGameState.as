package  
{
	
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public interface IGameState 
	{
		function Update(deltaTime: int):void;
		function Unpause():void;
		function Pause():void;
		
		function AddedToStateStack(statemanager:GameStateManager):void;
		function RemovedFromStateStack(statemanager:GameStateManager):void;
	}
	
}