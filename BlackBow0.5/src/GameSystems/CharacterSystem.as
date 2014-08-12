package GameSystems 
{
	import Box2D.Common.Math.b2Vec2;
	import flash.events.EventDispatcher;
	import GameComponents.CharacterComponent;
	import GameComponents.PhysicsComponent;
	import GameEvents.CollisionEvent;
	/**
	 * Handles Character actions and movement
	 * @author Austin Shindlecker
	 */
	public class CharacterSystem extends GameSystem
	{
		
		public function CharacterSystem() 
		{
			
		}
		
		override public function AddEventListeners(dispatcher:EventDispatcher):void 
		{
			super.AddEventListeners(dispatcher);
			dispatcher.addEventListener(GameEventTypes.COLLISION, onCollision);
		}
		
		private function onCollision(event:CollisionEvent)
		{
			var garray:Array = new Array();
			garray.push(event.Object1);
			garray.push(event.Object2);
			
			var farray:Array = new Array();
			farray.push(event.FixtureType1);
			farray.push(event.FixtureType2);
			
			for (var i:int = 0; i < garray.length; i++)
			{
				var gObject:GameObject = garray[i];
				
				if (!gObject || !gObject.HasComponent(GameComponent.CHARACTER) || farray[i] != CollisionEvent.FOOT)
					continue;
				
				var character:CharacterComponent = gObject.GetComponent(GameComponent.CHARACTER) as CharacterComponent;
				
				if (event.CollisionType == CollisionEvent.ENTER)
				{
					character.CanJump = true;
				}
				else
				{
					character.CanJump = false;
				}
			}
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
					else
					{
						physics.Body.SetLinearVelocity(new b2Vec2(0, physics.Body.GetLinearVelocity().y));
					}
					
					if (character.CanJump && character.IsJumping)
					{
						character.CanJump = false;
						
						physics.Body.SetLinearVelocity(new b2Vec2(physics.Body.GetLinearVelocity().x, -character.JumpForce));
					}
				}
			}
		}
	}

}