package  {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	public class View extends Sprite{
		
		//world
		public var bg:level0Background;
		//main container
		public var spriteContainer:Sprite;
		//visible part world
		public var viewContainer:Sprite;
		//hittable bg
		public var lvlbg:MovieClip;
		//other bg
		public var lvlbg2:MovieClip;
		
		//UI
		public var arrowInventoryBox:TextField;
		
		public function View() {
			// constructor code
		}
		
		public function buildLevel(lvl:int){
	
			//world
			
			//container
			spriteContainer = new Sprite;
			addChild(spriteContainer);
			spriteContainer.graphics.drawRect(0,0,(1600),1200);
			
			//view
			viewContainer = new Sprite;
			spriteContainer.addChild(viewContainer);
			viewContainer.graphics.drawRect(0,0,800,600);
			
			//create solid background
			bg = new level0Background;
			viewContainer.addChild(bg);
			bg.x = 0;
			bg.y = 0;
			
			//create hittable stuff
			lvlbg = new a1bg1;
			lvlbg2 = new a1bg2;

			viewContainer.addChild(lvlbg2);
			viewContainer.addChild(lvlbg);
			
			//hud
			arrowInventoryBox = new TextField;
			arrowInventoryBox.x = 10;
			arrowInventoryBox.y = 10;
			arrowInventoryBox.scaleX = 2;
			arrowInventoryBox.scaleY = 2;
			arrowInventoryBox.alpha = 1;
			arrowInventoryBox.textColor = 0xffffff;
			arrowInventoryBox.backgroundColor = 0x000000;
			//arrowInventoryBox.text = player.arrowInventory.toString();
			addChild(arrowInventoryBox);
		}
		
		public function changeLevel(lvl:int){
			if(lvl == 1){
				lvlbg = new a2bg1;
				lvlbg2 = new a2bg2;
			}
			else if(lvl == 2){
				lvlbg = new a3bg1;
				lvlbg2 = new a3bg2;
			}
			else if(lvl == 3){
				lvlbg = new a4bg1;
				lvlbg2 = new a4bg2;
			}
			else if(lvl == 4){
				lvlbg = new a5bg1;
				lvlbg2 = new a5bg2;
			}
			else if(lvl == 5){
				lvlbg = new a6bg1;
				lvlbg2 = new a6bg2;
			}
			addChild(spriteContainer);
			spriteContainer.addChild(viewContainer);
			viewContainer.addChild(bg);
			viewContainer.addChild(lvlbg2);
			viewContainer.addChild(lvlbg);
			addChild(arrowInventoryBox);
		}
		
		public function zoom(mag:int){
			if (mag < 0){
				if (viewContainer.width >= bg.width && viewContainer.height >= bg.height){
					doZoom(mag);
				}
			}else{
				if (viewContainer.width <= (bg.width * 2) && viewContainer.height <= (bg.height * 2)){
					doZoom(mag);
				}
			}
		}
		
		private function doZoom(mag:int){
			viewContainer.width += (mag * 40);
			viewContainer.height += (mag * 30);
			trace(bg.width);
			trace(viewContainer.width);
		}
		
		

	}
	
}
