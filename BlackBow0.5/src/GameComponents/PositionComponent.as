package GameComponents 
{
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class PositionComponent extends GameComponent
	{
		public var X:Number;
		public var Y:Number;
		
		public function PositionComponent() 
		{
			Type = GameComponent.POSITION;
			X = 0;
			Y = 0;
		}
	}

}