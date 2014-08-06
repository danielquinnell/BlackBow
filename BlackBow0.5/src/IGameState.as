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
		
		function AddedToMainState(game:Game):void;
		function RemovedFromMainState(game:Game):void;
	}
	
}