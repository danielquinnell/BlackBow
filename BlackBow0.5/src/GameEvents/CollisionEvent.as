package GameEvents 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class CollisionEvent extends Event 
	{
		public var Object1:GameObject;
		public var Object2:GameObject;
		
		public function CollisionEvent(gobject1:GameObject, gobject2:GameObject) 
		{ 
			super(GameEventTypes.COLLISION);
			Object1 = gobject1;
			Object2 = gobject2;
		}
	}
	
}