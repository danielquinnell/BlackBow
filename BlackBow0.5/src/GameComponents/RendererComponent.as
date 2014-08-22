package GameComponents 
{
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class RendererComponent extends GameComponent
	{
		public var Display:DisplayObject;	
		
		//String Representing the type of Sprite/MovieClip/Bitmap/etc to use. The Rendering system should take this string and assign a value to the Display object.
		public var DisplayType:String;
		public var ScaleX:Number, ScaleY;
		
		public function RendererComponent(displayType:String, scaleX = 1, scaleY = 1) 
		{
			Type = GameComponent.RENDERER;
			Display = null;
			DisplayType = displayType;
			ScaleX = scaleX;
			ScaleY = scaleY;
		}
		
		override public function Clone():GameComponent 
		{
			return new RendererComponent(DisplayType, ScaleX, ScaleY);
		}
	}

}