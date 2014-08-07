package GameEvents 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class GameObjectAddedEvent extends Event
	{
		public var ObjectAdded:GameObject;
		public var ObjectId:int;
		
		public function GameObjectAddedEvent(gameobject:GameObject) 
		{
			super(GameEventTypes.GAMEOBJECT_ADDED);
			ObjectAdded = gameobject;
			ObjectId = ObjectAdded.Id;
		}
	}

}