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
		var _player:Player;
		var _inventory:int = 10;
		var _arrowReady:Boolean = false;
		
		private const STARTING_POINT:Point = new Point(323, 10);
		private const LAUNCH_POINT:Point = new Point(323, 10);
		private const LAUNCH_VELOCITY:Number = 300.0;
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
			
			_player.update();
			
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
			
			if (UserInput.leftClick) {
				readyArrow();
			} else if (_arrowReady) {
				fireArrow();
			}
		}
		
		private function fireArrow():void 
		{
			_arrowReady = false;
			
			var direction:Point = new Point(mouseX, mouseY).subtract(LAUNCH_POINT);
			direction.normalize(LAUNCH_VELOCITY);
			
			var newArrow:Arrow = new Arrow(this, LAUNCH_POINT, direction);
			newArrow.addEventListener(ArrowEvent.ARROW_OFF_SCREEN, handleArrowOffScreen);
			_allActors.push(newArrow);
			
			trace(_inventory + " arrows left");
			
		}
		
		private function handleArrowOffScreen(e:ArrowEvent):void 
		{
			trace("Arrow Off Screen");
			var arrowToRemove:Arrow = Arrow(e.currentTarget);
			arrowToRemove.removeEventListener(ArrowEvent.ARROW_OFF_SCREEN, handleArrowOffScreen);
			safelyRemoveActor(arrowToRemove);
		}
		
		private function readyArrow():void 
		{
			if (!_arrowReady) {
				if (_inventory >= 1) {
					_arrowReady = true;
					_inventory--;
				}
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
			var newGround:Ground = new Ground(this, new Point(0, 400));
			_allActors.push(newGround);
			_player = new Player(this, new Point(100, 200));
			_player.addEventListener(PlayerEvent.PLAYER_OFF_SCREEN, handlePlayerOffScreen);
			_allActors.push(_player);
			var newEnemy:Enemy = new Enemy(this, new Point(300, 200));
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