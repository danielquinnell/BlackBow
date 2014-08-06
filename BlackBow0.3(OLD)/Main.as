package  {
	import flash.display.MovieClip;
	
	public class Main extends MovieClip{

		private var engine:BlackBowEngine = new BlackBowEngine;

		public function Main() {
			init();
		}
		
		private function init(){
			addChild(engine);
			engine.controls.setStageRef = stage;
			//engine.controls.init();
		}

	}
	
}
