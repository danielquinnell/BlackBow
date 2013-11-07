package  
{
	import Box2D.Dynamics.b2World;
	/**
	 * ...
	 * @author Scott Simpson
	 * 
	 * Like the PhysiVals class from puggle
	 * 
	 */
	public class WorldVals 
	{
		
		public static const RATIO:Number = 30;
		
		private static var _world:b2World;
		
		public function WorldVals() 
		{
			
		}
		
		static public function get world():b2World 
		{
			return _world;
		}
		
		static public function set world(value:b2World):void 
		{
			_world = value;
		}
		
	}

}