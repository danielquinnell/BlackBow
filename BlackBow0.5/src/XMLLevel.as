package  
{
	import flash.utils.Dictionary;
	/**
	 * 
	 * @author Austin Shindlecker
	 */
	public class XMLLevel 
	{
		private var TileGameObjectIds:Dictionary;	//<id, gameobject>
		
		public function XMLLevel() 
		{
			TileGameObjectIds = new Dictionary();
		}
		
		public function Parse(xml:XML)
		{
			trace(xml.@version);
			for each(var tileSet:XML in xml.tileset)
			{
				var firstId:Number = Number(tileSet.@firstgid);
			}
		}
		
	}

}