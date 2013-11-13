package  
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Scott Simpson
	 */
	public class PlayerEvent extends Event 
	{
		public static const PLAYER_OFF_SCREEN:String = "PlayerOffScreen";
		
		public function PlayerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new PlayerEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("PlayerEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}