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
					if (bow.CurrentPower > bow.MaxPower)
						bow.CurrentPower = bow.MaxPower;
				}
				else
				{
					if (bow.CurrentPower > 0)
					{
						//Fire Arrow
						if (character)
						{
							var arrow:GameObject = XmlCache.CreateGameObject("arrow", gameScene, true, gObject.Position.X, gObject.Position.Y);							
							var physics:PhysicsComponent = arrow.Physics;
							arrow.Tag = "arrow";
							physics.Body.SetLinearVelocity(new b2Vec2(Math.cos(bow.Angle) * bow.CurrentPower * ArrowPowerMultiplier, -Math.sin(bow.Angle) *  bow.CurrentPower * ArrowPowerMultiplier));	
						}
					}
					
					bow.CurrentPower = 0;
				}
			}
		}
	}

}