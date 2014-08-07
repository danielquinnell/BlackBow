package GameStates 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import GameComponents.PositionComponent;
	import GameComponents.RendererComponent;
	import GameSystems.RenderingSystem;
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class TestState implements IGameState
	{
		private var mainDisplayContainer:DisplayObjectContainer;
		private var gameObjectManager:GameObjectManager;
		private var rendering:RenderingSystem;
		private var gameObjects:Array;
		
		
		public function TestState(maindisplay:DisplayObjectContainer, x:int = 0, y:int = 0) 
		{
			mainDisplayContainer = maindisplay;
			gameObjects = new Array();
			gameObjectManager = new GameObjectManager(gameObjects);
			rendering = new RenderingSystem(maindisplay, gameObjects);
			
			rendering.AddEventListeners(gameObjectManager);
			
			var testPlayer:GameObject = new GameObject();
			testPlayer.AddComponent(new RendererComponent());
			testPlayer.AddComponent(new PositionComponent());
			RendererComponent(testPlayer.GetComponent(GameComponent.RENDERER)).Display = new PlayerSprite();
			PositionComponent(testPlayer.GetComponent(GameComponent.POSITION)).X = 100;
			PositionComponent(testPlayer.GetComponent(GameComponent.POSITION)).Y = 100;
			
			gameObjectManager.AddGameObject(testPlayer);
		}
		
		public function Update(deltaTime:int):void
		{
			rendering.Update(deltaTime);
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