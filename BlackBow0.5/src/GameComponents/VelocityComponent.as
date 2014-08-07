package GameComponents 
{
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class VelocityComponent extends GameComponent
	{
		public var X:Number;
		public var Y:Number;
		
		public function VelocityComponent(x:Number = 0, y:Number = 0) 
		{
			Type = GameComponent.VELOCITY;
			X = x;
			Y = y;
		}
		
	}

}