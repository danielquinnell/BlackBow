package GameSystems 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
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
		
		public var DebugDraw:Boolean;
		
		private var debugRender:Shape;
		
		public function RenderingSystem(displaycontainer:DisplayObjectContainer, debug:Boolean = false) 
		{
			displayContainer = displaycontainer;
			DebugDraw = debug;
			debugRender = new Shape();
			
			displayContainer.addChild(debugRender);
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
			if (!gameObj.Rendering)
				return;
				
			GameObjectComponentAdded(gameObj.Id, gameObj.Rendering);
		}
		
		override public function GameObjectComponentAdded(gameObjId:uint, component:GameComponent) 
		{
			super.GameObjectComponentAdded(gameObjId, component);
			if (component.Type != GameComponent.RENDERER)
			{
				return;
			}
			
			var renderer:RendererComponent = component as RendererComponent;
			renderer.Display = DisplayObjectFactory(renderer.DisplayType);
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
			if (DebugDraw)
				debugRender.graphics.clear();
			
			for each (var gameobject:GameObject in gameObjects)
			{
				if (!gameobject.Rendering || !gameobject.Position)
					continue;
					
				gameobject.Rendering.Display.x = gameobject.Position.X;
				gameobject.Rendering.Display.y = gameobject.Position.Y;
				gameobject.Rendering.Display.rotation = gameobject.Position.Rotation;
				
				if (!DebugDraw)
					continue;
			}
			
			
			if (DebugDraw)
				debugRender.graphics.endFill();
		}
		
		public static const PLAYER:String = "player";
		public static const ARROW:String = "arrow";
		
		//Takes a String and returns a DisplayObject accordingly. String is most likely the DisplayType member of a RenderingComponent
		public static function DisplayObjectFactory(displayType:String):DisplayObject
		{
			switch(displayType)
			{
				case PLAYER:
					return new PlayerSprite();
					break;
				case ARROW:
					return new ArrowSprite();
					break;
			}
			return null;
		}
	}

}