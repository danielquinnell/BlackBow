package  
{
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public interface IGameSystem 
	{
		function Update(deltaTime:Number):void;
		
		function SetGameScene(gamescene:GameScene):void;
		function Initialize(gameobjects:Array):void;
		
		function GameObjectComponentRemoved(gameObjId:uint, component:GameComponent);
		function GameObjectComponentAdded(gameObjId:uint, component:GameComponent);
		
		function GameObjectRemoved(gameObj:GameObject):void;
		function GameObjectAdded(gameObj:GameObject):void;
		
		//Some systems listen to events made from other parts of the game (like other systems!)
		//This function lets the system listen for the events it cares about
		function AddEventListeners(dispatcher:EventDispatcher):void; 
		
		//Systems should remove the event types they're listening to when they're done
		function RemoveEventListeners(dispatcher:EventDispatcher):void; 
	}
}