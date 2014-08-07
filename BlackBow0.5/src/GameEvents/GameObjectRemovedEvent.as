package GameEvents 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class GameObjectRemovedEvent extends Event
	{
		public var ObjectRemoved:GameObject
		public var ObjectId:int;
		
		public function GameObjectRemovedEvent(gameobject:GameObject) 
		{
			super(GameEventTypes.GAMEOBJECT_REMOVED);
			ObjectRemoved = gameobject;
			ObjectId = ObjectRemoved.Id;
		}
	}

}