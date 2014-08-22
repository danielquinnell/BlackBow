package GameStates 
{
	import Box2D.Collision.b2Bound;
	import Box2D.Dynamics.b2Body;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import GameComponents.CharacterComponent;
	import GameComponents.InputCharacterComponent;
	import GameComponents.PhysicsComponent;
	import GameComponents.PositionComponent;
	import GameComponents.RendererComponent;
	import GameEvents.CollisionEvent;
	import GameSystems.BowSystem;
	import GameSystems.CharacterSystem;
	import GameSystems.InputSystem;
	import GameSystems.PhysicsSystem;
	import GameSystems.RenderingSystem;
	import GameSystems.TransformSystem;
	import Math;
	import flash.events.KeyboardEvent;
	import GameComponents.BowComponent;
	import PhysicsData;
	
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
		
		private var loader:URLLoader;
		
		public function TestState(maindisplay:DisplayObjectContainer, x:int = 0, y:int = 0) 
		{
			mainDisplayContainer = maindisplay;
			counterToRemove = 0;
			
			gameScene = new GameScene();
			gameScene.RegisterEvents(mainDisplayContainer.stage);

			gameScene.AddGameSystem(new TransformSystem());
			gameScene.AddGameSystem(new RenderingSystem(mainDisplayContainer, true));
			gameScene.AddGameSystem(new PhysicsSystem(mainDisplayContainer as Sprite));
			gameScene.AddGameSystem(new CharacterSystem());
			gameScene.AddGameSystem(new BowSystem());
			gameScene.AddGameSystem(new InputSystem());
			
			testPlayer = gameScene.CreateGameObject();
			testPlayer.AddComponent(new PositionComponent(100, 300));
			testPlayer.AddComponent(new RendererComponent(RenderingSystem.PLAYER));
			testPlayer.Rendering.Display.scaleX *= 2/3;
			testPlayer.Rendering.Display.scaleY *= 2/3;
			testPlayer.AddComponent(new PhysicsComponent(PhysicsSystem.GetPixelsToMeters(testPlayer.Rendering.Display.width) * testPlayer.Rendering.Display.scaleX, PhysicsSystem.GetPixelsToMeters(testPlayer.Rendering.Display.height)* testPlayer.Rendering.Display.scaleY));
			
			testPlayer.AddComponent(new CharacterComponent(1, false));
			testPlayer.AddComponent(new InputCharacterComponent());
			testPlayer.AddComponent(new BowComponent());
			testPlayer.Physics.Body.SetFixedRotation(true);
			
			var level:GameObject = gameScene.CreateGameObject();
			level.AddComponent(new PositionComponent(0, 0));
			level.AddComponent(new PhysicsData().createComponent("d7"));
			
			mainDisplayContainer.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);			
			mainDisplayContainer.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			mainDisplayContainer.scaleX = 1;
			mainDisplayContainer.scaleY = 1;
			
			loader = new URLLoader(new URLRequest("./resources/Data/GameObjects.xml"));
			loader.addEventListener(Event.COMPLETE, onXmlLoad);
		}
		
		private function onXmlLoad(event:Event)
		{
			var xml:XML = new XML(loader.data);
			XmlCache.LoadXML(xml);
		}
				
		public function Update(deltaTime:Number):void
		{
			gameScene.UpdateSystems(deltaTime);
			counterToRemove += deltaTime;
		} 
		
		public function onKeyDown(event:KeyboardEvent)
		{
			if (event.keyCode != Keyboard.SPACE)
				return;
				
			var character:CharacterComponent = testPlayer.GetComponent(GameComponent.CHARACTER) as CharacterComponent;
			character.PrimaryActionState = true;
		}
		
		public function onKeyUp(event:KeyboardEvent)
		{
			if (event.keyCode != Keyboard.SPACE)
				return;
				
			var character:CharacterComponent = testPlayer.GetComponent(GameComponent.CHARACTER) as CharacterComponent;
			character.PrimaryActionState = false;
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