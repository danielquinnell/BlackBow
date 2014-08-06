package  
{
	/**
	 * Handles the GameState Stack for updating multiple states and shifting around states at a time
	 * @author Austin Shindlecker
	 */
	public class GameStateManager 
	{
		private var stateStack:Array;
		
		public function GameStateManager() 
		{
			stateStack = new Array();
		}
		
		public function AddStateToFront(state:IGameState):void
		{
			stateStack.splice(0, 0, state);
		}
		
		//Adds state to the bottom of the stack and returns it's placement ID
		public function AddStateToBack(state:IGameState):int
		{
			stateStack.push(state);
			return stateStack.length - 1;
		}
		
		public function PopState():IGameState
		{
			var popped:IGameState =  stateStack.pop();
			popped.RemovedFromStateStack(this);
			
			return popped;
		}
		
		public function SwapStates(objectAId:*, objectBId:*):void
		{
			var aId:int = -1;
			var bId:int = -1;
			if (objectAId is int && objectBId is int)
			{
				aId = objectAId;
				bId = objectBId;
			}
			else if (objectAId is IGameState && objectBId is IGameState)
			{
				aId = stateStack.indexOf(aId);
				bId = stateStack.indexOf(bId);
			}
			
			var temp:IGameState = stateStack[aId];
			stateStack[aId] = stateStack[bId];
			stateStack[bId] = temp;
		}
		
		//Moves a state from the fromId to the toId placement. All states after the toId is pushed to the back by 1
		public function MoveState(fromId:*, toId:int):void
		{
			if(fromId is int)
				stateStack.splice(toId, 0, stateStack[fromId]);
			else if(fromId is IGameState)
				stateStack.splice(toId, 0, stateStack[stateStack.indexOf(fromId)]);
		}
		
		public function UpdateAllStates(deltaTime:int):void
		{
			for each (var state:IGameState in stateStack)
			{
				state.Update(deltaTime);
			}
		}
	}

}