package
{
	import Box2D.Collision.b2Manifold;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.Contacts.b2ContactResult;
	import Box2D.Dynamics.Joints.b2JointEdge;
	import Box2D.Dynamics.Joints.b2WeldJointDef;
	
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
			var bodyA:b2Body = contact.GetFixtureA().GetBody();
			var bodyB:b2Body = contact.GetFixtureB().GetBody();
			var objA:Object = bodyA.GetUserData();
			var objB:Object = bodyB.GetUserData();
			
			if (contact.GetFixtureA().GetBody().GetUserData() is Enemy && contact.GetFixtureB().GetBody().GetUserData() is Arrow)
			{
				
				Enemy(contact.GetFixtureA().GetBody().GetUserData()).hitByArrow();
				
			}
			else if (contact.GetFixtureB().GetBody().GetUserData() is Enemy && contact.GetFixtureA().GetBody().GetUserData() is Arrow)
			{
				
				Enemy(contact.GetFixtureB().GetBody().GetUserData()).hitByArrow();
				
			}
			
			if (contact.GetFixtureA().GetBody().GetUserData() is Player && contact.GetFixtureB().GetBody().GetUserData() is Ground)
			{
				
				Player(contact.GetFixtureA().GetBody().GetUserData()).falling = false;
				
			}
			else if (contact.GetFixtureB().GetBody().GetUserData() is Player && contact.GetFixtureA().GetBody().GetUserData() is Ground)
			{
				
				Player(contact.GetFixtureB().GetBody().GetUserData()).falling = false;
				
			}
			
			if (objA is Arrow &&
				contact.GetFixtureA().IsSensor() &&
				objB is Ground) 
			{
				trace(contact.GetFixtureA().IsSensor());
				objA.freeFlight = true;
			}
			else if (objB is Arrow &&
				contact.GetFixtureB().IsSensor() &&
				objA is Ground)
			{
				trace(contact.GetFixtureB().IsSensor());
				objB.freeFlight = true;
			}
			
			if (objA is Arrow && objB is Player) 
			{
				if (objA.freeFlight) {
					objA.pickedUp = true;
				}
			}
			else if (objB is Arrow && objA is Player)
			{
				if (objB.freeFlight) {
					objB.pickedUp = true;
				}
			}
			
			super.BeginContact(contact);
		}
		
		override public function PreSolve(contact:b2Contact, oldManifold:b2Manifold):void
		{
			var contactPoint:b2Vec2;
			var weldJointDef:b2WeldJointDef;
			if (contact.IsTouching())
			{
				var bodyA:b2Body = contact.GetFixtureA().GetBody();
				var bodyB:b2Body = contact.GetFixtureB().GetBody();
				var objA:Object = bodyA.GetUserData();
				var objB:Object = bodyB.GetUserData();
				if (objA is Arrow && objB is Arrow)
				{
					for (var j:b2JointEdge = bodyA.GetJointList(); j; j = j.next)
					{
						bodyA.GetWorld().DestroyJoint(j.joint);
					}
					for (j = bodyB.GetJointList(); j; j = j.next)
					{
						bodyB.GetWorld().DestroyJoint(j.joint);
					}
				}
				if (objA is Ground && objB is Arrow)
				{
					if (!objB.freeFlight)
					{	
						//contactPoint = contact.GetManifold().m_normal;
						//trace(contact.GetManifold().m_pointCount);
						weldJointDef = new b2WeldJointDef();
						weldJointDef.Initialize(bodyB, bodyA, bodyA.GetWorldCenter());
						bodyB.GetWorld().CreateJoint(weldJointDef);
					}
				}
				if (objB is Ground && objA is Arrow)
				{
					if (!objA.freeFlight)
					{
						//contactPoint = contact.GetManifold().m_normal;
						//trace(contact.GetManifold().m_pointCount);
						weldJointDef = new b2WeldJointDef();
						weldJointDef.Initialize(bodyA, bodyB, bodyB.GetWorldCenter());
						bodyA.GetWorld().CreateJoint(weldJointDef);
					}
				}
				if (objA is Enemy && objB is Arrow)
				{
					if (!objB.freeFlight)
					{
						weldJointDef = new b2WeldJointDef();
						weldJointDef.Initialize(bodyB, bodyA, bodyA.GetWorldCenter());
						bodyB.GetWorld().CreateJoint(weldJointDef);
					}
				}
				if (objB is Enemy && objA is Arrow)
				{
					if (!objA.freeFlight)
					{
						weldJointDef = new b2WeldJointDef();
						weldJointDef.Initialize(bodyA, bodyB, bodyB.GetWorldCenter());
						bodyA.GetWorld().CreateJoint(weldJointDef);
					}
				}
				if (objB is Arrow)
				{
					objB.freeFlight = true;
				}
				if (objA is Arrow)
				{
					objA.freeFlight = true;
				}
			}
		}
	
	}

}