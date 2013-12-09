package  
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
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
		
		public var freeFlight:Boolean = false;
		public var pickedUp:Boolean = false;
		
		public function Arrow(parent:DisplayObjectContainer, location:Point, initVel:Point) 
		{	
			//costume
			var arrowSprite:Sprite = new ArrowSprite();
			arrowSprite.scaleX = ARROW_WIDTH / arrowSprite.width;
			arrowSprite.scaleY = ARROW_HEIGHT / arrowSprite.height;
			parent.addChild(arrowSprite);
			
			//shape
			var polygonShape:b2PolygonShape = new b2PolygonShape();
            polygonShape.SetAsBox(ARROW_WIDTH / 2 / WorldVals.RATIO, ARROW_HEIGHT / 2 / WorldVals.RATIO);
			
			//fixture def
			var arrowFixtureDef:b2FixtureDef = new b2FixtureDef();
			arrowFixtureDef.density = 10.0;
			arrowFixtureDef.friction = 0.5;
			arrowFixtureDef.restitution = 0.5;
			arrowFixtureDef.filter.categoryBits = 0x0002;
			arrowFixtureDef.filter.maskBits = 0x0002 | 0x0008 | 0x0010;
			arrowFixtureDef.shape = polygonShape;
			
			//other fixture def
			var sensorFixtureDef:b2FixtureDef = new b2FixtureDef();
			sensorFixtureDef.isSensor = true;
			sensorFixtureDef.filter.categoryBits = 0x0002;
			sensorFixtureDef.filter.maskBits = 0x0002 | 0x0004 | 0x0008 | 0x0010;
			sensorFixtureDef.shape = new b2CircleShape(10 / 2 / WorldVals.RATIO);
			
			//body def
			var arrowBodyDef:b2BodyDef = new b2BodyDef();
			arrowBodyDef.type = b2Body.b2_dynamicBody;
			arrowBodyDef.bullet = true;
			arrowBodyDef.position.Set(location.x / WorldVals.RATIO, location.y / WorldVals.RATIO);
			var angle:Number = Math.atan2(initVel.y, initVel.x);
			arrowBodyDef.angle = angle;
			//something else
			
			//body
			var arrowBody:b2Body = WorldVals.world.CreateBody(arrowBodyDef);
			
			//fixture
			var arrowFixture:b2Fixture = arrowBody.CreateFixture(arrowFixtureDef);
			
			//other fixture
			arrowFixture = arrowBody.CreateFixture(sensorFixtureDef);
			
			//set the vel to patch param
			var velocityVector:b2Vec2 = new b2Vec2(initVel.x / WorldVals.RATIO, initVel.y / WorldVals.RATIO);
			arrowBody.SetLinearVelocity(velocityVector);
			
			super(arrowBody, arrowSprite);
			
		}
		
		override protected function childSpecificUpdating():void 
		{
			if (_costume.y > _costume.stage.stageHeight) {
				dispatchEvent(new ArrowEvent(ArrowEvent.ARROW_OFF_SCREEN));
				
			}else if (pickedUp){
				dispatchEvent(new ArrowEvent(ArrowEvent.ARROW_OFF_SCREEN));
				
			}else {
				var body:b2Body = this._body;
				if (body.GetType()==b2Body.b2_dynamicBody) {
                    if (! body.GetUserData().freeFlight) {
                        var flyingAngle:Number = Math.atan2(body.GetLinearVelocity().y, body.GetLinearVelocity().x);
                        body.SetAngle(flyingAngle);
                    }
                }
                else {
                    body.SetBullet(false);
                }
			}
			
			super.childSpecificUpdating();
		}
		
	}

}