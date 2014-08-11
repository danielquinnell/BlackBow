package GameStates 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import GameComponents.CollisionComponent;
	import GameComponents.PositionComponent;
	import GameComponents.RendererComponent;
	import GameComponents.VelocityComponent;
	import GameEvents.CollisionEvent;
	import GameSystems.CollisionSystem;
	import GameSystems.MovementSystem;
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
		
		public function TestState(maindisplay:DisplayObjectContainer, x:int = 0, y:int = 0) 
		{
			mainDisplayContainer = maindisplay;
			gameScene = new GameScene();
			
			
			testPlayer = gameScene.CreateGameObject();
			
			testPlayer.AddComponent(new RendererComponent(new PlayerSprite()));
			testPlayer.AddComponent(new PositionComponent(100,100));
			//testPlayer.AddComponent(new VelocityComponent(5,1));
			testPlayer.AddComponent(new CollisionComponent(testPlayer.Rendering.Display.width, testPlayer.Rendering.Display.height));
			trace(testPlayer.Collision.Width);trace(testPlayer.Collision.Height);
			for (var i:int = 0; i < 10; i++)
			{
				var add:GameObject = gameScene.CreateGameObject();
				add.AddComponent(new RendererComponent(new PlayerSprite()));
				add.AddComponent(new PositionComponent(10 + (i * 30), 10 + (i*30)));
				add.AddComponent(new CollisionComponent(add.Rendering.Display.width, add.Rendering.Display.height));
				testPlayer.AddChild(add);
			}
			
			counterToRemove = 0;
			
			gameScene.AddGameSystem(new MovementSystem());
			gameScene.AddGameSystem(new RenderingSystem(maindisplay, true));
			gameScene.AddGameSystem(new CollisionSystem());
			gameScene.AddGameSystem(new TransformSystem());
			
			gameScene.addEventListener(GameEventTypes.COLLISION, debugCollisionOutput);
		}
		
		private function debugCollisionOutput(ev:Event)
		{
			var collisionEvent:CollisionEvent = ev as CollisionEvent;
			//trace(collisionEvent.Object1.Id + " " + collisionEvent.Object2.Id);
		}
		
		public function Update(deltaTime:Number):void
		{
			gameScene.UpdateSystems(deltaTime);
			
			counterToRemove += deltaTime;
			if (counterToRemove >= .1)
			{
				counterToRemove = 0;
				testPlayer.RemoveFromScene();
				
				PositionComponent(testPlayer.GetComponent(GameComponent.POSITION)).X = 100;
				PositionComponent(testPlayer.GetComponent(GameComponent.POSITION)).Y = 100;
				
				gameScene.AddGameObject(testPlayer);
				
				for (var i:int = 0; i < 5; i++)
				{
					var add:GameObject = gameScene.CreateGameObject();
					add.AddComponent(new RendererComponent(new PlayerSprite()));
					add.AddComponent(new PositionComponent(30 + (i * 30), 30 + (i*30)));
					add.AddComponent(new CollisionComponent(add.Rendering.Display.width, add.Rendering.Display.height));
					testPlayer.AddChild(add);
				}
				
			}
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