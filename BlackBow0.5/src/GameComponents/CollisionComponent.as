package GameComponents 
{
	/**
	 * Bounding Box Collision Component
	 * @author Austin Shindlecker
	 */
	public class CollisionComponent extends GameComponent
	{
		public var Width:int, Height:int;
		
		public var CollisionCallback:Function;	//Called when a collision occurs
		
		public function CollisionComponent(width:int = 32, height:int = 32, callback:Function = null)
		{
			Width = width;
			Height = height;
			CollisionCallback = callback;
			Type = GameComponent.COLLISION;
		}
	}

}