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
		
		public var Rotation;
		
		public function PositionComponent(x:Number = 0, y:Number = 0) 
		{
			Type = GameComponent.POSITION;
			X = x;
			Y = y;
			LocalX = X;
			LocalY = Y;
			
			Rotation = 0;
		}
		
		override public function Clone():GameComponent 
		{
			var clone:PositionComponent = new PositionComponent(X, Y);
			clone.LocalX = LocalX;
			clone.LocalY = LocalY;
			clone.Rotation = Rotation;
			return clone;
		}
	}

}