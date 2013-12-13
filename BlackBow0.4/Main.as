package  
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.b2DistanceJoint;
	import Box2D.Dynamics.Joints.b2DistanceJointDef;
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
		var _inventory:int = 30;
		var _arrowReady:Boolean = false;
		
		private const STARTING_POINT:Point = new Point(323, 10);
		//private const LAUNCH_POINT:Point = new Point(323, 10);
		private const LAUNCH_VELOCITY:Number = 300.0;
		private var menu:Menu; //MENU
		private var arrowIndicator:ArrowIndicator;
		private var isHooked:Boolean = false;
		private var distanceJoint:b2DistanceJoint;
		
		//player
		private static const speed:Number = 2 / WorldVals.RATIO;
		private static const maxVel:Number = 3;
		private static const jumpHeight:int = 1;
		public static var falling:Boolean = true;
		
		
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
			
			debugDraw();
		}
		
		private function newFrameListener(e:Event):void 
		{
			processUserInput();
			
			WorldVals.world.Step(1 / 30.0, 10, 10);
			WorldVals.world.ClearForces();
			
			for each (var actor:Actor in _allActors) {
				actor.updateNow();
			}
			
			reallyRemoveActors();
			
			WorldVals.world.DrawDebugData();
			
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
		
		private function destroyRope():void
		{
			if (distanceJoint)
			{
				WorldVals.world.DestroyJoint(distanceJoint);
				trace("DESTROY");
				isHooked = false;
			}
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
			
			if (UserInput.shift) {
				UserInput.shift = false;
				arrowIndicator.switchType();
				destroyRope();
			}
			
			if (_player.getFacing() == "Left" && mouseX > _player.getLocation().x)
			{
				_player.aboutFace();
				trace("About Face");
			} else if (_player.getFacing() == "Right" && mouseX < _player.getLocation().x) 
			{
				_player.aboutFace();
				trace("About Face");
			}
			
			var body = _player.getBody();
			
			if (UserInput.left)
			{
				if (body.GetLinearVelocity().x >= -maxVel)
				{
					//Body.WakeUp();//WAKES BODY UP IF IT IS SLEEPING
					body.ApplyImpulse(new b2Vec2( -speed, 0.0), body.GetWorldCenter()); //ADDS TO THE LINEARVELOCITY OF THE BOX.
				}
			}
			if (UserInput.right)
			{
				if (body.GetLinearVelocity().x <= maxVel)
				{
					//Body.WakeUp();//WAKES BODY UP IF IT IS SLEEPING
					body.ApplyImpulse(new b2Vec2(speed, 0.0), body.GetWorldCenter()); //ADDS TO THE LINEARVELOCITY OF THE BOX.
				}
			}
			if (UserInput.up)
			{
				if (!isHooked)
				{
					if (body.GetLinearVelocity().y > -1 && !falling)
					{ //Stops player from jumping while falling
						
						//change this so if player's feet are touching anything, allow jump
						//set falling to true in ContactListener
						
						falling = true;
						
						body.ApplyImpulse(new b2Vec2(0.0, -jumpHeight), body.GetWorldCenter()); //Applys and impuls to the player. (Makes it jump)
						
					}
				}else if (isHooked)
				{
					manageRope();
				}
			}
		}
		
		private function fireArrow():void 
		{
			_arrowReady = false;
			
			destroyRope();
			
			var shootingPoint:Point = _player.getLocation();
			var direction:Point = new Point(mouseX, mouseY).subtract(shootingPoint);
			direction.normalize(LAUNCH_VELOCITY);
			
			var newArrow:Arrow = new Arrow(this, shootingPoint, direction, arrowIndicator.arrowType);
			newArrow.addEventListener(ArrowEvent.ARROW_OFF_SCREEN, handleArrowOffScreen);
			newArrow.addEventListener(ArrowEvent.ARROW_ATTACHED, handleArrowAttached);
			_allActors.push(newArrow);
			
			trace(_inventory + " arrows left");
			
		}
		
		private function handleArrowAttached(e:ArrowEvent):void
		{
			trace("MAKING ROPE");
			var arrowAttached:Arrow = Arrow(e.currentTarget);
			arrowAttached.removeEventListener(ArrowEvent.ARROW_ATTACHED, handleArrowAttached);
			arrowAttached.removeEventListener(ArrowEvent.ARROW_OFF_SCREEN, handleArrowOffScreen);
			
			var distanceJointDef:b2DistanceJointDef = new b2DistanceJointDef();
			var playerBody:b2Body = _player.getBody();
            distanceJointDef.Initialize(playerBody, arrowAttached.getBody(), playerBody.GetWorldCenter(), new b2Vec2(arrowAttached.getLocation().x / WorldVals.RATIO, arrowAttached.getLocation().x / WorldVals.RATIO));
            distanceJointDef.collideConnected = true;
            distanceJoint = WorldVals.world.CreateJoint(distanceJointDef) as b2DistanceJoint;
            isHooked = true;
		}
		
		private function manageRope():void
		{
            if (isHooked) {
                if (UserInput.up)
				{
					distanceJoint.SetLength(distanceJoint.GetLength()*0.99);
				}
				if (UserInput.down)
				{
					distanceJoint.SetLength(distanceJoint.GetLength()*1.01);
				}
            }
        }
		
		private function handleArrowOffScreen(e:ArrowEvent):void 
		{
			trace("Arrow Off Screen");
			var arrowToRemove:Arrow = Arrow(e.currentTarget);
			if (arrowToRemove.pickedUp) {
				_inventory++;
			}
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
			//var worldBounds:b2AABB = new b2AABB();
			//worldBounds.lowerBound.Set( -5000 / WorldVals.RATIO, -5000 / WorldVals.RATIO);
			//worldBounds.upperBound.Set(5000 / WorldVals.RATIO, 5000 / WorldVals.RATIO);
			
			var gravity:b2Vec2 = new b2Vec2(0, 9.8);
			var allowSleep:Boolean = true;
			
			//WorldVals.world = new b2World(worldBounds, gravity, allowSleep);
			WorldVals.world = new b2World(gravity, allowSleep);
			WorldVals.world.SetContactListener(new ContactListener);
		}
		
		private function createLevel():void 
		{
			//var newGround:Ground = new Ground(this, new Point(275, 390));
			var newGround:Ground = new Ground(this, new Point(275, 300));
			_allActors.push(newGround);
			newGround = new Ground(this, new Point(275, 100));
			_allActors.push(newGround);
			_player = new Player(this, new Point(100, 200));
			_player.addEventListener(PlayerEvent.PLAYER_OFF_SCREEN, handlePlayerOffScreen);
			_allActors.push(_player);
			var newEnemy:Enemy = new Enemy(this, new Point(300, 200));
			newEnemy.addEventListener(EnemyEvent.ENEMY_HIT, handleEnemyHit);
			_allActors.push(newEnemy);
			arrowIndicator = new ArrowIndicator(this, new Point(68, 34));
			stage.addChild(arrowIndicator);
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
		
		 private function debugDraw():void {
            var debugDraw:b2DebugDraw=new b2DebugDraw();
            var debugSprite:Sprite=new Sprite();
            addChild(debugSprite);
            debugDraw.SetSprite(debugSprite);
            debugDraw.SetDrawScale(WorldVals.RATIO);
            debugDraw.SetFlags(b2DebugDraw.e_shapeBit|b2DebugDraw.e_jointBit);
            debugDraw.SetFillAlpha(0.5);
            WorldVals.world.SetDebugDraw(debugDraw);
        }
		
	}

}