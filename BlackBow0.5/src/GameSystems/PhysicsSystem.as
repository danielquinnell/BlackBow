package GameSystems 
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
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
		
		private var worldIsStepping:Boolean;
		private var cleanupBodies:Array;
		private var componentsToAdd:Array;
		
		protected var gameScene:GameScene;
		protected var gameObjects:Array;
		
		public static var DegreePerRadian:Number = 57.2957795;
		
		//How to scale the world down and up to meters and pixels
		public static const PixelPerMeter:Number = 32;
		
		public function PhysicsSystem(debugContainer:DisplayObjectContainer= null) 
		{
			box2dWorld = new b2World(new b2Vec2(0, 5), false);
			box2dWorld.SetContactListener(this);
			cleanupBodies =  new Array();
			componentsToAdd = new Array();
			worldIsStepping = false;
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
			
			if(worldIsStepping)
				componentsToAdd.push(component);
			else
				addComponentToBox2dWorld(component);
		}
		
		private function addComponentToBox2dWorld(component:GameComponent)
		{
			if (component is PhysicsComponent == false)
				return;
								
			var physicsComponent:PhysicsComponent = component as PhysicsComponent;
			if (gameObjects[component.ParentGameObject.Id] && gameObjects[component.ParentGameObject.Id].Position)
			{
				physicsComponent.BodyDefinition.position.x = gameObjects[component.ParentGameObject.Id].Position.X / PixelPerMeter;
				physicsComponent.BodyDefinition.position.y = gameObjects[component.ParentGameObject.Id].Position.Y / PixelPerMeter;
			}
			physicsComponent.Body = box2dWorld.CreateBody(physicsComponent.BodyDefinition);
			
			if (gameObjects[component.ParentGameObject.Id])
				physicsComponent.Body.SetUserData(gameObjects[component.ParentGameObject.Id]);	
			
			for (var i = 0; i < physicsComponent.FixtureDefinitions.length; i++)
				physicsComponent.Body.CreateFixture(physicsComponent.FixtureDefinitions[i]).SetUserData(CollisionEvent.NOTFOOT);
			
			//Create a foot fixture to send responses to detect whether or not things are "on the ground"
			var footFixture:b2FixtureDef = new b2FixtureDef();
			var footPoly:b2PolygonShape = new b2PolygonShape();
		
			footFixture.isSensor = true;
			footPoly.SetAsOrientedBox(.3, .2, new b2Vec2(0,.35));
			footFixture.shape = footPoly;
			physicsComponent.Body.CreateFixture(footFixture).SetUserData(CollisionEvent.FOOT);
		}
		
		public function GameObjectComponentRemoved(gameObjId:uint, component:GameComponent) 
		{
			if (component is PhysicsComponent == false)
				return;
				
			var physicsComponent:PhysicsComponent = component as PhysicsComponent;
			
			if (physicsComponent.Body)
			{
				cleanupBodies.push(physicsComponent.Body);
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
			while (componentsToAdd.length > 0)
			{
				var component:GameComponent = componentsToAdd.pop();
				addComponentToBox2dWorld(component);
			}
			worldIsStepping = true;
			box2dWorld.Step(1.0 / 30.0, 6, 2);
			worldIsStepping = false;
			
			for each(var gObject:GameObject in gameObjects)
			{
				if (!gObject || !gObject.Physics || !gObject.Position || !gObject.Physics.Body)
					continue;
				
				gObject.Position.X = gObject.Physics.Body.GetPosition().x * PixelPerMeter;
				gObject.Position.Y = gObject.Physics.Body.GetPosition().y * PixelPerMeter;
				
				gObject.Position.Rotation = gObject.Physics.Body.GetAngle() * DegreePerRadian;
			}
			
			while (cleanupBodies.length > 0)
			{
				var body:b2Body = cleanupBodies.pop();
				box2dWorld.DestroyBody(body);
			}
			
			box2dWorld.DrawDebugData();
		}
		
		
		override public function BeginContact(contact:b2Contact):void 
		{
			super.BeginContact(contact);
			
			var gameObject1:GameObject = contact.GetFixtureA().GetBody().GetUserData();
			var gameObject2:GameObject = contact.GetFixtureB().GetBody().GetUserData();
			
			var type1:String = contact.GetFixtureA().GetUserData();
			var type2:String = contact.GetFixtureB().GetUserData();
			
			gameScene.BroadcastEvent(new CollisionEvent(gameObject1, gameObject2, CollisionEvent.ENTER, type1, type2));
			
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
			
			var type1:String = contact.GetFixtureA().GetUserData();
			var type2:String = contact.GetFixtureB().GetUserData();
			
			gameScene.BroadcastEvent(new CollisionEvent(gameObject1, gameObject2, CollisionEvent.EXIT, type1, type2));
			
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
			debugDraw.SetDrawScale(PixelPerMeter);
			debugDraw.SetFillAlpha(.5);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit | b2DebugDraw.e_centerOfMassBit);
			box2dWorld.SetDebugDraw(debugDraw);
		}
		
		public static function GetPixelsToMeters(pixels:Number):Number { return (pixels / PixelPerMeter) / 2; }
	}
}