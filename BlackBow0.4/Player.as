package
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2Shape;
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
	 * This is the most important part.
	 * We need to talk about how we want to do this.
	 *
	 */
	public class Player extends Actor
	{
		
		private static const playerWidth:int = 15;
		private static const playerHeight:int = 20;
		
		
		public function Player(parent:DisplayObjectContainer, location:Point)
		{
			//create costume
			var playerSprite:Sprite = new PlayerSprite();
			playerSprite.scaleX = playerWidth / playerSprite.width;
			playerSprite.scaleY = playerHeight / playerSprite.height;
			parent.addChild(playerSprite);
			
			//shape
			var polygonShape:b2PolygonShape = new b2PolygonShape();
			polygonShape.SetAsBox(playerWidth / 2 / WorldVals.RATIO, playerHeight / 2 / WorldVals.RATIO);
			
			//fixture def
			var playerFixtureDef:b2FixtureDef = new b2FixtureDef();
			playerFixtureDef.density = .8;
			playerFixtureDef.friction = 0.5;
			playerFixtureDef.restitution = 0.2;
			playerFixtureDef.filter.categoryBits = 0x0004;
			playerFixtureDef.filter.maskBits = 0x0002 | 0x0008 | 0x0010;
			playerFixtureDef.shape = polygonShape;
			
			//body def
			var playerBodyDef:b2BodyDef = new b2BodyDef();
			playerBodyDef.type = b2Body.b2_dynamicBody;
			playerBodyDef.position.Set(location.x / WorldVals.RATIO, location.y / WorldVals.RATIO);
			playerBodyDef.fixedRotation = true;
			//something else
			
			//body
			var playerBody:b2Body = WorldVals.world.CreateBody(playerBodyDef);
			
			//fixture
			var playerFixture:b2Fixture = playerBody.CreateFixture(playerFixtureDef);
			
			super(playerBody, playerSprite);
		}
		
		override protected function childSpecificUpdating():void
		{
			if (_costume.y > _costume.stage.stageHeight)
			{
				dispatchEvent(new PlayerEvent(PlayerEvent.PLAYER_OFF_SCREEN));
			}
			
			super.childSpecificUpdating();
		}
		
		public function getLocation():Point
		{
			var myLocation:Point = new Point(this._costume.x, this._costume.y);
			return myLocation;
		}
	
	}

}