package  
{
	import Box2D.Dynamics.b2Body;
	import flash.utils.Dictionary;
	import flash.xml.XMLNode;
	import GameComponents.BowComponent;
	import GameComponents.HealthComponent;
	import GameComponents.PhysicsComponent;
	import GameComponents.PositionComponent;
	import GameComponents.RendererComponent;
	
	/**
	 * Used for loading/grabbing GameObjects to/from the cache.
	 * @author Austin Shindlecker
	 */
	
	public class XmlCache 
	{
		private static var gameObjectCache:Dictionary = new Dictionary(); //<name, object>
		
		public static function CreateGameObject(name:String, scene:GameScene):GameObject
		{
			var gameObject:GameObject = scene.CreateGameObject();
			
			for each(var cachedComponent:Object in gameObjectCache[name])
			{
				gameObject.AddComponent(cachedComponent["Component"].Clone());
			}
			
			return gameObject;
		}
		
		public static function LoadXML(xml:XML)
		{
			for each (var xmlGameObject:XML in xml.gameobject)
			{
				var gameObjectName:String = xmlGameObject.@name.toString();
				var componentList:Array = new Array();
				
				for each (var xmlGameComponent:XML in xmlGameObject.component)
				{
					var cached = cacheComponent(xmlGameComponent);
					if(cached.Component)
						componentList.push(cached);
					else
						trace("Unknown component type: " + cached.Type);
				}
				
				gameObjectCache[gameObjectName] = componentList;
			}
		}
		
		private static function cacheComponent(xml:XML):Object
		{
			var returnObject = new Object();
			returnObject.Type = xml.@type.toString();
			
			switch(returnObject.Type)
			{
				case GameComponent.HEALTH:
					var health:HealthComponent = new HealthComponent(Number(xml.maxhealth));
					health.Health = Number(xml.health); 
					returnObject.Component = health;
					break;
				case GameComponent.RENDERER:
					var rendering:RendererComponent = new RendererComponent(xml.displaytype);
					returnObject.Component = rendering;
					break;
				case GameComponent.POSITION:
					var position:PositionComponent = new PositionComponent(Number(xml.x), Number(xml.y));
					returnObject.Component = position;
					break;
				case GameComponent.PHYSICS:
					var physics:PhysicsComponent = new PhysicsComponent(Number(xml.width), Number(xml.height), b2Body.b2_dynamicBody);
					returnObject.Component = physics;
					break;
			}
			
			return returnObject;
		}
	}

}