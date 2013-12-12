package  
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Scott Simpson
	 */
	public class ArrowIndicator  extends MovieClip
	{
		public var arrowType:String = "Arrow";
		
		public function ArrowIndicator(parent:DisplayObjectContainer, location:Point) 
		{
			this.x = location.x;
			this.y = location.y;
			gotoAndStop(1);
		}
		
		public function switchType():void
		{
			if (arrowType == "Arrow") {
				arrowType = "Hook";
				gotoAndStop(2);
			}else if (arrowType == "Hook") {
				arrowType = "Arrow";
				gotoAndStop(1);
			}
		}
		
	}

}