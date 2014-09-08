package GameComponents 
{
	import adobe.utils.ProductManager;
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
		
		//Mainly used in the Physics system for when setting the positions outside of the physics engine
		public var ManuallyChangedX:Boolean;
		public var ManuallyChangedY:Boolean;
		
		public function PositionComponent(x:Number = 0, y:Number = 0) 
		{
			Type = GameComponent.POSITION;
			X = x;
			Y = y;
			LocalX = X;
			LocalY = Y;
			Rotation = 0;
			
			ManuallyChangedX = false;
			ManuallyChangedY = false;
		}
		
		public function SetX(value:Number)
		{
			X = value;
			ManuallyChangedX = true;
		}
		
		public function SetY(value:Number)
		{
			Y = value;
			ManuallyChangedY = true;
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