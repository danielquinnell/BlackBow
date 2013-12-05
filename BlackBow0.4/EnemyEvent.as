package  
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Scott Simpson
	 */
	public class EnemyEvent extends Event 
	{
		public static const ENEMY_HIT:String = "EnemyHit";
		
		public function EnemyEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new EnemyEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("EnemyEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}