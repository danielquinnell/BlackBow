package GameSystems 
{
	import com.coreyoneil.collision.CollisionList;
	import flash.display.DisplayObject;
	import GameComponents.RendererComponent;
	import GameEvents.CollisionEvent;
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class CollisionSystem extends GameSystem
	{
		public function CollisionSystem() 
		{
		}
		
		/*
		override public function GameObjectAdded(gameObj:GameObject):void 
		{
			super.GameObjectAdded(gameObj);
			
			if (!gameObj.Rendering)
				return;
				
			GameObjectComponentAdded(gameObj.Id, gameObj.Rendering);
		}
		
		override public function GameObjectComponentAdded(gameObjId:uint, component:GameComponent) 
		{
			super.GameObjectComponentAdded(gameObjId, component);
			
			if (component.Type == GameComponent.RENDERER)
			{
				var renderingComponent:RendererComponent = component as RendererComponent;
				collisionList.addItem(renderingComponent.Display);
			}
		}
		*/
		
		override public function Update(deltaTime:Number):void 
		{
			super.Update(deltaTime);
			
			for (var i:int = 0; i < gameObjects.length; i++)
			{
				if (!gameObjects[i] || !gameObjects[i].Rendering)
					continue;
					
				var collisionList:CollisionList = new CollisionList(gameObjects[i].Rendering.Display);
				collisionList.returnAngle = true;
				for (var j:int = 0; j < gameObjects.length; j++)
				{
					if (j == i || !gameObjects[j] || !gameObjects[j].Rendering)	//j can't equal i because it will check collisions against itself (Which will most likely be true always)
						continue;
					collisionList.addItem(gameObjects[j].Rendering.Display);
				}
				
				var collisions:Array = collisionList.checkCollisions();
				
				for each(var collisionobject:Object in collisions)
				{
					var objectCollidedWith:GameObject = null;
					if (collisionobject.object1 == gameObjects[i].Rendering.Display)
					{
						for each(var gameobject:GameObject in gameObjects)
						{
							if (gameobject.Rendering.Display == collisionobject.object2)
							{
								objectCollidedWith = gameobject;
								break;
							}
						}
					}
					else if (collisionobject.object2 == gameObjects[i].Rendering.Display)
					{
						for each(var gameobject:GameObject in gameObjects)
						{
							if (gameobject.Rendering.Display == collisionobject.object1)
							{
								objectCollidedWith = gameobject;
								break;
							}
						}
					}
					
					gameScene.BroadcastEvent(new CollisionEvent(gameObjects[i], objectCollidedWith));
				}
			}
			
		}
	}

}