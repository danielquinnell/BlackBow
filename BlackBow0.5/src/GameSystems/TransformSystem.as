package GameSystems 
{
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class TransformSystem extends GameSystem
	{
		public function TransformSystem() 
		{
			
		}
		
		override public function Update(deltaTime:Number):void 
		{
			super.Update(deltaTime);
			
			for each(var gObject:GameObject in gameObjects)
			{
				if (!gObject || !gObject.Position)
					continue;
				
				if (gObject.IsChild)
				{
					if (gameObjects[gObject.ParentId])
					{
						gObject.Position.X = gObject.Position.LocalX + gameObjects[gObject.ParentId].Position.X;
						gObject.Position.Y = gObject.Position.LocalY + gameObjects[gObject.ParentId].Position.Y;
					}
				}
			}
		}
	}

}