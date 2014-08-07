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
	public class RenderingSystem extends GameSystem
	{
		private var displayContainer:DisplayObjectContainer;
		private var gameObjects:Array;
		
		public function RenderingSystem(displaycontainer:DisplayObjectContainer) 
		{
			displayContainer = displaycontainer;
		}
		
		override public function Initialize(gameobjects:Array):void 
		{
			super.Initialize(gameobjects);
			gameObjects = gameobjects;
		}
		
		override public function GameObjectRemoved(gameObj:GameObject):void
		{
			super.GameObjectRemoved(gameObj);
			
			if (gameObj.HasComponent(GameComponent.RENDERER) == false)
				return;
				
			GameObjectComponentRemoved(gameObj.Id, gameObj.GetComponent(GameComponent.RENDERER));
		}
		
		override public function GameObjectAdded(gameObj:GameObject):void 
		{
			super.GameObjectAdded(gameObj);
			if (gameObj.HasComponent(GameComponent.RENDERER) == false)
				return;
				
			GameObjectComponentAdded(gameObj.Id, gameObj.GetComponent(GameComponent.RENDERER));
		}
		
		override public function GameObjectComponentAdded(gameObjId:uint, component:GameComponent) 
		{
			super.GameObjectComponentAdded(gameObjId, component);
			if (component.Type != GameComponent.RENDERER)
			{
				return;
			}
			
			var renderer:RendererComponent = component as RendererComponent;
			displayContainer.addChild(renderer.Display);
		}
		
		override public function GameObjectComponentRemoved(gameObjId:uint, component:GameComponent) 
		{
			super.GameObjectComponentRemoved(gameObjId, component);
			if (component.Type != GameComponent.RENDERER)
			{
				return;
			}
			
			var renderer:RendererComponent = component as RendererComponent;
			displayContainer.removeChild(renderer.Display);
		}
		
		override public function Update(deltaTime:Number):void
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
	}

}