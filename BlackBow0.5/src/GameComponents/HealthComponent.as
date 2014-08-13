package GameComponents 
{
	import GameEvents.GameObjectAddedEvent;
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class HealthComponent extends GameComponent
	{
		public var Health:Number;
		public var MaxHealth:Number;
		
		public function HealthComponent(maxHP:Number) 
		{
			Type = GameComponent.HEALTH;
			
			MaxHealth = maxHP;
			Health = MaxHealth;
		}
	}

}