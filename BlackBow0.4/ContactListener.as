package  
{
	import Box2D.Collision.b2ContactPoint;
	import Box2D.Dynamics.b2ContactListener;
	/**
	 * ...
	 * @author Scott Simpson
	 * 
	 * Can be set up similar to the contact listener
	 * class from puggle.
	 * 
	 */
	public class ContactListener extends b2ContactListener
	{
		
		public function ContactListener() 
		{
			
		}
		
		override public function Add(point:b2ContactPoint):void 
		{
			trace("Doink!");
			if (point.shape1.GetBody().GetUserData() is Enemy &&
				point.shape2.GetBody().GetUserData() is Arrow) {
				
				Enemy(point.shape1.GetBody().GetUserData()).hitByArrow();
				
			} else if(point.shape2.GetBody().GetUserData() is Enemy &&
				point.shape1.GetBody().GetUserData() is Arrow) {
				
				Enemy(point.shape2.GetBody().GetUserData()).hitByArrow();
				
			}
			
			super.Add(point);
		}
		
	}

}