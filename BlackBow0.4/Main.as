package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
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
		
		private var menu:Menu;
		
		public function Main() 
		{	
			//ADD THE MENU
			menu = new Menu();
			stage.addChild(menu);
			menu.x = stage.width / 2;
			menu.y = stage.height / 2;
			
			//ENTER FRAME LISTENER
			addEventListener(Event.ENTER_FRAME, newFrameListener);
		}
		
		private function newFrameListener(e:Event):void 
		{
			processUserInput();
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
		
	}

}