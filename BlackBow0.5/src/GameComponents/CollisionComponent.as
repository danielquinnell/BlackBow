package GameComponents 
{
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class CollisionComponent extends GameComponent
	{
		//If true the systems should use it's rendering component for pixel perfect (This is a lot slower than the default Bounding Box collision detection)
		public var DisplayObjectPixelPerfect:Boolean;
		public var Width:Number, Height:Number;
		
		//Called when a collision occurs between two objects 
		public var CollisionCallBack:Function;
		
		public function CollisionComponent(pixelPerfect:Boolean, width:Number = 32, height:Number = 32) 
		{
			Type = GameComponent.COLLISION;
			DisplayObjectPixelPerfect = pixelPerfect;
			Width = width;
			Height = height;
			
			CollisionCallBack = null;
		}
	}

}