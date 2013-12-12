package  
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Scott Simpson
	 * 
	 * Code that will hold info that will be similar 
	 * for all enemies. 
	 * We will have to talk this out as a group.
	 * 
	 */
	public class Enemy extends Actor 
	{
		private var _beenHit:Boolean;
		public static const enemyWidth:int = 30;
		public static const enemyHeight:int = 30;
		
		public function Enemy(parent:DisplayObjectContainer, location:Point) 
		{
			_beenHit = false;
			
			//costume
			var enemy:MovieClip = new EnemyMC();
			enemy.scaleX = enemyWidth / enemy.width;
			enemy.scaleY = enemyHeight / enemy.height;
			parent.addChild(enemy);
			
			//shape
			var polygonShape:b2PolygonShape = new b2PolygonShape();
			polygonShape.SetAsBox(enemyWidth / 2 / WorldVals.RATIO, enemyHeight / 2 / WorldVals.RATIO);
			
			//fixture def
			var enemyFixtureDef:b2FixtureDef = new b2FixtureDef();
			enemyFixtureDef.density = 1.5;
			enemyFixtureDef.friction = 0.5;
			enemyFixtureDef.restitution = 0.2;
			enemyFixtureDef.filter.categoryBits = 0x0010;
			enemyFixtureDef.filter.maskBits = 0x0002 | 0x0004 | 0x0008 | 0x0010;
			enemyFixtureDef.shape = polygonShape;
			
			//body def
			var enemyBodyDef:b2BodyDef = new b2BodyDef();
			enemyBodyDef.type = b2Body.b2_dynamicBody;
			enemyBodyDef.position.Set(location.x / WorldVals.RATIO, location.y / WorldVals.RATIO);
			
			//body
			var enemyBody:b2Body = WorldVals.world.CreateBody(enemyBodyDef);
			
			//fixture
			var enemyFixture:b2Fixture = enemyBody.CreateFixture(enemyFixtureDef);
			
			super(enemyBody, enemy);
			
			//set frame
			setMyMovieFrame();
			
		}
		
		public function hitByArrow():void 
		{
			if (! _beenHit) {
				_beenHit = true;
				setMyMovieFrame();
				
				dispatchEvent(new EnemyEvent(EnemyEvent.ENEMY_HIT));
				
			}
		}
		
		private function setMyMovieFrame():void 
		{
			
		}
		
	}

}