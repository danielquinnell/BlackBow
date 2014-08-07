package  
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class GameObject 
	{
		public var Id:int;
		private var components:Dictionary;
		
		public function GameObject() 
		{
			Id = -1;
			components = new Dictionary();
		}
		
		public function HasComponent(componenttype:String):Boolean
		{
			return (components[componenttype] != null);
		}
		
		public function AddComponent(component:GameComponent):void
		{
			components[component.Type] = component;
		}
		
		public function GetComponent(componenttype:String):GameComponent
		{
			return components[componenttype];
		}
	}

}