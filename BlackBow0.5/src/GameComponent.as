package  
{
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class GameComponent 
	{
		public var Type:String;
		public function GameComponent() 
		{
			Type = "";
		}
		
		//Declare GameComponent Type constants here
		public static const POSITION:String = "position";
		public static const VELOCITY:String = "velocity";
		public static const RENDERER:String = "renderer";
	}

}