package  
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class GameObject 
	{
		public var Id:uint;
		private var components:Dictionary;
		public var gameScene:GameScene;
		
		public function GameObject(gamescene:GameScene, id:uint = 0) 
		{
			Id = id;
			gameScene = gamescene;
			components = new Dictionary();
		}
		
		public function HasComponent(componenttype:String):Boolean
		{
			return (components[componenttype] != null);
		}
		
		public function AddComponent(component:GameComponent):void
		{
			gameScene.AddComponent(Id, component);
		}
		
		public function RemoveComponent(component:GameComponent):void
		{
			gameScene.RemoveComponent(Id, component);
		}
		
		public function GetComponent(componenttype:String):GameComponent
		{
			return components[componenttype];
		}
		
		public function RemoveFromScene()
		{
			gameScene.RemoveGameObject(this);
		}
		
		public function PushComponentToDictionary(component:GameComponent):void
		{
			components[component.Type] = component;
		}
		
		public function RemoveComponentFromDictionary(component:GameComponent):void
		{
			delete components[component.Type];
		}
	}

}