package  
{
	import Box2D.Collision.b2AABB;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Scott Simpson
	 * 
	 * This runs everything.
	 * This will probably be worked on by everyone
	 * for different things. 
	 * Mostly needs to have the game loop and create 
	 * the levels and the player.
	 * 
	 */
	public class Main extends Sprite
	{
		var _userInput:UserInput = new UserInput(stage);
		var _allActors:Array;
		var _actorsToRemove:Array;
		var _enemiesHit:Array;
		
		private const STARTING_POINT:Point = new Point(323, 10);
		private var menu:Menu; //MENU
		
		public function Main() 
		{	
			//SETUP ARRAYS
			_allActors = [];
			_actorsToRemove = [];
			_enemiesHit = [];
			
			//ADD THE MENU
			menu = new Menu();
			
			menu.x = stage.width / 2;
			menu.y = stage.height / 2;
			stage.addChild(menu);
			
			//SET UP PHYSICS
			setupPhysicsWorld();
			
			//BUILD LEVEL
			createLevel();
			
			//ENTER FRAME LISTENER
			addEventListener(Event.ENTER_FRAME, newFrameListener);
		}
		
		private function newFrameListener(e:Event):void 
		{
			processUserInput();
			
			WorldVals.world.Step(1 / 30.0, 10);
			
			for each (var actor:Actor in _allActors) {
				actor.updateNow();
			}
			
			reallyRemoveActors();
			
		}
		
		public function safelyRemoveActor(actorToRemove:Actor):void 
		{
			//mark actor to be removed later
			if (_actorsToRemove.indexOf(actorToRemove) < 0) {
				_actorsToRemove.push(actorToRemove);
			}
			
		}
		
		private function reallyRemoveActors():void 
		{
			//ACTUALLY REMOVE ACTORS THAT HAVE BEEN MARKED
			for each (var removeMe:Actor in _actorsToRemove) {
				removeMe.destroy();
				
				//REMOVE IT FROM MAIN LIST OF ACTORS
				var actorIndex:int = _allActors.indexOf(removeMe);
				if (actorIndex > -1) {
					_allActors.splice(actorIndex, 1);
				}
				
			}
			
			_actorsToRemove = [];
		}
		
		private function processUserInput():void 
		{
			//CHECK FLAGS IN USERINPUT AND DO STUFF WITH THAT
			
			//TOGGLE THE MENU ON AND OFF
			if (UserInput.toggleMenu) {
				UserInput.toggleMenu = false;
				menu.toggleMenu();
			}
		}
		
		private function setupPhysicsWorld():void 
		{
			var worldBounds:b2AABB = new b2AABB();
			worldBounds.lowerBound.Set( -5000 / WorldVals.RATIO, -5000 / WorldVals.RATIO);
			worldBounds.upperBound.Set(5000 / WorldVals.RATIO, 5000 / WorldVals.RATIO);
			
			var gravity:b2Vec2 = new b2Vec2(0, 9.8);
			var allowSleep:Boolean = true;
			
			WorldVals.world = new b2World(worldBounds, gravity, allowSleep);
			WorldVals.world.SetContactListener(new ContactListener);
		}
		
		private function createLevel():void 
		{
			var newPlayer:Player = new Player(this, new Point(100, 300));
			newPlayer.addEventListener(PlayerEvent.PLAYER_OFF_SCREEN, handlePlayerOffScreen);
			_allActors.push(newPlayer);
			var newEnemy:Enemy = new Enemy(this, new Point(300, 300));
			newEnemy.addEventListener(EnemyEvent.ENEMY_HIT, handleEnemyHit);
			_allActors.push(newEnemy);
		}
		
		private function handlePlayerOffScreen(e:PlayerEvent):void 
		{
			trace("Player Off Screen");
			var playerToRemove:Player = Player(e.currentTarget);
			playerToRemove.removeEventListener(PlayerEvent.PLAYER_OFF_SCREEN, handlePlayerOffScreen);
			safelyRemoveActor(playerToRemove);
		}
		
		private function handleEnemyHit(e:EnemyEvent):void 
		{
			//RECORD THAT THE ENEMY HAS BEEN HIT
			var enemy:Enemy = Enemy(e.currentTarget);
			enemy.removeEventListener(EnemyEvent.ENEMY_HIT, handleEnemyHit);
			if (_enemiesHit.indexOf(enemy) < 0) {
				_enemiesHit.push(enemy);
			}
		}
		
	}

}