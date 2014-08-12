package GameSystems 
{
	import Box2D.Common.Math.b2Vec2;
	import GameComponents.CharacterComponent;
	import GameComponents.PhysicsComponent;
	/**
	 * Handles Character actions and movement
	 * @author Austin Shindlecker
	 */
	public class CharacterSystem extends GameSystem
	{
		
		public function CharacterSystem() 
		{
			
		}
		
		override public function Update(deltaTime:Number):void 
		{
			super.Update(deltaTime);
			
			for each(var gObject:GameObject in gameObjects)
			{
				if (!gObject || !gObject.HasComponent(GameComponent.CHARACTER))
					continue;
				
				var character:CharacterComponent = gObject.GetComponent(GameComponent.CHARACTER) as CharacterComponent;
				
				if (gObject.HasComponent(GameComponent.PHYSICS))
				{
					var physics:PhysicsComponent = gObject.GetComponent(GameComponent.PHYSICS) as PhysicsComponent;
					
					if (character.IsMoving)
					{
						if(character.Facing == CharacterComponent.RIGHT)
							physics.Body.SetLinearVelocity(new b2Vec2(character.Speed, physics.Body.GetLinearVelocity().y));
						else if(character.Facing == CharacterComponent.LEFT)
							physics.Body.SetLinearVelocity(new b2Vec2(-character.Speed, physics.Body.GetLinearVelocity().y));
					}
				}
			}
		}
	}

}