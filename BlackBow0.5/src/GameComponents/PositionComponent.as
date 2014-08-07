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
		
		public function PositionComponent(x:Number = 0, y:Number = 0) 
		{
			Type = GameComponent.POSITION;
			X = x;
			Y = y;
		}
	}

}