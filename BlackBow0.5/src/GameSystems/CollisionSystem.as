package GameSystems 
{
	import com.coreyoneil.collision.CollisionList;
	import flash.display.DisplayObject;
	import GameComponents.CollisionComponent;
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
		
		override public function Update(deltaTime:Number):void 
		{
			super.Update(deltaTime);
			
			for each(var tester:GameObject in gameObjects)
			{
				if (!tester || !tester.Collision)
					continue;
				for each(var gObject:GameObject in gameObjects)
				{
					if (!gObject || !gObject.Collision || gObject == tester)
						continue;
					
					if (boundingBoxCheck(tester, gObject))
					{
						gameScene.BroadcastEvent(new CollisionEvent(tester, gObject));
						if (tester.Collision.CollisionCallback)
						{
							tester.Collision.CollisionCallback(tester, gObject);
						}
					}
				}
			}
		}
		
		private function boundingBoxCheck(tester:GameObject, gobject:GameObject):Boolean
		{
			var testBox:Object = { Left: tester.Position.X, Top: tester.Position.Y };
			var box:Object = { Left: gobject.Position.X, Top: gobject.Position.Y };
			
			testBox.Left -= tester.Collision.Width / 2;
			testBox.Top -= tester.Collision.Height / 2;
			testBox.Bottom = testBox.Top + tester.Collision.Height;
			testBox.Right = testBox.Left + tester.Collision.Width;
			
			box.Left -= gobject.Collision.Width / 2;
			box.Top -= gobject.Collision.Height / 2;
			box.Bottom = box.Top + gobject.Collision.Height;
			box.Right = box.Left + gobject.Collision.Width;
			
			if (testBox.Left <= box.Right && testBox.Right >= box.Left)
			{
				if (testBox.Top <= box.Bottom && testBox.Bottom >= box.Top)
				{
					return true;
				}
			}
			
			return false;
		}
		
		private function pixelPerfectDetection(gObject:GameObject):void 
		{
			if (!gObject.Rendering)
				return;
					
			var collisionList:CollisionList = new CollisionList(gObject.Rendering.Display);
			collisionList.returnAngle = true;
			
			for (var j:int = 0; j < gameObjects.length; j++)
			{
				if (gameObjects[j].Id == gObject.Id || !gameObjects[j] || !gameObjects[j].Rendering || !gameObjects[j].Collision)	//j can't equal i because it will check collisions against itself (Which will most likely be true always)
					continue;
				if (gameObjects[j].Collision.DisplayObjectPixelPerfect == false)
					continue;
				collisionList.addItem(gameObjects[j].Rendering.Display);
			}
				
			var collisions:Array = collisionList.checkCollisions();
			
			for each(var collisionobject:Object in collisions)
			{
				var objectCollidedWith:GameObject = null;
				if (collisionobject.object1 == gObject.Rendering.Display)
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
				else if (collisionobject.object2 == gObject.Rendering.Display)
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
				
				gameScene.BroadcastEvent(new CollisionEvent(gObject, objectCollidedWith));
				if (gObject.Collision.CollisionCallback)
				{
					gObject.Collision.CollisionCallback(gObject, objectCollidedWith);
				}
			}
		}
	}

}