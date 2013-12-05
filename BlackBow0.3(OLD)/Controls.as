package  {
	
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	
	public class Controls extends Sprite{
		public var stageRef:DisplayObject;
		
		public var upKeyDown:Boolean = false;
		public var leftKeyDown:Boolean = false;
		public var downKeyDown:Boolean = false;
		public var rightKeyDown:Boolean = false;
		public var leftClickDown:Boolean = false;
		public var zoom:int = 0;

		public function Controls() {
			trace('init-ing controls');
		}
	
		public function init(){
			trace('starting init');
			stageRef.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownEvent);
			stageRef.addEventListener(KeyboardEvent.KEY_UP, onKeyUpEvent);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownEvent);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUpEvent);
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheelEvent);
			trace('finished init');
			trace('WHY YOU NO WORK?!?!');
		}
		
		private function onKeyDownEvent(e:KeyboardEvent){
			trace('KEY DOWN');
			trace(e.keyCode + ' key down');
			if (e.keyCode == 87){
				upKeyDown = true;
			}
			if (e.keyCode == 65){
				leftKeyDown = true;
			}
			if (e.keyCode == 83){
				downKeyDown = true;
			}
			if (e.keyCode == 68){
				rightKeyDown = true;
			}
		}
		
		private function onKeyUpEvent(e:KeyboardEvent){
			trace('KEY UP');
			trace(e.keyCode + ' key up');
			if (e.keyCode == 87){
				upKeyDown = false;
			}
			if (e.keyCode == 65){
				leftKeyDown = false;
			}
			if (e.keyCode == 83){
				downKeyDown = false;
			}
			if (e.keyCode == 68){
				rightKeyDown = false;
			}
		}
		
		private function onMouseDownEvent(e:MouseEvent){
			// Player clicks on the left mouse button
			trace('mouse down');
			leftClickDown = true;
		}
		
		private function onMouseUpEvent(e:MouseEvent){
			// Player releases the left mouse button
			trace('mouse up');
			leftClickDown = false;
		}
		
		private function onMouseWheelEvent(e:MouseEvent){
			trace('mouse wheel = ' + e.delta);
			zoom = e.delta;
		}
		
		public function set setStageRef(value:DisplayObject){
			stageRef = value;
			init();
		}
	}
	
}
