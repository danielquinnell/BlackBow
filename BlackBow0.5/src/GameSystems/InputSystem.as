package GameSystems 
{
	import flash.events.EventDispatcher;
	import flash.events.SoftKeyboardEvent;
	import GameComponents.BowComponent;
	import GameComponents.CharacterComponent;
	import GameComponents.InputCharacterComponent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
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
			dispatcher.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			dispatcher.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			dispatcher.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		override public function RemoveEventListeners(dispatcher:EventDispatcher):void 
		{
			super.RemoveEventListeners(dispatcher);
			
			dispatcher.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			dispatcher.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			dispatcher.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			dispatcher.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			dispatcher.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onMouseMove(event:MouseEvent)
		{
			for each(var gObject:GameObject in gameObjects)
			{
				if (!gObject || !gObject.HasComponent(GameComponent.INPUT) || !gObject.HasComponent(GameComponent.CHARACTER) || !gObject.Position || !gObject.HasComponent(GameComponent.BOW))
					continue;
				
				var character:CharacterComponent = gObject.GetComponent(GameComponent.CHARACTER) as CharacterComponent;
				var bow:BowComponent = gObject.GetComponent(GameComponent.BOW) as BowComponent;
				
				bow.Angle = Math.atan2(gObject.Position.Y - event.localY, event.localX - gObject.Position.X);
				
				character.PrimaryActionState = true;
			}
		}
		
		private function onMouseDown(event:MouseEvent)
		{
			for each(var gObject:GameObject in gameObjects)
			{
				if (!gObject || !gObject.HasComponent(GameComponent.INPUT) || !gObject.HasComponent(GameComponent.CHARACTER))
					continue;
				
				var character:CharacterComponent = gObject.GetComponent(GameComponent.CHARACTER) as CharacterComponent;
				character.PrimaryActionState = true;
			}
		}
		
		private function onMouseUp(event:MouseEvent)
		{
			for each(var gObject:GameObject in gameObjects)
			{
				if (!gObject || !gObject.HasComponent(GameComponent.INPUT) || !gObject.HasComponent(GameComponent.CHARACTER))
					continue;
					
				var character:CharacterComponent = gObject.GetComponent(GameComponent.CHARACTER) as CharacterComponent;
				character.PrimaryActionState = false;
			}
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