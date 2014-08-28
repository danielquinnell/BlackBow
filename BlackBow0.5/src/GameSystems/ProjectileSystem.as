package GameSystems 
{
	import GameComponents.PhysicsComponent;
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class ProjectileSystem extends GameSystem
	{
		public function ProjectileSystem() 
		{
			
		}
		
		override public function Update(deltaTime:Number):void 
		{
			super.Update(deltaTime);
			
			
			for each(var gObject:GameObject in gameObjects)
			{
				if (!gObject || !gObject.HasComponent(GameComponent.PHYSICS) || !gObject.Position)
					continue;
				
				var physics:PhysicsComponent= gObject.GetComponent(GameComponent.PHYSICS) as PhysicsComponent;
				
				if(physics.BodyDefinition.fixedRotation == false)
					gObject.Position.Rotation = Math.atan2(physics.Body.GetLinearVelocity().y, physics.Body.GetLinearVelocity().x) * PhysicsSystem.DegreePerRadian;
			}
		}
	}
}