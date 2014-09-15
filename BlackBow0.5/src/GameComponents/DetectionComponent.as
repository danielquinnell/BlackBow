package GameComponents 
{
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class DetectionComponent extends GameComponent
	{
		public static const STAND:Number = 0;
		public static const WALK:Number = 1;
		public static const RUN:Number = 2;
		public static const CROUCH:Number = 3;
		public static const CROUCHWALK:Number = 4;
		
		public var Radii:Array;
		
		public var CurrentRadius:Number;
		
		//Speed of which the radius changes when changing character stater (walking to running, etc)
		public var RadiusTweening:Number;
		
		public function DetectionComponent(walkrad:Number = 100, runrad:Number = 50, standrad:Number = 50, crouchrad:Number = 50, crouchwalkrad:Number = 50) 
		{			
			Type = GameComponent.DECTECTION;
			Radii = new Array();
			Radii[0] = standrad;
			Radii[1] = walkrad;
			Radii[2] = runrad;
			Radii[3] = crouchrad;
			Radii[4] = crouchwalkrad;
			CurrentRadius = 0;
			RadiusTweening = 100;
		}
		
		override public function Clone():GameComponent 
		{
			return new DetectionComponent(Radii[1], Radii[2], Radii[0], Radii[3], Radii[4]);
		}
	}

}