package  
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Common.Math.b2Vec2;
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
	 * Graphically, this will be a simple circle.
	 * These will be attached to the player and 
	 * the enemies.
	 * All detection circles will be sensors.
	 * See Lesson 2.24
	 * http://www.youtube.com/watch?v=MZLizo67dA0&list=PLE4siOIe83xWHv8HRRjfTQBqg5rvXWFKF
	 * 
	 */
	public class DetectionCircle extends Actor 
	{
		public var radius:Number = 10;
		public var touched:Boolean = false;
		
		public function DetectionCircle(parent:DisplayObjectContainer, location:Point, size:Number) 
		{	
			radius = size;
			
			//costume
			var circleSprite:Sprite = new Circle();
			circleSprite.scaleX = radius * 2 / circleSprite.width;
			circleSprite.scaleY = radius * 2 / circleSprite.height;
			parent.addChild(circleSprite);
			
			//fixture def
			var arrowFixtureDef:b2FixtureDef = new b2FixtureDef();
			arrowFixtureDef.filter.categoryBits = 0x0002;
			arrowFixtureDef.filter.maskBits = 0x0002 | 0x0008 | 0x0010;
			arrowFixtureDef.shape = new b2CircleShape(radius / WorldVals.RATIO);
			arrowFixtureDef.isSensor = true;
			
			//body def
			var arrowBodyDef:b2BodyDef = new b2BodyDef();
			arrowBodyDef.type = b2Body.b2_dynamicBody;
			arrowBodyDef.bullet = true;
			arrowBodyDef.position.Set(location.x / WorldVals.RATIO, location.y / WorldVals.RATIO);
			//something else
			
			//body
			var arrowBody:b2Body = WorldVals.world.CreateBody(arrowBodyDef);
			
			//fixture
			var arrowFixture:b2Fixture = arrowBody.CreateFixture(arrowFixtureDef);
			
			super(arrowBody, circleSprite);
		}
		
	}

}