package GameSystems 
{
	import flash.events.EventDispatcher;
	import flash.events.SoftKeyboardEvent;
	import GameComponents.CharacterComponent;
	import GameComponents.InputCharacterComponent;
	import flash.events.KeyboardEvent;
	
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class InputSystem extends GameSystem
	{
		public function InputSystem() 
		{
		}
		
		override public function AddEventListeners(dispatcher:EventDispatcher):void 
		{
			super.AddEventListeners(dispatcher);
			
			dispatcher.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			dispatcher.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		override public function RemoveEventListeners(dispatcher:EventDispatcher):void 
		{
			super.RemoveEventListeners(dispatcher);
			
			dispatcher.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			dispatcher.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function onKeyDown(event:KeyboardEvent)
		{
			for each(var gObject:GameObject in gameObjects)
			{
				if (!gObject || !gObject.HasComponent(GameComponent.INPUT) || !gObject.HasComponent(GameComponent.CHARACTER))
					continue;
					
				var character:CharacterComponent = gObject.GetComponent(GameComponent.CHARACTER) as CharacterComponent;
				var input:InputCharacterComponent = gObject.GetComponent(GameComponent.INPUT) as InputCharacterComponent;
				
				if (event.keyCode == input.Left)
				{
					character.Facing = CharacterComponent.LEFT;
					character.IsMoving = true;
				}
				if (event.keyCode == input.Right)
				{
					character.Facing = CharacterComponent.RIGHT;
					character.IsMoving = true;
				}
				if (event.keyCode == input.Up)
				{
					character.IsJumping = true;
				}
			}
		}
		
		private function onKeyUp(event:KeyboardEvent)
		{
			for each(var gObject:GameObject in gameObjects)
			{
				if (!gObject || !gObject.HasComponent(GameComponent.INPUT) || !gObject.HasComponent(GameComponent.CHARACTER))
					continue;
					
				var character:CharacterComponent = gObject.GetComponent(GameComponent.CHARACTER) as CharacterComponent;
				var input:InputCharacterComponent = gObject.GetComponent(GameComponent.INPUT) as InputCharacterComponent;
				
				
				if (event.keyCode == input.Left)
				{
					if(character.Facing == CharacterComponent.LEFT)
						character.IsMoving = false;
				}
				if (event.keyCode == input.Right)
				{
					if(character.Facing == CharacterComponent.RIGHT)
						character.IsMoving = false;
				}
				if (event.keyCode == input.Up)
				{
					character.IsJumping = false;
				}
			}
		}
	}

}