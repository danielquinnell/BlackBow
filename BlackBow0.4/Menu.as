package  
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Scott Simpson
	 * 
	 * The Menu. Will have some buttons and stuff.
	 * someone needs to design this. 
	 * 
	 */
	public class Menu extends MovieClip 
	{
		
		private var isVisible:Boolean;
		
		public function Menu() 
		{
			isVisible = false;
			setVisibility();
		}
		
		private function setVisibility():void 
		{
			this.visible = isVisible;
		}
		
		public function toggleMenu():void
		{
			if (!isVisible) {
				isVisible = true;
			}else if (isVisible) {
				isVisible = false;
			}else {
				trace("Menu's isVisible is set to: " + isVisible);
			}
			setVisibility();
		}
		
		
		
	}

}