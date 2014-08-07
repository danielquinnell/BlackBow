package GameSystems 
{
	import flash.events.EventDispatcher;
	import GameComponents.PositionComponent;
	import GameComponents.VelocityComponent;
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class MovementSystem implements IGameSystem
	{
		private var gameObjects:Array;
		
		public function MovementSystem(gameobjects:Array) 
		{
				gameObjects = gameobjects;
		}
		
		public function Update(deltaTime:Number):void
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
		
		
		public function AddEventListeners(dispatcher:EventDispatcher):void
		{
			//Movement works on it's own as of now
		}
		
		public function RemoveEventListeners(dispatcher:EventDispatcher):void
		{
			//Movement works on it's own as of now
		}
	}

}