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
		
		public function MovementSystem() 
		{
		}
		
		override public function Update(deltaTime:Number):void
		{
			for each (var gameobject:GameObject in gameObjects)
			{
				if (!gameobject.Position || !gameobject.Velocity)
					continue;
					
				gameobject.Position.X += gameobject.Velocity.X * deltaTime;
				gameobject.Position.Y += gameobject.Velocity.Y * deltaTime;
			}
		}
	}

}