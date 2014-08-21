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
		
		override public function Clone():GameComponent 
		{
			var clone:HealthComponent = new HealthComponent();
			clone.Health = Health;
			clone.MaxHealth = MaxHealth;
			return clone;
		}
	}

}