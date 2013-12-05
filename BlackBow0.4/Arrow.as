package  
{
	import Box2D.Collision.Shapes.b2PolygonDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Scott Simpson
	 * 
	 * This should be pretty similar to the BallActor
	 * class from Puggle.
	 * You will probably want to set up an ArrowEvent.as 
	 * as well. - BallEvent.as.
	 * 
	 */
	public class Arrow extends Actor 
	{
		
		private static const ARROW_WIDTH:int = 12;
		private static const ARROW_HEIGHT:int = 2;
		
		public function Arrow(parent:DisplayObjectContainer, location:Point, initVel:Point) 
		{	
			//create costume
			var arrowSprite:Sprite = new ArrowSprite();
			arrowSprite.scaleX = ARROW_WIDTH / arrowSprite.width;
			arrowSprite.scaleY = ARROW_HEIGHT / arrowSprite.height;
			parent.addChild(arrowSprite);
			
			//create shape def
			var arrowShapeDef:b2PolygonDef = new b2PolygonDef();
			arrowShapeDef.SetAsBox(ARROW_WIDTH / 2 / WorldVals.RATIO, ARROW_HEIGHT / 2 / WorldVals.RATIO);
			arrowShapeDef.density = 1.0;
			arrowShapeDef.friction = 0.5;
			arrowShapeDef.restitution = 0.5;
			arrowShapeDef.filter.categoryBits = 0x0002;
			arrowShapeDef.filter.maskBits = 0x0002 | 0x0008 | 0x0010;
			
			//body def
			var arrowBodyDef:b2BodyDef = new b2BodyDef();
			arrowBodyDef.position.Set(location.x / WorldVals.RATIO, location.y / WorldVals.RATIO);
			arrowBodyDef.isBullet = true;
			var angle:Number = Math.atan2(initVel.y, initVel.x);
			arrowBodyDef.angle = angle;
			//something else
			
			//body
			var arrowBody:b2Body = WorldVals.world.CreateBody(arrowBodyDef);
			
			//shape
			arrowBody.CreateShape(arrowShapeDef);
			arrowBody.SetMassFromShapes();
			
			//set the vel to patch param
			var velocityVector:b2Vec2 = new b2Vec2(initVel.x / WorldVals.RATIO, initVel.y / WorldVals.RATIO);
			arrowBody.SetLinearVelocity(velocityVector);
			
			super(arrowBody, arrowSprite);
			
		}
		
		override protected function childSpecificUpdating():void 
		{
			if (_costume.y > _costume.stage.stageHeight) {
				dispatchEvent(new ArrowEvent(ArrowEvent.ARROW_OFF_SCREEN));
				
				
			}
			
			super.childSpecificUpdating();
		}
		
	}

}