package  
{
	import Box2D.Collision.Shapes.b2PolygonDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
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
		public static const enemyWidth:int = 19;
		public static const enemyHeight:int = 19;
		
		public function Enemy(parent:DisplayObjectContainer, location:Point) 
		{
			_beenHit = false;
			
			//create costume
			var enemy:MovieClip = new EnemyMC();
			enemy.scaleX = enemyWidth / enemy.width;
			enemy.scaleY = enemyHeight / enemy.height;
			parent.addChild(enemy);
			
			//shape def
			var enemyShapeDef:b2PolygonDef = new b2PolygonDef();
			enemyShapeDef.SetAsBox(enemyWidth / 2 / WorldVals.RATIO, enemyHeight / 2 / WorldVals.RATIO);
			enemyShapeDef.density = 1.5;
			enemyShapeDef.friction = 0.7;
			enemyShapeDef.restitution = 0.2;
			enemyShapeDef.filter.categoryBits = 0x0010;
			enemyShapeDef.filter.maskBits = 0x0002 | 0x0004 | 0x0008 | 0x0010;
			
			
			//body def
			var enemyBodyDef:b2BodyDef = new b2BodyDef();
			enemyBodyDef.position.Set(location.x / WorldVals.RATIO, location.y / WorldVals.RATIO);
			
			//body
			var enemyBody:b2Body = WorldVals.world.CreateBody(enemyBodyDef);
			
			//shape
			enemyBody.CreateShape(enemyShapeDef);
			enemyBody.SetMassFromShapes();
			
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