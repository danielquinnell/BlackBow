package GameStates 
{
	import Box2D.Common.Math.b2Vec2;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
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
		
		private var xmlObjectLoader:URLLoader;
		
		public function MainGameState(mainViewContainer:DisplayObjectContainer) 
		{
			Mouse.hide();
			
			gameScene = new GameScene();
			gameScene.RegisterEvents(mainViewContainer.stage);
			
			//Add game systems for functionality
			gameScene.AddGameSystem(new RenderingSystem(mainViewContainer, true));
			gameScene.AddGameSystem(new PhysicsSystem(mainViewContainer));
			gameScene.AddGameSystem(new InputSystem());
			gameScene.AddGameSystem(new CharacterSystem());
			gameScene.AddGameSystem(new BowSystem());
			gameScene.AddGameSystem(new ProjectileSystem());
			
			levelPhysicsData = new PhysicsData();
			levelXId = 0;
			levelYId = 0;
			
			//Load XML Object Data
			xmlObjectLoader = new URLLoader(new URLRequest("./resources/Data/GameObjects.xml"));
			xmlObjectLoader.addEventListener(Event.COMPLETE, onXMLObjectLoad);
		}
		
		private function setLevel(levelString:String)
		{
			gameScene.ClearScene();
			level = gameScene.CreateGameObject();
			level.AddComponent(levelPhysicsData.createComponent(levelString));
			level.Tag = "level";
			gameScene.AddGameObject(player);
		}
		
		private function getLevelString(x:Number, y:Number):String
		{
			x += 49; //'1' in DEC
			y += 97; //'a' in DEC
			
			return String.fromCharCode(y) + String.fromCharCode(x);
		}
		
		private function onXMLObjectLoad(event:Event)
		{
			XmlCache.LoadXML(new XML(xmlObjectLoader.data));
			
			//Create player from XML data loaded and cached
			player = XmlCache.CreateGameObject("player", gameScene, true, 790, 100);
			player.AddComponent(new BowComponent());
			//Allow the player to be controllable
			player.AddComponent(new InputCharacterComponent());
			
			setLevel(getLevelString(levelXId,levelYId));
		}
		
		public function Update(delta:Number):void
		{
			gameScene.UpdateSystems(delta);
			
			//Check if player is out of bounds (and switch levels if they are)
			if (player && player.Position.X > 800)
			{
				levelXId++;
				setLevel(getLevelString(levelXId, levelYId));
				player.Position.SetX(0 + 10);
			}
			if (player && player.Position.X < 0)
			{
				levelXId--;
				setLevel(getLevelString(levelXId, levelYId));
				player.Position.SetX(800 - 10);
			}if (player && player.Position.Y > 600)
			{
				levelYId++;
				setLevel(getLevelString(levelXId, levelYId));
				player.Position.SetY(0 + 10);
			}
			if (player && player.Position.Y < 0)
			{
				levelYId--;
				setLevel(getLevelString(levelXId, levelYId));
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