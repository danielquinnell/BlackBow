package  
{
	import flash.utils.Dictionary;
	import flash.xml.XMLNode;
	import GameComponents.BowComponent;
	import GameComponents.HealthComponent;
	import GameComponents.RendererComponent;
	
	/**
	 * Used for loading/grabbing GameObjects to/from the cache.
	 * @author Austin Shindlecker
	 */
	
	public class XmlCache 
	{
		private static var gameObjectCache:Dictionary = new Dictionary(); //<name, object>
		
		public static function CreateGameObject(xml:XML, scene:GameScene = null):GameObject
		{
			var gameObject:GameObject = new GameObject(scene);
			
			for each(var xmlComponent:XML in xml.component)
			{
				var component:GameComponent = CreateComponent(xmlComponent);
				if(component != null)
					gameObject.AddComponent(component);
			}
			return gameObject;
		}
		
		public static function CreateComponent(xml:XML):GameComponent
		{
			var type:String = xml.@type;
			
			switch(type)
			{
				case GameComponent.HEALTH:
					var health:HealthComponent = new HealthComponent(Number(xml.MaxHealth));
					health.Health = Number(xml.Health); 
					return health;
					break;
					
				case GameComponent.BOW:
					var bow:BowComponent = new BowComponent(Number(xml.PullingPower));
					break;
			}
			
			return null;
		}
		
		public static function LoadXML(xml:XML)
		{
			for each (var xmlGameObject:XML in xml.gameobject)
			{
				var gameObjectName:String = xmlGameObject.@name.toString();
				var componentList:Array = new Array();
				
				for each (var xmlGameComponent:XML in xmlGameObject.component)
				{
					componentList.push(cacheComponent(xmlGameComponent));
				}
				
				gameObjectCache[gameObjectName] = componentList;
			}
		}
		
		private static function cacheComponent(xml:XML):Object
		{
			var returnObject = new Object();
			returnObject.Type = xml.@type.toString();
			trace(returnObject.Type);
			
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
			}
			
			return returnObject;
		}
	}

}