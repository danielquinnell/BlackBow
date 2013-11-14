package  
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author Scott Simpson
	 */
	public class UserInput 
	{
		public static var toggleMenu:Boolean = false; //FLAG FOR VISIBILITY
		public static var up:Boolean = false; //FLAG FOR UP
		public static var down:Boolean = false; //FLAG FOR LEFT
		public static var left:Boolean = false; //FLAG FOR DOWN
		public static var right:Boolean = false; //FLAG FOR RIGHT
		
		
		public function UserInput(stageRef:Stage) 
		{
			stageRef.addEventListener(MouseEvent.MOUSE_DOWN, moDownHandler);
			stageRef.addEventListener(MouseEvent.MOUSE_UP, moUpHandler);
			stageRef.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stageRef.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
		}
		
		private function moDownHandler(e:MouseEvent):void 
		{
			
		}
		
		private function moUpHandler(e:MouseEvent):void 
		{
			
		}
		
		private function keyDownHandler(e:KeyboardEvent):void 
		{
			trace("Key code = " + e.keyCode);
			switch(e.keyCode) {
				case 87: 					//"W"
					up = true;
					break;
					
				case 65: 					//"A"
					left = true;
					break;
					
				case 83: 					//"S"
					down = true;
					break;
					
				case 68: 					//"D"
					right = true;
					break;
					
				case 38: 					//"UP"
					up = true;
					break;
					
				case 37: 					//"LEFT"
					left = true;
					break;
					
				case 40: 					//"DOWN"
					down = true;
					break;
					
				case 39: 					//"RIGHT"
					right = true;
					break;
			}
		}
		
		private function keyUpHandler(e:KeyboardEvent):void 
		{
			switch(e.keyCode) {
				case 80: 					//"P"
					toggleMenu = true;
					break;
					
				case Keyboard.ESCAPE: 		//"ESC"
					toggleMenu = true;
					break;
					
				case 87: 					//"W"
					up = false;
					break;
					
				case 65: 					//"A"
					left = false;
					break;
					
				case 83: 					//"S"
					down = false;
					break;
					
				case 68: 					//"D"
					right = false;
					break;
					
				case 38: 					//"UP"
					up = false;
					break;
					
				case 37: 					//"LEFT"
					left = false;
					break;
					
				case 40: 					//"DOWN"
					down = false;
					break;
					
				case 39: 					//"RIGHT"
					right = false;
					break;
			}
		}
		
	}

}