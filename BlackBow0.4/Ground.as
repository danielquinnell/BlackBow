package  
{
	import Box2D.Collision.Shapes.b2PolygonDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
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
			//create costume
			var groundSprite:Sprite = new GroundSprite();
			groundSprite.scaleX = groundWidth / groundSprite.width;
			groundSprite.scaleY = groundHeight / groundSprite.height;
			parent.addChild(groundSprite);
			
			//create shape def
			var groundShapeDef:b2PolygonDef = new b2PolygonDef();
			groundShapeDef.SetAsBox(groundWidth / WorldVals.RATIO, groundHeight / WorldVals.RATIO);
			groundShapeDef.density = 0;
			groundShapeDef.friction = 0.2;
			groundShapeDef.restitution = 0.3;
			
			//body def
			var groundBodyDef:b2BodyDef = new b2BodyDef();
			groundBodyDef.position.Set(location.x / WorldVals.RATIO, location.y / WorldVals.RATIO);
			
			//body
			var groundBody:b2Body = WorldVals.world.CreateBody(groundBodyDef);
			
			//shape
			groundBody.CreateShape(groundShapeDef);
			groundBody.SetMassFromShapes();
			
			super(groundBody, groundSprite);
			
		}
		
	}

}