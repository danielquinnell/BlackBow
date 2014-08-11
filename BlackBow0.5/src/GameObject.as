package  
{
	import flash.text.engine.RenderingMode;
	import flash.utils.Dictionary;
	import GameComponents.PhysicsComponent;
	import GameComponents.PositionComponent;
	import GameComponents.RendererComponent;
	import GameComponents.VelocityComponent;
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class GameObject 
	{
		protected var childrenObjects:Array
		protected var components:Dictionary;
		
		public var Id:uint;
		public var IsChild:Boolean;
		public var ParentId:uint;
		
		public var gameScene:GameScene;
		
		//Common Components that can be easily grabbed from the GameObject
		//NOTE: It's not required for gameobjects to use any or all of these default components. The default value is null
		public var Rendering:RendererComponent;
		public var Position:PositionComponent;
		public var Velocity:VelocityComponent;
		public var Physics:PhysicsComponent;
		
		public function GameObject(gamescene:GameScene, id:uint = 0) 
		{
			Id = id;
			ParentId = 0;
			IsChild = false;
			
			gameScene = gamescene;
			components = new Dictionary();
			childrenObjects = new Array();
			
			Rendering = null;
			Position = null;
			Velocity = null;
			Physics = null;
		}
		
		public function HasComponent(componenttype:String):Boolean
		{
			return (components[componenttype] != null);
		}
		
		public function AddComponent(component:GameComponent):void
		{
			component.ParentGameObject = this;
			gameScene.AddComponent(Id, component);
		}
		
		public function RemoveComponent(component:GameComponent):void
		{
			component.ParentGameObject = null;
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
		
		public function AddChild(gameObject:GameObject)
		{
			gameObject.IsChild = true;
			gameObject.ParentId = Id;
			childrenObjects.push(gameObject);
		}
		
		public function RemoveChild(gameObject:GameObject)
		{
			if(childrenObjects[childrenObjects.indexOf(gameObject)] != null)
				delete childrenObjects[childrenObjects.indexOf(gameObject)];
		}
		
		public function GetChildren():Array
		{
			return childrenObjects;
		}
		
		public function _scenePushComponentToDictionary(component:GameComponent):void
		{
			component.ParentGameObject = this;
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
				case GameComponent.PHYSICS:
					Physics = component as PhysicsComponent;
					break;
			}
		}
		
		public function _sceneRemoveComponentFromDictionary(component:GameComponent):void
		{
			component.ParentGameObject = this;
			delete components[component.Type];
		}
	}

}