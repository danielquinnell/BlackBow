package  
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Scott Simpson
	 * 
	 * Probably use PhysicsEditor to create 
	 * complex shapes/bodies for this.
	 * 
	 */
	public class Ground extends Actor
	{
		public static const groundHeight:int = 20;
		public static const groundWidth:int = 550;
		
		public function Ground(parent:DisplayObjectContainer, location:Point) 
		{
			//costume
			var groundSprite:Sprite = new GroundSprite();
			groundSprite.scaleX = groundWidth / groundSprite.width;
			groundSprite.scaleY = groundHeight / groundSprite.height;
			parent.addChild(groundSprite);
			
			//shape
			var polygonShape:b2PolygonShape = new b2PolygonShape();
            polygonShape.SetAsBox(groundWidth / 2 / WorldVals.RATIO, groundHeight / 2 / WorldVals.RATIO);
			
			//fixture def
			var groundFixtureDef:b2FixtureDef = new b2FixtureDef();
			groundFixtureDef.density = 0;
			groundFixtureDef.friction = 0.2;
			groundFixtureDef.restitution = 0.3;
			groundFixtureDef.filter.categoryBits = 0x0008;
			groundFixtureDef.filter.maskBits = 0x0002 | 0x0004 | 0x0010;
			groundFixtureDef.shape = polygonShape;
			
			//body def
			var groundBodyDef:b2BodyDef = new b2BodyDef();
			groundBodyDef.type = b2Body.b2_staticBody;
			groundBodyDef.position.Set(location.x / WorldVals.RATIO, location.y / WorldVals.RATIO);
			
			//body
			var groundBody:b2Body = WorldVals.world.CreateBody(groundBodyDef);
			
			//fixture
			var groundFixture:b2Fixture = groundBody.CreateFixture(groundFixtureDef);
			
			super(groundBody, groundSprite);
			
		}
		
	}

}