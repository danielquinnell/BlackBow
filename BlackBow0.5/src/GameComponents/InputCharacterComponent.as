package GameComponents 
{
	/**
	 * Maps Character Codes to Actions
	 * @author Austin Shindlecker
	 */
	public class InputCharacterComponent extends GameComponent
	{
		public var Left:uint, Right:uint, Up:uint, Down:uint;
		public var AimX, AimY;
		public function InputCharacterComponent(l:uint = 65, r:uint = 68, u:uint = 87, d:uint = 83)	//Default keys are 'WASD' 
		{
			Type = GameComponent.INPUT;
			Left = l;
			Right = r;
			Up = u;
			Down = d;
			AimX = 0;
			AimY = 0;
		}
		
		override public function Clone():GameComponent 
		{
			return new InputCharacterComponent(Left, Right, Up, Down);
		}
	}

}