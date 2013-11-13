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
	 * This is the most important part.
	 * We need to talk about how we want to do this.
	 * 
	 */
	public class Player extends Actor
	{
		
		private static const playerWidth:int = 12;
		private static const playerHeight:int = 12;
		
		public function Player(parent:DisplayObjectContainer, location:Point) 
		{
			//create costume
			var playerSprite:Sprite = new PlayerSprite();
			playerSprite.scaleX = playerWidth / playerSprite.width;
			playerSprite.scaleY = playerHeight / playerSprite.height;
			parent.addChild(playerSprite);
			
			//create shape def
			var playerShapeDef:b2PolygonDef = new b2PolygonDef();
			playerShapeDef.SetAsBox(playerWidth / 2 / WorldVals.RATIO, playerHeight / 2 / WorldVals.RATIO);
			playerShapeDef.density = 1.5;
			playerShapeDef.friction = 0.7;
			playerShapeDef.restitution = 0.2;
			
			//body def
			var playerBodyDef:b2BodyDef = new b2BodyDef();
			playerBodyDef.position.Set(location.x / WorldVals.RATIO, location.y / WorldVals.RATIO);
			//something else
			
			//body
			var playerBody:b2Body = WorldVals.world.CreateBody(playerBodyDef);
			
			//shape
			playerBody.CreateShape(playerShapeDef);
			playerBody.SetMassFromShapes();
			
			super(playerBody, playerSprite);
			
		}
		
		override protected function childSpecificUpdating():void 
		{
			if (_costume.y > _costume.stage.stageHeight) {
				dispatchEvent(new PlayerEvent(PlayerEvent.PLAYER_OFF_SCREEN));
				
			}
			
			super.childSpecificUpdating();
		}
		
	}

}