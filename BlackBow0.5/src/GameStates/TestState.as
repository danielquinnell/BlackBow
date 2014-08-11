package GameStates 
{
	import Box2D.Collision.b2Bound;
	import Box2D.Dynamics.b2Body;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import GameComponents.PhysicsComponent;
	import GameComponents.PositionComponent;
	import GameComponents.RendererComponent;
	import GameComponents.VelocityComponent;
	import GameEvents.CollisionEvent;
	import GameSystems.PhysicsSystem;
	import GameSystems.RenderingSystem;
	import GameSystems.TransformSystem;
	import Math;
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class TestState implements IGameState
	{
		private var mainDisplayContainer:DisplayObjectContainer;
		private var gameScene:GameScene;
		
		private var counterToRemove:Number;
		
		private var testPlayer:GameObject;
		
		private var testRemoveChild:GameObject;
		
		public function TestState(maindisplay:DisplayObjectContainer, x:int = 0, y:int = 0) 
		{
			mainDisplayContainer = maindisplay;
			counterToRemove = 0;
			
			gameScene = new GameScene();
			gameScene.addEventListener(GameEventTypes.COLLISION, debugCollisionOutput);

			gameScene.AddGameSystem(new TransformSystem());
			gameScene.AddGameSystem(new RenderingSystem(mainDisplayContainer, true));
			gameScene.AddGameSystem(new PhysicsSystem(mainDisplayContainer as Sprite));
			
			testPlayer = gameScene.CreateGameObject();
			testPlayer.AddComponent(new PositionComponent(170, 100));
			testPlayer.AddComponent(new RendererComponent(new PlayerSprite()));
			testPlayer.AddComponent(new PhysicsComponent(PhysicsSystem.GetPixelsToMeters(testPlayer.Rendering.Display.width), PhysicsSystem.GetPixelsToMeters(testPlayer.Rendering.Display.height)));
			
			var ground:GameObject = gameScene.CreateGameObject();
			ground.AddComponent(new RendererComponent(new GroundSprite()));
			ground.AddComponent(new PositionComponent(450, 300));
			ground.AddComponent(new PhysicsComponent(PhysicsSystem.GetPixelsToMeters(ground.Rendering.Display.width), PhysicsSystem.GetPixelsToMeters(ground.Rendering.Display.height), b2Body.b2_staticBody));
			ground.Physics.BodyDefinition.type = b2Body.b2_staticBody;
			
			testPlayer.Rendering.Display.addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		private function debugCollisionOutput(ev:Event)
		{
			var collisionEvent:CollisionEvent = ev as CollisionEvent;
			trace("TEST STATE LISTENER: " + collisionEvent.Object1.Id + " " + collisionEvent.Object2.Id);
			collisionEvent.Object1.RemoveFromScene();
			
			if (counterToRemove < 1)
			{
				return;
			}
			counterToRemove = 0
			for (var i = 0; i < 1; i++)
			{
			var add:GameObject = gameScene.CreateGameObject();
			add.AddComponent(new PositionComponent(170 + (i * 50), 100));
			add.AddComponent(new RendererComponent(new PlayerSprite()));
			add.AddComponent(new PhysicsComponent(PhysicsSystem.GetPixelsToMeters(add.Rendering.Display.width), PhysicsSystem.GetPixelsToMeters(add.Rendering.Display.height)));
			}
		}
		
		public function Update(deltaTime:Number):void
		{
			gameScene.UpdateSystems(deltaTime);
			counterToRemove += deltaTime;
		}
		
		private function onMouseClick(event:Event)
		{	
		}
		
		public function Pause():void
		{
			//Do Nothing for now in this test
		}
		
		public function Unpause():void
		{
			//Do Nothing for now in this test
		}
		
		public function AddedToStateStack(manager:GameStateManager):void
		{
			//Do Nothing for now in this test
		}
		
		public function RemovedFromStateStack(manager:GameStateManager):void
		{
			//Do Nothing for now in this test
		}
	}

}