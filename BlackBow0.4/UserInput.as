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
		public static var toggleMenu:Boolean = false;
		
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
		}
		
		private function keyUpHandler(e:KeyboardEvent):void 
		{
			switch(e.keyCode) {
				case 80:
					toggleMenu = true;
					break;
					
				case Keyboard.ESCAPE:
					toggleMenu = true;
					break;
			}
		}
		
	}

}