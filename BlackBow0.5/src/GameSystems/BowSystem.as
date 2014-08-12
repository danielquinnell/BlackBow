package GameSystems 
{
	import Box2D.Common.Math.b2Vec2;
	import GameComponents.BowComponent;
	import GameComponents.CharacterComponent;
	import GameComponents.PhysicsComponent;
	import GameComponents.PositionComponent;
	import GameComponents.RendererComponent;
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class BowSystem extends GameSystem
	{
		//Constant applied to all shot arrows to make the speed "feel right"
		public static const ArrowPowerMultiplier:Number = 1;
		
		public function BowSystem() 
		{
			
		}
		
		override public function Update(deltaTime:Number):void 
		{
			super.Update(deltaTime);
			
			for each(var gObject:GameObject in gameObjects)
			{
				if (!gObject || !gObject.HasComponent(GameComponent.BOW))
					continue;
				
				var bow:BowComponent = gObject.GetComponent(GameComponent.BOW) as BowComponent;
				var character:CharacterComponent = null;
				if (gObject.HasComponent(GameComponent.CHARACTER))
				{
					character = gObject.GetComponent(GameComponent.CHARACTER) as CharacterComponent;
					bow.IsPulling = character.PrimaryActionState;
				}
				
				if (bow.IsPulling)
				{
					bow.CurrentPower += bow.PowerIncrement + deltaTime;
				}
				else
				{
					if (bow.CurrentPower > 0)
					{
						//Fire Arrow
						if (character)
						{
							var arrow:GameObject = gameScene.CreateGameObject();
							arrow.AddComponent(new RendererComponent(new ArrowSprite()));
							arrow.AddComponent(new PositionComponent(gObject.Position.X, gObject.Position.Y));
							
							var physics:PhysicsComponent = new PhysicsComponent(PhysicsSystem.GetPixelsToMeters(arrow.Rendering.Display.width), PhysicsSystem.GetPixelsToMeters(PhysicsSystem.GetPixelsToMeters(arrow.Rendering.Display.width)));
							physics.FixtureDefinition.isSensor = true;
							physics.BodyDefinition.linearVelocity = new b2Vec2(character.Facing == CharacterComponent.LEFT ? -bow.CurrentPower * ArrowPowerMultiplier : bow.CurrentPower * ArrowPowerMultiplier, 0);
							
							arrow.AddComponent(physics);
						}
					}
					
					bow.CurrentPower = 0;
				}
				
			}
		}
	}

}