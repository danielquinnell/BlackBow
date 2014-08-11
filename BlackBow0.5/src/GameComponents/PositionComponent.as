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
		
		//For children this will be the offset
		public var LocalX:Number;
		public var LocalY:Number;
		
		public function PositionComponent(x:Number = 0, y:Number = 0) 
		{
			Type = GameComponent.POSITION;
			X = x;
			Y = y;
			LocalX = X;
			LocalY = Y;
		}
	}

}