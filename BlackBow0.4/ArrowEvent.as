package  
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Scott Simpson
	 */
	public class ArrowEvent extends Event 
	{
		public static const ARROW_OFF_SCREEN:String = "ArrowOffScreen";
		public static const ARROW_ATTACHED:String = "ArrowAttached";
		
		public function ArrowEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new ArrowEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ArrowEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}