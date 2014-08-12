package GameEvents 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class CollisionEvent extends Event 
	{
		//Fixture Types
		public static const FOOT:String = "foot";
		public static const NOTFOOT:String = "notfoot";
		
		//Collision Types
		public static const ENTER:String = "enter";
		public static const EXIT:String = "exit";
		
		public var Object1:GameObject;
		public var Object2:GameObject;
		
		public var FixtureType1:String;
		public var FixtureType2:String;
		
		public var CollisionType:String;
		
		public function CollisionEvent(gobject1:GameObject, gobject2:GameObject, type:String, fixType1:String, fixType2:String) 
		{ 
			super(GameEventTypes.COLLISION);
			Object1 = gobject1;
			Object2 = gobject2;
			CollisionType = type;
			FixtureType1 = fixType1;
			FixtureType2 = fixType2;
		}
	}
	
}