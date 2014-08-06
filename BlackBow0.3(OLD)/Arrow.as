package  {
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Arrow extends PhysicsObject{
		//var xvelocity:Number;
		//var yvelocity:Number;
		//var angle:Number;
//		var vel:Number;
//		var deltaX:Number;
//		var deltaY:Number;
		public var shot:Boolean = false;
		//var landAngle:Number;
		//var gravity:Number = 1;
		//var wind:Number = .98;
		//var landed:Boolean;
		//var wobble:Number;
		
		public function Arrow(){
			//change in y / change in x
			
			//landed = false;
			
			//this.addEventListener(Event.ENTER_FRAME, updateArrow);
			//this.addEventListener(MouseEvent.MOUSE_OVER, mousedOver);
		}
		
		public function init(angle:Number, vel:Number){
			this.rotation = angle;
			vX = vel*Math.cos(angle*Math.PI/180);
			vY = vel*Math.sin(angle*Math.PI/180);
		}
		
		public function updateArrow(){
			if(!touchingGround && shot)
			{
				//landAngle*=.96;
				//this.rotation+=landAngle*Math.cos(angle);
				//angle += .18;
				//return;
			//}
			this.rotation = 180*Math.atan(vY/vX)/Math.PI;
			//trace('rotation = ' + this.rotation);
			
			//yvelocity+=gravity;
			//vX*=wind;
			//this.x+=xvelocity;
			//this.y+=yvelocity+gravity;
			//if(this.x>550 || this.y>400)
			//{
				//landed = true;
				//if(this.x>550)
				//{
					//this.x=550;
					//landAngle = Math.sqrt(yvelocity);
				//}
				//if(this.y>400)
				//{
					//this.y=400;
					//landAngle = Math.sqrt(xvelocity);
					
				//}
				//angle = 0;
			//}
			}// <-- i added this one
		}
		
		public function mousedOver(me:MouseEvent){
			if(touchingGround)
			{
				this.x=-100;
			}
		}
	}
}