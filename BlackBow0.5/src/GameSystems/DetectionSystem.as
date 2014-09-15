package GameSystems 
{
	import GameComponents.CharacterComponent;
	import GameComponents.DetectionComponent;
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class DetectionSystem extends GameSystem
	{
		public function DetectionSystem() 
		{
			
		}
		
		override public function Update(deltaTime:Number):void 
		{
			super.Update(deltaTime);
			
			for each(var gObject:GameObject in gameObjects)
			{
				if (!gObject || !gObject.HasComponent(GameComponent.CHARACTER) || !gObject.HasComponent(GameComponent.DECTECTION) || !gObject.Position)
					continue;
				
				var character:CharacterComponent = gObject.GetComponent(GameComponent.CHARACTER) as CharacterComponent;
				var detection:DetectionComponent = gObject.GetComponent(GameComponent.DECTECTION) as DetectionComponent;
				
				if (character.IsMoving)
				{
					tweenRadius(detection, DetectionComponent.WALK, deltaTime);
				}
				else if (character.IsMoving == false)
				{
					tweenRadius(detection, DetectionComponent.STAND, deltaTime);
				}
			}
		}
		
		private function tweenRadius(detection:DetectionComponent, radiusType:Number, delta:Number )
		{
			if (detection.CurrentRadius < detection.Radii[radiusType])
			{
				detection.CurrentRadius += delta * detection.RadiusTweening;
				if (detection.CurrentRadius > detection.Radii[radiusType])
				{
					detection.CurrentRadius = detection.Radii[radiusType];
				}
			}
			else if (detection.CurrentRadius > detection.Radii[radiusType])
			{
				detection.CurrentRadius -= delta * detection.RadiusTweening;
				if (detection.CurrentRadius < detection.Radii[radiusType])
				{
					detection.CurrentRadius = detection.Radii[radiusType];
				}
			}
		}
	}

}