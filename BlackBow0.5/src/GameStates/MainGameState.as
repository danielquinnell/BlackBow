package GameStates 
{
	import Box2D.Common.Math.b2Vec2;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.engine.RenderingMode;
	import GameComponents.BowComponent;
	import GameComponents.CharacterComponent;
	import GameComponents.InputCharacterComponent;
	import GameComponents.PositionComponent;
	import GameComponents.RendererComponent;
	import GameSystems.BowSystem;
	import GameSystems.CharacterSystem;
	import GameSystems.InputSystem;
	import GameSystems.PhysicsSystem;
	import GameSystems.ProjectileSystem;
	import GameSystems.RenderingSystem;
	import flash.ui.Mouse;
	
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class MainGameState implements IGameState
	{
		private var gameScene:GameScene;
		private var player:GameObject;
		
		private var levelPhysicsData:PhysicsData;
		private var levelArray:Array;
		
		private var levelXId:int;
		private var levelYId:int;
		
		private var level:GameObject;
		
		public function MainGameState(mainViewContainer:DisplayObjectContainer, debugMode:Boolean) 
		{
			Mouse.hide();
			
			gameScene = new GameScene();
			gameScene.RegisterEvents(mainViewContainer.stage);
			 
			//Add game systems for functionality
			gameScene.AddGameSystem(new RenderingSystem(mainViewContainer, debugMode));
			if(debugMode)
				gameScene.AddGameSystem(new PhysicsSystem(mainViewContainer));
			else
				gameScene.AddGameSystem(new PhysicsSystem());
				
			gameScene.AddGameSystem(new InputSystem(mainViewContainer.stage));
			gameScene.AddGameSystem(new CharacterSystem());
			gameScene.AddGameSystem(new BowSystem());
			gameScene.AddGameSystem(new ProjectileSystem());
			
			levelPhysicsData = new PhysicsData();
			levelXId = 0;
			levelYId = 0;
			
			//Create player from XML data loaded and cached
			XmlCache.LoadXMLEmbed();
			player = XmlCache.CreateGameObject("player", gameScene, true, 790, 100);
			player.AddComponent(new BowComponent());
			//Allow the player to be controllable
			player.AddComponent(new InputCharacterComponent());
			
			setLevel(getLevelString(levelXId, levelYId));
		}
		
		private function setLevel(levelString:String)
		{
			var physicsComponent = levelPhysicsData.createComponent(levelString); 
			if (!physicsComponent)
				return false;
				
			gameScene.ClearScene();
			level = gameScene.CreateGameObject();
			level.AddComponent(physicsComponent);
			level.Tag = "level";
			
			var levelBackground:GameObject = gameScene.CreateGameObject();
			levelBackground.AddComponent(new RendererComponent(getLevelString(levelXId, levelYId)));
			levelBackground.AddComponent(new PositionComponent(400, 300));
			levelBackground.Rendering.ScaleX = 1;
			levelBackground.Rendering.ScaleY = 1;
			
			trace(getLevelString(levelXId, levelYId));
			gameScene.AddGameObject(player);
			return true;
		}
		
		private function getLevelString(x:Number, y:Number):String
		{
			x += 49; //'1' in DEC
			y += 97; //'a' in DEC
			
			return String.fromCharCode(y) + String.fromCharCode(x);
		}
		
		public function Update(delta:Number):void
		{
			gameScene.UpdateSystems(delta);
			
			//Check if player is out of bounds (and switch levels if they are)
			if (player && player.Position.X > 800)
			{
				levelXId++;
				if(setLevel(getLevelString(levelXId, levelYId)))
				player.Position.SetX(0 + 10);
			}
			if (player && player.Position.X < 0)
			{
				levelXId--;
				if(setLevel(getLevelString(levelXId, levelYId)))
				player.Position.SetX(800 - 10);
			}if (player && player.Position.Y > 600)
			{
				levelYId++;
				if(setLevel(getLevelString(levelXId, levelYId)))
				player.Position.SetY(0 + 10);
			}
			if (player && player.Position.Y < 0)
			{
				levelYId--;
				if(setLevel(getLevelString(levelXId, levelYId)))
				player.Position.SetY(600 - 10);
			}
		}
		
		public function Pause():void
		{
			//Do Nothing for now 
		}
		
		public function Unpause():void
		{
			//Do Nothing for now 
		}
		
		public function AddedToStateStack(manager:GameStateManager):void
		{
			//Do Nothing for now 
		}
		
		public function RemovedFromStateStack(manager:GameStateManager):void
		{
			//Do Nothing for now 
		}
	}

}