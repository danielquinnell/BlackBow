package GameSystems 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import GameComponents.PositionComponent;
	import GameComponents.RendererComponent;
	import GameEvents.GameObjectAddedEvent;
	import GameEvents.GameObjectRemovedEvent;
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class RenderingSystem implements IGameSystem
	{
		private var displayContainer:DisplayObjectContainer;
		private var gameObjects:Array;
		
		public function RenderingSystem(displaycontainer:DisplayObjectContainer, gameobjectArray:Array) 
		{
			displayContainer = displaycontainer;
			gameObjects = gameobjectArray;
		}
		
		public function Update(deltaTime:Number):void
		{
			for each (var gameobject:GameObject in gameObjects)
			{
				if (!gameobject.HasComponent(GameComponent.RENDERER) || !gameobject.HasComponent(GameComponent.POSITION))
					continue;
					
				var renderer:RendererComponent = gameobject.GetComponent(GameComponent.RENDERER) as RendererComponent;
				var position:PositionComponent = gameobject.GetComponent(GameComponent.POSITION) as PositionComponent;
				
				renderer.Display.x = position.X;
				renderer.Display.y = position.Y;
			}
		}
		
		public function AddEventListeners(dispatcher:EventDispatcher):void
		{
			dispatcher.addEventListener(GameEventTypes.GAMEOBJECT_ADDED, onGameObjectAdded);
			dispatcher.addEventListener(GameEventTypes.GAMEOBJECT_REMOVED, onGameObjectRemoved);
		}
		
		public function RemoveEventListeners(dispatcher:EventDispatcher):void
		{
			dispatcher.removeEventListener(GameEventTypes.GAMEOBJECT_ADDED, onGameObjectAdded);
			dispatcher.removeEventListener(GameEventTypes.GAMEOBJECT_REMOVED, onGameObjectRemoved);
		}
		
		private function onGameObjectAdded(event:Event):void
		{
			if (event is GameObjectAddedEvent == false)
				return;
			
			var addEvent:GameObjectAddedEvent = event as GameObjectAddedEvent;	
			
			if (addEvent.ObjectAdded.HasComponent(GameComponent.RENDERER) == false)
				return;
				
			var renderer:RendererComponent = addEvent.ObjectAdded.GetComponent(GameComponent.RENDERER) as RendererComponent;
			
			displayContainer.addChild(renderer.Display);
		}
		
		private function onGameObjectRemoved(event:Event):void
		{
			if (event is GameObjectRemovedEvent == false)
				return;
			
			var removedEvent:GameObjectRemovedEvent = event as GameObjectRemovedEvent;
			
			if (removedEvent.ObjectRemoved.HasComponent(GameComponent.RENDERER) == false)
				return;
				
			var renderer:RendererComponent = removedEvent.ObjectRemoved.GetComponent(GameComponent.RENDERER) as RendererComponent;
			displayContainer.removeChild(renderer.Display);
		}
	}

}