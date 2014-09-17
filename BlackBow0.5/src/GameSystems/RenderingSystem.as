package GameSystems 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import GameComponents.BowComponent;
	import GameComponents.CharacterComponent;
	import GameComponents.DetectionComponent;
	import GameComponents.InputCharacterComponent;
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
		
		private var aimingLine:Shape;
		private var detectionCircle:Shape;
		
		
		public function RenderingSystem(displaycontainer:DisplayObjectContainer, debug:Boolean = false) 
		{
			displayContainer = displaycontainer;
			DebugDraw = debug;
			debugRender = new Shape();
			
			aimingLine = new Shape();
			detectionCircle = new Shape();
			displayContainer.addChild(debugRender);
			displaycontainer.addChild(aimingLine);
			displaycontainer.addChild(detectionCircle);
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
			if(renderer.Display)
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
			if(renderer.Display)
				displayContainer.removeChild(renderer.Display);
		}
		
		override public function Update(deltaTime:Number):void
		{
			if (DebugDraw)
				debugRender.graphics.clear();
			
			aimingLine.graphics.clear();
			detectionCircle.graphics.clear();
			aimingLine.parent.setChildIndex(aimingLine, aimingLine.parent.numChildren - 1);
			//detectionCircle.parent.setChildIndex(detectionCircle, detectionCircle.parent.numChildren - 1);
			for each (var gameobject:GameObject in gameObjects)
			{
				if (!gameobject.Rendering || !gameobject.Position || !gameobject.Rendering.Display)
					continue;
					
				gameobject.Rendering.Display.x = gameobject.Position.X;
				gameobject.Rendering.Display.y = gameobject.Position.Y;
				gameobject.Rendering.Display.rotation = gameobject.Position.Rotation;
				gameobject.Rendering.Display.scaleX = gameobject.Rendering.ScaleX;
				gameobject.Rendering.Display.scaleY = gameobject.Rendering.ScaleY;
				
				//Player Animation
				if (gameobject.HasComponent(GameComponent.CHARACTER) && gameobject.Rendering.Display is MovieClip)
				{
					var character:CharacterComponent = gameobject.GetComponent(GameComponent.CHARACTER) as CharacterComponent;
					var movieclip:MovieClip = gameobject.Rendering.Display as MovieClip;
					
					if (character.Facing == CharacterComponent.LEFT)
					{
						if(gameobject.Rendering.ScaleX > 0)
							gameobject.Rendering.ScaleX *= -1;
					}
					else
					{
						if(gameobject.Rendering.ScaleX < 0)
							gameobject.Rendering.ScaleX *= -1;
					}
					if (character.IsMoving)
					{
						movieclip.play();
					}
					else
					{
						movieclip.gotoAndStop(0);
					}
				}
				
				//Render HUD
				
				
				//Draw detection circles
				if (gameobject.HasComponent(GameComponent.DECTECTION))
				{
					var detection:DetectionComponent = gameobject.GetComponent(GameComponent.DECTECTION) as DetectionComponent;
					detectionCircle.graphics.beginFill(0xFFFFFF, .2);
					//detectionCircle.graphics.lineStyle(.0001, 0x00);
					detectionCircle.graphics.drawCircle(gameobject.Position.X, gameobject.Position.Y, detection.CurrentRadius);
					//detectionCircle.graphics.drawCircle(gameobject.Position.X, gameobject.Position.Y, detection.CurrentRadius - 5);
					detectionCircle.graphics.endFill();
				}
				
				if (!gameobject.HasComponent(GameComponent.INPUT) || !gameobject.HasComponent(GameComponent.CHARACTER) || !gameobject.HasComponent(GameComponent.BOW))
					continue;
				
				var input:InputCharacterComponent = gameobject.GetComponent(GameComponent.INPUT) as InputCharacterComponent;
				var bow:BowComponent = gameobject.GetComponent(GameComponent.BOW) as BowComponent;
				
				
				//Draw aiming line
				var moveX:Number = gameobject.Position.X;
				var moveY:Number = gameobject.Position.Y;
				var incrementX = Math.cos(bow.Angle);
				var incrementY = Math.sin(bow.Angle);
				
				var distance = Math.abs(input.AimX - gameobject.Position.X) + Math.abs(input.AimY - gameobject.Position.Y);
				var addedDistance = 0;
				for (var i:uint = 0; i < 5; i++)
				{
					aimingLine.graphics.beginFill(0xFFFFFF,1);
					aimingLine.graphics.lineStyle(2, 0xFFFFFF);
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
				
				aimingLine.graphics.beginFill(0xFFFFFF, 1);
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
					var fletch:fletcher = new fletcher();
					return fletch;
					break;
				case ARROW:
					return new arrow();
					break;
				case "a1":
					var ret:DisplayObjectContainer = new a1b();
					ret.addChild(new a1());
					return ret;
					break;
				case "a2":
					ret = new a2b();
					ret.addChild(new a2());
					return ret;
					break;
				case "a3":
					ret = new a3b();
					ret.addChild(new a3());
					return ret;
					break;
				case "a4":
					ret = new a4b();
					ret.addChild(new a4());
					return ret;
					break;
				case "a5":
					ret = new a5b();
					ret.addChild(new a5());
					return ret;
					break;
				case "a6":
					ret = new a6b();
					ret.addChild(new a6());
					return ret;
					break;
				case "a7":
					ret = new a7b();
					ret.addChild(new a7());
					return ret;
					break;
				case "a8":
					ret = new a8b();
					ret.addChild(new a8());
					return ret;
					break;
					
				case "b1":
					ret = new b1b();
					ret.addChild(new b1());
					return ret;
					break;
					
				/*
				case "b2":
					ret = new b2b();
					ret.addChild(new b2());
					return ret;
					break;
				case "b3":
					ret = new b3b();
					ret.addChild(new b3());
					return ret;
					break;
				case "b4":
					ret = new b4b();
					ret.addChild(new b4());
					return ret;
					break;
				*/
					
				case "b5":
					ret = new b5b();
					ret.addChild(new b5());
					return ret;
					break;
				case "b6":
					ret = new b6b();
					ret.addChild(new b6());
					return ret;
					break;
				case "b7":
					ret = new b7b();
					ret.addChild(new b7());
					return ret;
					break;
				case "b8":
					ret = new b8b();
					ret.addChild(new b8());
					return ret;
					break;
				/*
				case "c1":
					ret = new c1b();
					ret.addChild(new c1());
					return ret;
					break;
				case "c2":
					ret = new c2b();
					ret.addChild(new c2());
					return ret;
					break;
				case "c3":
					ret = new c3b();
					ret.addChild(new c3());
					return ret;
					break;
				case "c4":
					ret = new c4b();
					ret.addChild(new c4());
					return ret;
					break;
				*/
				case "c5":
					ret = new c5b();
					ret.addChild(new c5());
					return ret;
					break;
				case "c6":
					ret = new c6b();
					ret.addChild(new c6());
					return ret;
					break;
				case "c7":
					ret = new c7b();
					ret.addChild(new c7());
					return ret;
					break;
				case "c8":
					ret = new c8b();
					ret.addChild(new c8());
					return ret;
					break;
					
				case "d1":
					ret = new d1b();
					ret.addChild(new d1());
					return ret;
					break;
				/*
				case "d2":
					ret = new d2b();
					ret.addChild(new d2());
					return ret;
					break;
				case "d3":
					ret = new d3b();
					ret.addChild(new d3());
					return ret;
					break;
				case "d4":
					ret = new d4b();
					ret.addChild(new d4());
					return ret;
					break;
					
				case "d5":
					ret = new d5b();
					ret.addChild(new d5());
					return ret;
					break;*/
				case "d6":
					ret = new d6b();
					ret.addChild(new d6());
					return ret;
					break;
				case "d7":
					ret = new d7b();
					ret.addChild(new d7());
					return ret;
					break;
				case "d8":
					ret = new d8b();
					ret.addChild(new d8());
					return ret;
					break;
				
				/*
				case "e1":
					ret = new e1b();
					ret.addChild(new e1());
					return ret;
					break;
				*/
				case "e2":
					ret = new e2b();
					ret.addChild(new e2());
					return ret;
					break;
				/*
				case "e3":
					ret = new e3b();
					ret.addChild(new e3());
					return ret;
					break;
				case "e4":
					ret = new e4b();
					ret.addChild(new e4());
					return ret;
					break;
				*/
				case "e5":
					ret = new e5b();
					ret.addChild(new e5());
					return ret;
					break;
				case "e6":
					ret = new e6b();
					ret.addChild(new e6());
					return ret;
					break;
				case "e7":
					ret = new e7b();
					ret.addChild(new e7());
					return ret;
					break;
				case "e8":
					ret = new e8b();
					ret.addChild(new e8());
					return ret;
					break;
				
					/*
				case "f1":
					ret = new f1b();
					ret.addChild(new f1());
					return ret;
					break;
					
				
				case "f2":
					ret = new f2b();
					ret.addChild(new f2());
					return ret;
					break;
				case "f3":
					ret = new f3b();
					ret.addChild(new f3());
					return ret;
					break;*/
				case "f4":
					ret = new f4b();
					ret.addChild(new f4());
					return ret;
					break;
				/*
				case "f5":
					ret = new f5b();
					ret.addChild(new f5());
					return ret;
					break;*/
				case "f6":
					ret = new f6b();
					ret.addChild(new f6());
					return ret;
					break;
				case "f7":
					ret = new f7b();
					ret.addChild(new f7());
					return ret;
					break;
				case "f8":
					ret = new f8b();
					ret.addChild(new f8());
					return ret;
					break;
				
				/*
				case "g1":
					ret = new g1b();
					ret.addChild(new g1());
					return ret;
					break;
					
				
				case "g2":
					ret = new g2b();
					ret.addChild(new g2());
					return ret;
					break;
				case "g3":
					ret = new g3b();
					ret.addChild(new g3());
					return ret;
					break;
				*/
				case "g4":
					ret = new g4b();
					ret.addChild(new g4());
					return ret;
					break;
					
				case "g5":
					ret = new g5b();
					ret.addChild(new g5());
					return ret;
					break;
				case "g6":
					ret = new g6b();
					ret.addChild(new g6());
					return ret;
					break;
				case "g7":
					ret = new g7b();
					ret.addChild(new g7());
					return ret;
					break;
				case "g8":
					ret = new g8b();
					ret.addChild(new g8());
					return ret;
					break;
				/*
				case "h1":
					ret = new h1b();
					ret.addChild(new h1());
					return ret;
				break;
				case "h2":
					ret = new h2b();
					ret.addChild(new h2());
					return ret;
					break;
				case "h3":
					ret = new h3b();
					ret.addChild(new h3());
					return ret;
					break;
				case "h4":
					ret = new h4b();
					ret.addChild(new h4());
					return ret;
					break;
					*/
				case "h5":
					ret = new h5b();
					ret.addChild(new h5());
					return ret;
					break;
				case "h6":
					ret = new h6b();
					ret.addChild(new h6());
					return ret;
					break;
				case "h7":
					ret = new h7b();
					ret.addChild(new h7());
					return ret;
					break;
				case "h8":
					ret = new h8b();
					ret.addChild(new h8());
					return ret;
					break;
			}
			return null;
		}
	}

}