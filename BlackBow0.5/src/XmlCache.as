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
		private static var gameObjectCache:Dictionary; //<name, object>
		public function XmlCache() 
		{
			gameObjectCache = new Dictionary();
		}
		
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
		
		//Loads and xml file and places data into the cache
		/*
		 * Cache looks like this:
			 * -Game Object
			 * 		-Name
			 *		-Component
			 * 			-Type
			 * 			-Data
			 * 			-Data
			 * 		-Component
			 * 			-Type
			 * 			-Data
			 * -Game Object
			 * 		-Name
		 */
		public static function LoadXML(xml:XML)
		{
			for each (var xmlGameObject:XML in xml.objects)
			{
				var gameObjectName:String = xmlGameObject.@name;
				var componentList:Array = new Array();
				
				for each (var xmlGameComponent:XML in xmlGameObject.component)
				{
					componentList.push(cacheComponent(xmlGameComponent, componentCache));
				}
				
				gameObjectCache[gameObjectName] = componentCache;
			}
		}
		
		private static function cacheComponent(xml:XML):Object
		{
			var returnObject = new Object();
			returnObject.Type = xml.@type;
			
			switch(returnObject.Type)
			{
				case GameComponent.HEALTH:
					var health:HealthComponent = new HealthComponent(Number(xml.maxhealth));
					health.Health = Number(xml.health); 
					returnObject.Component = health;
					break;
				case GameComponent.RENDERER:
					var rendering:RendererComponent = new RendererComponent();
					switch(xml.sprite)
					{
						case "player":
							rendering.Display = new PlayerSprite();
							break;
					}
					break;
			}
			
			return returnObject;
		}
	}

}