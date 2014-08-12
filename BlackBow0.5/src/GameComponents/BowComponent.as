package GameComponents {
	import GameComponents.PhysicsComponent;
	import GameComponents.PositionComponent;
	import GameComponents.RendererComponent;
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class BowComponent extends GameComponent
	{
		public var PowerIncrement:Number;
		public var IsPulling:Boolean;
		public var CurrentPower:Number;
		
		public function BowComponent(powerInc:Number = 10) 
		{
			Type = GameComponent.BOW;
			PowerIncrement = powerInc;
			IsPulling = false;
			CurrentPower = 0;
		}
	}

}