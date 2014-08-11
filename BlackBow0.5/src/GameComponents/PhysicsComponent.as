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
		
		public function PhysicsComponent(width:Number = 32, height:Number = 32, type:uint = 2) 
		{
			Type = GameComponent.PHYSICS;
			BodyDefinition = new b2BodyDef();
			FixtureDefinition = new b2FixtureDef();
			Body = null;			
			BodyDefinition.type = type;
			FixtureDefinition.friction = 1;
			FixtureDefinition.density = 1;
			
			if(width > 0 && height > 0)
				CreateRect(width, height);
		}
		
		public function CreateRect(width:Number, height:Number)
		{
			var polygon:b2PolygonShape = new b2PolygonShape();
			polygon.SetAsBox(width, height);
			FixtureDefinition.shape = polygon;
		}
	}

}