package  
{
	import flash.text.engine.RenderingMode;
	import flash.utils.Dictionary;
	import GameComponents.PositionComponent;
	import GameComponents.RendererComponent;
	import GameComponents.VelocityComponent;
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class GameObject 
	{
		public var Id:uint;
		
		private var components:Dictionary;
		public var gameScene:GameScene;
		
		//Common Components that can be easily grabbed from the GameObject
		//NOTE: It's not required for gameobjects to use any or all of these default components. The default value is null
		public var Rendering:RendererComponent;
		public var Position:PositionComponent;
		public var Velocity:VelocityComponent;
		
		public function GameObject(gamescene:GameScene, id:uint = 0) 
		{
			Id = id;
			gameScene = gamescene;
			components = new Dictionary();
			
			Rendering = null;
			Position = null;
			Velocity = null;
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
			
			switch(component.Type)
			{
				case GameComponent.POSITION:
					Position = component as PositionComponent;
					break;
				case GameComponent.RENDERER:
					Rendering = component as RendererComponent;
					break;
				case GameComponent.VELOCITY:
					Velocity = component as VelocityComponent;
					break;
			}
		}
		
		public function RemoveComponentFromDictionary(component:GameComponent):void
		{
			delete components[component.Type];
		}
	}

}