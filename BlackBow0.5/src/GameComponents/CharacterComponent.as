package GameComponents 
{
	import Box2D.Common.b2Color;
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class CharacterComponent extends GameComponent
	{
		//Facing Directions
		public static const LEFT:uint = 0;
		public static const RIGHT:uint = 1;
		public static const DOWN:uint = 2;
		public static const UP:uint = 3;
		
		public var Facing:uint;
		public var IsMoving:Boolean;
		public var Speed:int;
		public var CanJump:Boolean;
		public var CurrentTool:GameObject;
		public var IsJumping:Boolean;
		public var JumpForce:Number;
		
		//If true the character is performing a primary action, if false the character is not
		public var PrimaryActionState:Boolean;
		
		public function CharacterComponent(speed:int = 10, moving:Boolean = false) 
		{
			Type = GameComponent.CHARACTER;
			JumpForce = 2;
			Facing = RIGHT;
			IsMoving = moving;
			PrimaryActionState = false;
			Speed = speed;
			CanJump = false;
			CurrentTool = null;
			IsJumping = false;
		}
	}

}