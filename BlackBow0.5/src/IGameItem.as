package  
{
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public interface IGameItem 
	{
		//Can be the name, but MUST BE UNIQUE (no 2 items can have the same Id if they are different)
		function GetId():String;
		
		function GetName():String;
		function Quantity():String;
		function GetDescription():String;
		
		//Is this item able to ne equipped? For example, a bow item is equippable
		function IsEquipable():Boolean;
		
		function Equipt(gameobject:GameObject):void;
	}

}