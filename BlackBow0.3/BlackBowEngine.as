package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.display.DisplayObject;
	import com.coreyoneil.collision.CollisionList;
	import flash.events.MouseEvent;
	
	public class BlackBowEngine extends MovieClip{
		private var anArrow:Arrow;
		private var aim:aim_mc;
		private var arrowReady:Boolean = false;
		private var shotAngle:Number;
		private var shotVel:Number;
		private var maxShotVel:Number = 30;
		private var shotDeltaX:Number;
		private var shotDeltaY:Number;
		
		public var player:Player;
		
		//collision stuff
		//public var _objects			:Array;
		public var _collisionList	:CollisionList;
		private var IMMOVABLE		:int = 10000;
		
		//view
		private var view:View;
		
		//Controls
		public var controls:Controls;
		
		//Physics
		private var physics:PhysicsObject;
		
		//sound
		public var bgm:Sound = new BGM();
		public var channel:SoundChannel = new SoundChannel();
		
		//level number
		private var lvl:int = 0;
		
		public function BlackBowEngine() {
			init();
		}
		
		private function init(){
			buildGame();
			this.addEventListener(Event.ENTER_FRAME, gameLoop);
			//sound
			channel = bgm.play();
			channel.addEventListener(Event.SOUND_COMPLETE, loopMusic);
		}
		
		private function buildGame(){
			//view
			view = new View;
			view.buildLevel(lvl);
			this.addChild(view);			
			_collisionList = new CollisionList(view.lvlbg);
			//_objects = [];
			//player
			player = new Player;
			player.mass = IMMOVABLE * 2;
			//player.addEventListener(MouseEvent.MOUSE_DOWN, nockArrow);
			//player.addEventListener(MouseEvent.MOUSE_UP, shoot);
			//_objects.push(player);
			view.viewContainer.addChild(player);
			_collisionList.addItem(player);
			//arrow
			anArrow = new Arrow;
			view.viewContainer.addChild(anArrow);
			_collisionList.addItem(anArrow);
			aim = new aim_mc;
			view.viewContainer.addChild(aim);
			//controls
			controls = new Controls;
			controls.graphics.beginFill(0x000000, .1);
			controls.graphics.drawRect(0,0,(1600),1200);
			this.addChild(controls);
		}
		
		private function gameLoop(e:Event){
			player.updatePlayer(controls.leftClickDown, controls.leftKeyDown, controls.rightKeyDown, controls.upKeyDown, controls.downKeyDown);
			player.updatePos();
			updatePhysics();
			shooting();
		}
		
		private function loopMusic(e:Event){
			channel = bgm.play();
		}
		
		private function nockArrow(){
			arrowReady = true;
			trace('nocked');
		}
		
		private function shoot(){
			arrowReady = false;
			trace('Fire!');
			anArrow.shot = true;
			anArrow.x = player.x;
			anArrow.y = player.y;
			anArrow.init(shotAngle, shotVel);
		}
		
		private function shooting(){
			anArrow.updatePos();
			anArrow.updateArrow();
			anArrow.fall();
			if(controls.leftClickDown == true){
				nockArrow();
				shotDeltaX = (mouseX - player.x);
				shotDeltaY = (mouseY - player.y)
				shotAngle = 180*Math.atan(shotDeltaY/shotDeltaX)/Math.PI;
				trace('angle = ' + shotAngle);
				shotVel = Math.sqrt((shotDeltaY * shotDeltaY)+(shotDeltaX * shotDeltaX));
				if(shotVel > maxShotVel){shotVel = maxShotVel};
				trace('vel = ' + shotVel);
				aim.x = player.x;
				aim.y = player.y;
				aim.width = shotVel;
				aim.rotation = shotAngle;
				aim.visible = true;
			}
			if(arrowReady == true && controls.leftClickDown == false){
				shoot();
				aim.visible = false;
			}
		}
		
		private function updatePhysics(){
			trace('player touchingGround = ' + player.touchingGround);
			trace('arrow touchingGround = ' + anArrow.touchingGround);
			var collisions:Array = _collisionList.checkCollisions();
			player.touchingGround = false;
			anArrow.touchingGround = false;
			for(var i:uint = 0; i < collisions.length; i++)   
			{
				trace("Information for collision " + i);
				trace("_________________________");
				trace(collisions[i].object1);   
				trace(collisions[i].object2);
				trace(collisions[i].angle); 
				trace(collisions[i].overlap + "\n");
				//collisions[i].object1.touchingGround = true;

				if(collisions[i].object1 == player){
					player.touchingGround = true;
	
					var collision:Object = collisions[i];
					var angle:Number = collision.angle;
					var overlap:int = collision.overlapping.length;
					
					var sin:Number = Math.sin(angle);
					var cos:Number = Math.cos(angle);
					
					var vx0:Number = player.vX * cos + player.vY * sin;
					var vy0:Number = player.vY * cos - player.vX * sin;
					
					// Unlike the other examples, here I'm choosing to calculate the amount
					// of bounce based on the objects' masses, with a default mass of 10000 (IMMOVABLE)
					// being used for the drawing the wheel is colliding with.  As such, the only
					// real variable in play here is the current vector of the wheel.
					vx0 = ((player.mass - IMMOVABLE) * vx0) / (player.mass + IMMOVABLE);
					player.vX = vx0 * cos - vy0 * sin;
					player.vY = vy0 * cos + vx0 * sin;
					
					player.vX -= cos * overlap /player.radius;
					player.vY -= sin * overlap / player.radius;
					
					//player.vx += _speed;
				//}else{
					//player.touchingGround = false;
				}
				if(collisions[i].object1 == anArrow){
					anArrow.touchingGround = true;
					anArrow.vX = 0;
					anArrow.vY = 0;
				}
			}
			
			if(player.x > stage.stageWidth){
				player.x = 20;
				player.y = stage.stageHeight / 2;
				lvl ++;
				view.changeLevel(lvl);
				_collisionList.swapTarget(view.lvlbg);
				view.viewContainer.addChild(player);
			}
			if(player.x < 0){
				if(lvl > 0){
					player.x = stage.stageWidth - 20;
					//fix next line later
					player.y = stage.stageHeight / 2;
					lvl --;
					view.changeLevel(lvl);
					_collisionList.swapTarget(view.lvlbg);
					view.viewContainer.addChild(player);
				}else{ 
					player.x = 0;
				}
			}									
			if(player.y > stage.stageHeight) player.y = stage.stageHeight;
			if(player.y < 0) player.y = 0;
			
		}

	}
	
}
