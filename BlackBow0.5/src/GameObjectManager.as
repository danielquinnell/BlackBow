package  
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import GameEvents.GameObjectAddedEvent;
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class GameObjectManager extends EventDispatcher
	{
		private var gameObjects:Array;
		
		public function GameObjectManager(gameObjectArray:Array) 
		{
			gameObjects = gameObjectArray;
		}
		
		public function AddGameObject(gobject:GameObject):void
		{
			gobject.Id = gameObjects.length;
			gameObjects[gameObjects.length] = gobject;
			dispatchEvent(new GameObjectAddedEvent(gobject));
		}
		
		public function RemoveGameObject(gobject:*):void
		{
			var objectId:int = -1;
			
			if (gobject is int)
				objectId = gobject;
			else if (gobject is GameObject)
				objectId = gameObjects.indexOf(gobject);
				
			gameObjects[objectId] = null;
		}
	}

}