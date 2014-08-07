package GameStates 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import GameComponents.PositionComponent;
	import GameComponents.RendererComponent;
	import GameComponents.VelocityComponent;
	import GameSystems.MovementSystem;
	import GameSystems.RenderingSystem;
	import Math;
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class TestState implements IGameState
	{
		private var mainDisplayContainer:DisplayObjectContainer;
		private var gameScene:GameScene;
		
		private var rendering:RenderingSystem;
		private var movement:MovementSystem;
		
		private var counterToRemove:Number;
		
		private var testPlayer:GameObject;
		
		public function TestState(maindisplay:DisplayObjectContainer, x:int = 0, y:int = 0) 
		{
			mainDisplayContainer = maindisplay;
			gameScene = new GameScene();
			
			rendering = new RenderingSystem(maindisplay);
			movement = new MovementSystem();
			gameScene.AddGameSystem(rendering);
			gameScene.AddGameSystem(movement);
			
			testPlayer = gameScene.CreateGameObject();
			
			testPlayer.AddComponent(new RendererComponent(new PlayerSprite()));
			testPlayer.AddComponent(new PositionComponent(100,100));
			testPlayer.AddComponent(new VelocityComponent(30, 30));
			
			for (var i:int = 0; i < 10; i++)
			{
				var add:GameObject = gameScene.CreateGameObject();
				add.AddComponent(new RendererComponent(new PlayerSprite()));
				add.AddComponent(new PositionComponent(100,100));
				add.AddComponent(new VelocityComponent(Math.random() * 50, Math.random() * 50));
				trace(add.Id);
			}
			
			counterToRemove = 0;
		}
		
		public function Update(deltaTime:Number):void
		{
			movement.Update(deltaTime);
			rendering.Update(deltaTime);
			
			counterToRemove += deltaTime;
			if (counterToRemove >= 1)
			{
				counterToRemove = 0;
				testPlayer.RemoveFromScene();
				
				PositionComponent(testPlayer.GetComponent(GameComponent.POSITION)).X = 100;
				PositionComponent(testPlayer.GetComponent(GameComponent.POSITION)).Y = 100;
				
				gameScene.AddGameObject(testPlayer);
				
				trace(testPlayer.Id);
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