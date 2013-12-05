package  
{
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.Contacts.b2Contact;
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
		
		override public function BeginContact(contact:b2Contact):void 
		{
			trace("Doink!");
			if (contact.GetFixtureA().GetBody().GetUserData() is Enemy &&
				contact.GetFixtureB().GetBody().GetUserData() is Arrow) {
				
				Enemy(contact.GetFixtureA().GetBody().GetUserData()).hitByArrow();
				
			} else if(contact.GetFixtureB().GetBody().GetUserData() is Enemy &&
				contact.GetFixtureA().GetBody().GetUserData() is Arrow) {
				
				Enemy(contact.GetFixtureB().GetBody().GetUserData()).hitByArrow();
				
			}
			
			if (contact.GetFixtureA().GetBody().GetUserData() is Player &&
				contact.GetFixtureB().GetBody().GetUserData() is Ground) {
				
				Player(contact.GetFixtureA().GetBody().GetUserData()).falling = false;
				
			} else if(contact.GetFixtureB().GetBody().GetUserData() is Player &&
				contact.GetFixtureA().GetBody().GetUserData() is Ground) {
				
				Player(contact.GetFixtureB().GetBody().GetUserData()).falling = false;
				
			}
			
			super.BeginContact(contact);
		}
		
	}

}