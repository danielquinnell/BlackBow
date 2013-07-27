package  {
	
	public class Player extends PhysicsObject{
		
		public var radius:Number = height / 2;
		
		public var mass:Number = radius * 4;
		
		private var jumpHeight:int = 5;
		
//		//key booleans
//		//key held down to display tool select menu
//		public var toolsKeyDown:Boolean = false;
//		//move char left and right
//		public var leftKeyDown:Boolean = false;
//		public var rightKeyDown:Boolean = false;
//		//move up and down on rope, possibly other thiings as well
//		public var upKeyDown:Boolean = false;
//		public var downKeyDown:Boolean = false;
//		//hold space to move map
//		public var spaceKeyDown:Boolean = false;
//		//mouse click boolean
//		public var leftClickDown:Boolean = false;
		
		//arrow inventory
		public var arrowInventory:int = 3;
		
		public function Player() {
			// constructor code
			x = 100;
			y = 200;
		}
		
		public function updatePlayer(leftClickDown, leftKeyDown, rightKeyDown, upKeyDown, downKeyDown){			
			
			if (touchingGround == false){
				//do gravity
				fall();
			}
			if (upKeyDown == true){
				jump();
			}
			if (leftKeyDown == true){
				moveLeft();
			}
			if (rightKeyDown == true){
				moveRight();
			}
			if (rightKeyDown == false && leftKeyDown == false){
				stopMoving();
			}
			if (downKeyDown == true){
				crouch();
			}
		}
		
		private function jump(){
			if (touchingGround == true){
				vY = (jumpHeight * -1);
			}
		}
		
		private function crouch(){
			
		}

	}
	
}
