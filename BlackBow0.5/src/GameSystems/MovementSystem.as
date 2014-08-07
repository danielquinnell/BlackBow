package GameSystems 
{
	import flash.events.EventDispatcher;
	import GameComponents.PositionComponent;
	import GameComponents.VelocityComponent;
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class MovementSystem extends GameSystem
	{
		var gameObjects:Array;
		
		public function MovementSystem() 
		{
		}
		
		override public function Initialize(gameobjects:Array):void 
		{
			super.Initialize(gameobjects);
			gameObjects = gameobjects;
		}
		
		override public function Update(deltaTime:Number):void
		{
			for each (var gameobject:GameObject in gameObjects)
			{
				if (!gameobject.HasComponent(GameComponent.POSITION) || !gameobject.HasComponent(GameComponent.VELOCITY))
					continue;
				var velocity:VelocityComponent = gameobject.GetComponent(GameComponent.VELOCITY) as VelocityComponent;
				var position:PositionComponent = gameobject.GetComponent(GameComponent.POSITION) as PositionComponent;
				
				position.X += velocity.X * deltaTime;
				position.Y += velocity.Y * deltaTime;
			}
		}
	}

}