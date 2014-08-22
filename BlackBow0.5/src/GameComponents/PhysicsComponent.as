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
		public var FixtureDefinitions:Array;
		
		public var Body:b2Body;	//This is set in the physics system, is null by default
		
		public var CollisionEnterCallback:Function;	//This is called when colliding with another object
		public var CollisionExitCallback:Function;	//This is called when exiting out of another object
		
		public var Width, Height;
		
		public function PhysicsComponent(width:Number = 32, height:Number = 32, type:uint = 2) 
		{
			Type = GameComponent.PHYSICS;
			BodyDefinition = new b2BodyDef();
			FixtureDefinitions = new Array();
			Body = null;			
			BodyDefinition.type = type;
			
			Width = width;
			Height = height;
			
			CollisionEnterCallback = null;
			CollisionExitCallback = null;
			
			if(width > 0 && height > 0)
				CreateRect(width, height);
		}
		
		public function CreateRect(width:Number, height:Number)
		{
			var polygon:b2PolygonShape = new b2PolygonShape();
			var fixDef:b2FixtureDef = new b2FixtureDef();
			fixDef.density = 1;
			fixDef.friction = 0;
			polygon.SetAsBox(width, height);
			fixDef.shape = polygon;
			
			FixtureDefinitions.push(fixDef);
		}
		
		override public function Clone():GameComponent 
		{
			var clone:PhysicsComponent = new PhysicsComponent(0,0);
			clone.BodyDefinition = BodyDefinition;
			clone.FixtureDefinitions = FixtureDefinitions;
			clone.Width = Width;
			clone.Height = Height;
			
			return clone;
		}
	}

}