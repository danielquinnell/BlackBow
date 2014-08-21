package GameComponents 
{
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class AnimationComponent extends GameComponent
	{
		public static const STANDING:String = "stand";
		public static const WALKING:String = "walk";
		public static const JUMPING:String = "jump";
		public static const CROUCHING:String = "crouch";
		public static const CROUCHWALKING:String = "crouchwalk";
		
		public var State:String;
		public var Frame:uint;
		public var Delay:Number;	//Number of milliseconds between each frame
		public var Ticks:Number;	//Number of ticks in milliseconds of current animation (used for switching between frames)
		
		public function AnimationComponent() 
		{
			Type = GameComponent.ANIMATION;
			AnimationState = STANDING;
			Frame = 0;
			Delay = 0;
			Ticks = 0;
		}
		
		public function SwitchFrame(frame:uint):void
		{
			Frame = frame;
			Ticks = 0;
		}
	}

}