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
	 * This is the most important part.
	 * We need to talk about how we want to do this.
	 * 
	 */
	public class Player extends Actor
	{
		
		private static const playerWidth:int = 12;
		private static const playerHeight:int = 12;
		private static const speed:int = 2;
		private static const jumpHeight:int = 1;
		
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
			playerShapeDef.friction = 0.9;
			playerShapeDef.restitution = 0.3;
			
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
		
		public function update():void
		{
			var Body = this._body;
			if (UserInput.left) {
				Body.WakeUp();//WAKES BODY UP IF IT IS SLEEPING
				Body.m_linearVelocity.x = -speed;//ADDS TO THE LINEARVELOCITY OF THE BOX.
			}
			if (UserInput.right) {
				Body.WakeUp();//WAKES BODY UP IF IT IS SLEEPING
				Body.m_linearVelocity.x = speed;//ADDS TO THE LINEARVELOCITY OF THE BOX.
			}
			if (UserInput.up) {
				if (Body.GetLinearVelocity().y > -1) {//Stops player from sometimes jumping higher then suppose to
					
                    Body.ApplyImpulse(new b2Vec2(0.0, -jumpHeight), Body.GetWorldCenter());//Applys and impuls to the player. (Makes it jump)
					
                }
			}
		}
		
	}

}