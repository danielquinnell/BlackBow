package GameComponents 
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class PhysicsComponent extends GameComponent
	{
		public var BodyDefinition:b2BodyDef;
		public var FixtureDefinition:b2FixtureDef;
		
		public var Body:b2Body;	//This is set in the physics system, is null by default
		
		public function PhysicsComponent(type:uint) 
		{
			Type = GameComponent.PHYSICS;
			BodyDefinition = new b2BodyDef();
			FixtureDefinition = new b2FixtureDef();
			Body = null;
			
			var polygon:b2PolygonShape = new b2PolygonShape();
			polygon.SetAsBox(50, 50);
			FixtureDefinition.shape = polygon;
			BodyDefinition.type = type;
			
			FixtureDefinition.friction = 1;
			FixtureDefinition.density = .1;
		}
	}

}