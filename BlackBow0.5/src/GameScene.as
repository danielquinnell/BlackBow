package  
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import GameEvents.GameObjectAddedEvent;
	import GameEvents.GameObjectRemovedEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	/**
	 * Manages all GameObjects and GameSystems
	 * Used to create GameObjects, broadcast GameObject events and changes
	 * @author Austin Shindlecker
	 */
	public class GameScene extends EventDispatcher
	{
		private var gameObjects:Array;
		private var freedIds:Array;	//An array of usable ids for new gameobjects to own
		private var gameSystems:Array;
		
		public function GameScene() 
		{
			freedIds = new Array();
			gameObjects = new Array();
			gameSystems = new Array();
		}
		
		public function GameObjectCount():int
		{
			return gameObjects.length;
		}
		
		public function RegisterEvents(dispatcher:EventDispatcher)
		{
			dispatcher.addEventListener(KeyboardEvent.KEY_DOWN, BroadcastEvent);
			dispatcher.addEventListener(KeyboardEvent.KEY_UP, BroadcastEvent);
			dispatcher.addEventListener(MouseEvent.MOUSE_DOWN, BroadcastEvent);
			dispatcher.addEventListener(MouseEvent.MOUSE_UP, BroadcastEvent);
			dispatcher.addEventListener(MouseEvent.MOUSE_MOVE, BroadcastEvent);
		}
		
		public function RemoveEvents(dispatcher:EventDispatcher)
		{
			dispatcher.removeEventListener(KeyboardEvent.KEY_DOWN, BroadcastEvent);
			dispatcher.removeEventListener(KeyboardEvent.KEY_UP, BroadcastEvent);
			dispatcher.removeEventListener(MouseEvent.MOUSE_DOWN, BroadcastEvent);
			dispatcher.removeEventListener(MouseEvent.MOUSE_UP, BroadcastEvent);
			dispatcher.removeEventListener(MouseEvent.MOUSE_MOVE, BroadcastEvent);
		}
		
		public function AddGameSystem(system:IGameSystem)
		{
			gameSystems.push(system);
			system.SetGameScene(this);
			system.Initialize(gameObjects);
			system.AddEventListeners(this);
		}
		
		public function RemoveGameSystem(system:IGameSystem)
		{
			system.RemoveEventListeners(this);
			delete gameSystems[gameSystems.indexOf(system)];
		}
		
		public function AddComponent(objectId:uint, component:GameComponent):void
		{
			gameObjects[objectId]._scenePushComponentToDictionary(component);
			for each(var system:IGameSystem in gameSystems)
			{
				system.GameObjectComponentAdded(objectId, component);
			}
		}
		
		public function RemoveComponent(objectId:uint, component:GameComponent):void
		{
			gameObjects[objectId]._sceneRemoveComponentFromDictionary(component);
			for each(var system:IGameSystem in gameSystems)
			{
				system.GameObjectComponentRemoved(objectId, component);
			}
		}
		
		public function ClearScene()
		{
			for each(var gObject:GameObject in gameObjects)
			{
				RemoveGameObject(gObject);
			}
		}
		
		public function AddGameObject(gameObject:GameObject):void
		{
			gameObject.gameScene = this;
			
			var id:uint = gameObjects.length;
			
			if (freedIds.length > 0)
			{
				id = freedIds.pop();
			}
			
			gameObject.Id = id;
			gameObjects[id] = gameObject;
			
			dispatchEvent(new GameObjectAddedEvent(gameObject));
			
			for each(var system:IGameSystem in gameSystems)
			{
				system.GameObjectAdded(gameObject);
			}
		}
		
		public function CreateGameObject():GameObject
		{
			var newGameObject:GameObject = new GameObject(this, 0);
			AddGameObject(newGameObject);
			
			return newGameObject;
		}
		
		public function RemoveGameObject(gameobject:GameObject):void
		{
			if (gameObjects[gameobject.Id] == null)
				return;	//Game Object is not associated with this scene
				
			dispatchEvent(new GameObjectRemovedEvent(gameObjects[gameobject.Id]));
			for each(var system:IGameSystem in gameSystems)
			{
				system.GameObjectRemoved(gameObjects[gameobject.Id]);
			}
			
			if (gameobject.IsChild)
			{
				if (gameObjects[gameobject.ParentId] != null)
				{
					gameObjects[gameobject.ParentId].RemoveChild(gameobject);
				}
			}
			
			for each(var child:GameObject in gameobject.GetChildren())
			{
				if (child)
				{
					RemoveGameObject(child);
				}
			}
			
			delete gameObjects[gameobject.Id];
			freedIds.push(gameobject.Id);	//there's a free spot where this entity used to be to be taken
		}
		
		public function UpdateSystems(delta:Number)
		{
			for each(var system:IGameSystem in gameSystems)
			{
				system.Update(delta);
			}
		}
		
		public function BroadcastEvent(event:Event)
		{
			dispatchEvent(event);
		}
	}

}