package GameSystems 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import GameComponents.BowComponent;
	import GameComponents.InputCharacterComponent;
	import GameComponents.PositionComponent;
	import GameComponents.RendererComponent;
	import GameEvents.GameObjectAddedEvent;
	import GameEvents.GameObjectRemovedEvent;
	import levels_fla.MainTimeline;
	import levels_fla.rat_18;
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class RenderingSystem extends GameSystem
	{
		private var displayContainer:DisplayObjectContainer;
		
		public var DebugDraw:Boolean;
		
		private var debugRender:Shape;
		
		private var aimingLine:Shape;
		
		
		public function RenderingSystem(displaycontainer:DisplayObjectContainer, debug:Boolean = false) 
		{
			displayContainer = displaycontainer;
			DebugDraw = debug;
			debugRender = new Shape();
			
			aimingLine = new Shape();
			displayContainer.addChild(debugRender);
			displaycontainer.addChild(aimingLine);
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
				gameobject.Rendering.Display.scaleX = gameobject.Rendering.ScaleX;
				gameobject.Rendering.Display.scaleY = gameobject.Rendering.ScaleX;
				
				//Render HUD
				if (!gameobject.HasComponent(GameComponent.INPUT) || !gameobject.HasComponent(GameComponent.CHARACTER) || !gameobject.HasComponent(GameComponent.BOW))
					continue;
				
				var input:InputCharacterComponent = gameobject.GetComponent(GameComponent.INPUT) as InputCharacterComponent;
				var bow:BowComponent = gameobject.GetComponent(GameComponent.BOW) as BowComponent;
				
				aimingLine.graphics.clear();
				var moveX:Number = gameobject.Position.X;
				var moveY:Number = gameobject.Position.Y;
				var incrementX = Math.cos(bow.Angle);
				var incrementY = Math.sin(bow.Angle);
				
				var distance = Math.abs(input.AimX - gameobject.Position.X) + Math.abs(input.AimY - gameobject.Position.Y);
				var addedDistance = 0;
				for (var i:uint = 0; i < 5; i++)
				{
					aimingLine.graphics.lineStyle(2);
					aimingLine.graphics.beginFill(0xFFFFFF,1);
					aimingLine.graphics.moveTo(moveX, moveY);
					aimingLine.graphics.lineTo(moveX + incrementX * 15, moveY - incrementY * 15);
					aimingLine.graphics.endFill();
					moveX += incrementX * 30;
					moveY -= incrementY * 30;
					
					addedDistance += Math.abs(incrementX * 30);
					addedDistance += Math.abs(incrementY * 30);
					
					if (addedDistance >= distance)
						break;
				}
				
				//Draw Crosshair
				const crosshairSize:Number = 10;
				const crosshairSpace:Number = 5;
				
				aimingLine.graphics.beginFill(0xFFFFFF,1);
				aimingLine.graphics.moveTo(input.AimX, input.AimY - crosshairSpace);
				aimingLine.graphics.lineTo(input.AimX, input.AimY - crosshairSize);
				aimingLine.graphics.endFill();
				
				aimingLine.graphics.beginFill(0xFFFFFF,1);
				aimingLine.graphics.moveTo(input.AimX, input.AimY + crosshairSpace);
				aimingLine.graphics.lineTo(input.AimX, input.AimY + crosshairSize);
				aimingLine.graphics.endFill();
				
				aimingLine.graphics.beginFill(0xFFFFFF,1);
				aimingLine.graphics.moveTo(input.AimX - crosshairSpace, input.AimY);
				aimingLine.graphics.lineTo(input.AimX - crosshairSize, input.AimY);
				aimingLine.graphics.endFill();
				
				aimingLine.graphics.beginFill(0xFFFFFF,1);
				aimingLine.graphics.moveTo(input.AimX + crosshairSpace, input.AimY);
				aimingLine.graphics.lineTo(input.AimX + crosshairSize, input.AimY);
				aimingLine.graphics.endFill();
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
				default:
					break;
			}
			return null;
		}
	}

}