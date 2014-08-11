package GameSystems 
{
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
			
			var debugTrace:String = "";
			for each (var gameobject:GameObject in gameObjects)
			{
				if (!gameobject.Rendering || !gameobject.Position)
					continue;
					
				gameobject.Rendering.Display.x = gameobject.Position.X;
				gameobject.Rendering.Display.y = gameobject.Position.Y;
				
				if (!DebugDraw)
					continue;
				
				if (!gameobject.Collision)
					continue;
				
				debugTrace += "[" + gameobject.Id + "] " + gameobject.Position.X + ":" + gameobject.Position.Y + " | ";
				
				debugRender.graphics.beginFill(0xFF0000, 0.5);
				debugRender.graphics.drawRect(gameobject.Position.X - (gameobject.Collision.Width/2), gameobject.Position.Y - (gameobject.Collision.Height/2), gameobject.Collision.Width, gameobject.Collision.Height);
			}
			
			//trace(debugTrace);
			
			if (DebugDraw)
				debugRender.graphics.endFill();
		}
	}

}