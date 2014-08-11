package GameSystems 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	import flash.display.DisplayObjectContainer;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import GameComponents.PhysicsComponent;
	import GameEvents.CollisionEvent;
	/**
	 * Uses the Box2D Engine for physics
	 * @author Austin Shindlecker
	 */
	public class PhysicsSystem extends GameSystem
	{
		private var box2dWorld:b2World;
		
		public static var DegreePerRadian:Number = 57.2957795;
		
		public function PhysicsSystem(debugContainer:DisplayObjectContainer= null) 
		{
			box2dWorld = new b2World(new b2Vec2(0, 100), true);
			if (debugContainer)
				SetDebugDrawing(debugContainer);
		}
		
		override public function GameObjectAdded(gameObj:GameObject):void 
		{
			super.GameObjectAdded(gameObj);
			if (gameObj.Physics)
				GameObjectComponentAdded(gameObj.Id, gameObj.Physics);
		}
		
		override public function GameObjectComponentAdded(gameObjId:uint, component:GameComponent) 
		{
			super.GameObjectComponentAdded(gameObjId, component);
			
			if (component is PhysicsComponent == false)
				return;
				
			var physicsComponent:PhysicsComponent = component as PhysicsComponent;
			if (gameObjects[gameObjId] && gameObjects[gameObjId].Position)
			{
				physicsComponent.BodyDefinition.position.x = gameObjects[gameObjId].Position.X;
				physicsComponent.BodyDefinition.position.y = gameObjects[gameObjId].Position.Y;
			}
			physicsComponent.Body = box2dWorld.CreateBody(physicsComponent.BodyDefinition);
			physicsComponent.Body.CreateFixture(physicsComponent.FixtureDefinition);
			
		}
		
		override public function GameObjectComponentRemoved(gameObjId:uint, component:GameComponent) 
		{
			super.GameObjectComponentRemoved(gameObjId, component);
			
			if (component is PhysicsComponent == false)
				return;
				
			var physicsComponent:PhysicsComponent = component as PhysicsComponent;
			
			if (physicsComponent.Body)
			{
				box2dWorld.DestroyBody(physicsComponent.Body);
				physicsComponent.Body = null;
			}
		}
		
		override public function GameObjectRemoved(gameObj:GameObject):void 
		{
			super.GameObjectRemoved(gameObj);
			
			if (gameObj.Physics)
			{
				GameObjectComponentRemoved(gameObj.Id, gameObj.Physics);
			}
		}
		
		override public function Update(deltaTime:Number):void 
		{
			super.Update(deltaTime);
			
			box2dWorld.Step(1.0 / 30.0, 6, 2);
			for each(var gObject:GameObject in gameObjects)
			{
				if (!gObject || !gObject.Physics || !gObject.Position)
					continue;
				
				gObject.Position.X = gObject.Physics.Body.GetPosition().x;
				gObject.Position.Y = gObject.Physics.Body.GetPosition().y;
				
				gObject.Position.Rotation = gObject.Physics.Body.GetAngle() * DegreePerRadian;
			}
			
			box2dWorld.DrawDebugData();
		}
		
		public function SetDebugDrawing(container:DisplayObjectContainer)
		{
			var debugSprite:Sprite = new Sprite();
			container.addChild(debugSprite);
			
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			
			debugDraw.SetSprite(debugSprite);
			debugDraw.SetDrawScale(1);
			debugDraw.SetFillAlpha(.5);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit | b2DebugDraw.e_centerOfMassBit);
			box2dWorld.SetDebugDraw(debugDraw);
		}
		
		public static function GetPixelsToMeters(pixels:Number):Number { return pixels * 0.5; }
	}

}