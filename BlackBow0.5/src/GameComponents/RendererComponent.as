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
		
		public function RendererComponent() 
		{
			Type = GameComponent.RENDERER;
		}
	}

}