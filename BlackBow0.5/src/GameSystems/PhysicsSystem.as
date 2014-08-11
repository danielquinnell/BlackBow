package GameSystems 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Contacts.b2Contact;
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
	public class PhysicsSystem extends b2ContactListener implements IGameSystem
	{
		private var box2dWorld:b2World;
		
		protected var gameScene:GameScene;
		protected var gameObjects:Array;
		
		public static var DegreePerRadian:Number = 57.2957795;
		
		public function PhysicsSystem(debugContainer:DisplayObjectContainer= null) 
		{
			box2dWorld = new b2World(new b2Vec2(0, 100), true);
			box2dWorld.SetContactListener(this);
			if (debugContainer)
				SetDebugDrawing(debugContainer);
		}
		
		public function SetGameScene(gamescene:GameScene):void { gameScene = gamescene; }
		
		public function Initialize(gameobjects:Array):void 
		{
			gameObjects = gameobjects;
			for each(var gameobj:GameObject in gameObjects)
			{
				GameObjectAdded(gameobj);
			}
		}
		
		public function AddEventListeners(dispatcher:EventDispatcher):void {}
		public function RemoveEventListeners(dispatcher:EventDispatcher):void {}
		
		public function GameObjectAdded(gameObj:GameObject):void 
		{
			if (gameObj.Physics)
				GameObjectComponentAdded(gameObj.Id, gameObj.Physics);
		}
		
		public function GameObjectComponentAdded(gameObjId:uint, component:GameComponent) 
		{
			if (component is PhysicsComponent == false)
				return;
				
			var physicsComponent:PhysicsComponent = component as PhysicsComponent;
			if (gameObjects[gameObjId] && gameObjects[gameObjId].Position)
			{
				physicsComponent.BodyDefinition.position.x = gameObjects[gameObjId].Position.X;
				physicsComponent.BodyDefinition.position.y = gameObjects[gameObjId].Position.Y;
			}
			physicsComponent.Body = box2dWorld.CreateBody(physicsComponent.BodyDefinition);
			
			if (gameObjects[gameObjId])
				physicsComponent.Body.SetUserData(gameObjects[gameObjId]);
				
			physicsComponent.Body.CreateFixture(physicsComponent.FixtureDefinition);
			
		}
		
		public function GameObjectComponentRemoved(gameObjId:uint, component:GameComponent) 
		{
			if (component is PhysicsComponent == false)
				return;
				
			var physicsComponent:PhysicsComponent = component as PhysicsComponent;
			
			if (physicsComponent.Body)
			{
				box2dWorld.DestroyBody(physicsComponent.Body);
				physicsComponent.Body = null;
			}
		}
		
		public function GameObjectRemoved(gameObj:GameObject):void 
		{
			if (gameObj.Physics)
			{
				GameObjectComponentRemoved(gameObj.Id, gameObj.Physics);
			}
		}
		
		public function Update(deltaTime:Number):void 
		{
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
		
		
		override public function BeginContact(contact:b2Contact):void 
		{
			super.BeginContact(contact);
			
			var gameObject1:GameObject = contact.GetFixtureA().GetBody().GetUserData();
			var gameObject2:GameObject = contact.GetFixtureB().GetBody().GetUserData();
			
			gameScene.BroadcastEvent(new CollisionEvent(gameObject1, gameObject2));
			
			if (gameObject1.Physics.CollisionEnterCallback)
				gameObject1.Physics.CollisionEnterCallback(gameObject2);
			if (gameObject2.Physics.CollisionEnterCallback)
				gameObject2.Physics.CollisionEnterCallback(gameObject1);
		}
		
		override public function EndContact(contact:b2Contact):void 
		{
			super.EndContact(contact);
			
			var gameObject1:GameObject = contact.GetFixtureA().GetBody().GetUserData();
			var gameObject2:GameObject = contact.GetFixtureB().GetBody().GetUserData();
			
			if (gameObject1.Physics.CollisionExitCallback)
				gameObject1.Physics.CollisionExitCallback(gameObject2);
			if (gameObject2.Physics.CollisionExitCallback)
				gameObject2.Physics.CollisionExitCallback(gameObject1);
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