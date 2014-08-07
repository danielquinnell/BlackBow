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
		
		private var counterToRemove:Number;
		
		private var testPlayer:GameObject;
		
		public function TestState(maindisplay:DisplayObjectContainer, x:int = 0, y:int = 0) 
		{
			mainDisplayContainer = maindisplay;
			gameScene = new GameScene();
			
			
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
			}
			
			counterToRemove = 0;
			
			gameScene.AddGameSystem(new MovementSystem());
			gameScene.AddGameSystem(new RenderingSystem(maindisplay));
		}
		
		public function Update(deltaTime:Number):void
		{
			gameScene.UpdateSystems(deltaTime);
			
			counterToRemove += deltaTime;
			if (counterToRemove >= 1)
			{
				counterToRemove = 0;
				testPlayer.RemoveFromScene();
				
				PositionComponent(testPlayer.GetComponent(GameComponent.POSITION)).X = 100;
				PositionComponent(testPlayer.GetComponent(GameComponent.POSITION)).Y = 100;
				
				gameScene.AddGameObject(testPlayer);
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