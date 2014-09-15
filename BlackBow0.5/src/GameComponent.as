package  
{
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class GameComponent 
	{
		public var Type:String;
		public var ParentGameObject:GameObject; //The game object this component is in
		
		public function GameComponent() 
		{
			Type = "";
			ParentGameObject = null;
		}
		
		//Should create a new instance of the GameComponent with the same exact data
		public function Clone():GameComponent
		{
			return null;
		}
		
		//Declare GameComponent Type constants here
		public static const POSITION:String = "position";
		public static const VELOCITY:String = "velocity";
		public static const RENDERER:String = "renderer";
		public static const COLLISION:String = "collision";
		public static const PHYSICS:String = "physics";
		public static const CHARACTER:String = "character";
		public static const INVENTORY:String = "inventory";
		public static const BOW:String = "bow";
		public static const INPUT:String = "input";
		public static const HEALTH:String = "health";
		public static const ANIMATION:String = "animation";
		public static const DECTECTION:String = "detection";
	}

}