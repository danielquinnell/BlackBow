package  {
	
	import flash.display.MovieClip;
	
	public class PhysicsObject extends MovieClip{
		//larger gravity faster fall
		public var gravity:int = 1;
		//friction must be > 1, larger makes things slow down faster
		public var friction:int = 2
		public var vX:int = 0;
		public var vY:int = 0;
		private var speed:int = 5;
		public var touchingGround:Boolean = false;
		
		public function PhysicsObject() {
			// constructor code
		}
		
		public function fall(){
			vY += gravity;
		}
		
		public function updatePos(){
			y += vY;
			x += vX;
		}
		
		public function stopMoving(){
			//if object has significant vel
			if ((vX > (0.001)) || (vX < (-0.001))){
				vX /= friction;
			} else {
				vX = 0;
			}
		}
		
		public function moveLeft(){
			vX = (speed * -1);
		}
		
		public function moveRight(){
			vX = speed;
		}

	}
	
}
