package  
{
	import Box2D.Dynamics.b2Body;
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Scott Simpson
	 * 
	 * Set up like Actor class from Puggle.
	 * 
	 */
	public class Actor extends EventDispatcher
	{
		
		protected var _body:b2Body;
		protected var _costume:DisplayObject;
		protected var _facing:String = "Left";
		
		public function Actor(myBody:b2Body, myCostume:DisplayObject) 
		{
			_body = myBody;
			_body.SetUserData(this);
			_costume = myCostume;
			
			updateMyLook();
			
		}
		
		public function updateNow():void
		{
			if (_body.GetType() != 0)
			{
			updateMyLook();
			}
			childSpecificUpdating();
			
		}
		
		protected function childSpecificUpdating():void 
		{
			//this function does nothing
			//will be called by my children
			
		}
		
		public function destroy():void
		{
			//remove event listeners
			cleanUpBeforeRemoving();
			
			//remove Costume
			_costume.parent.removeChild(_costume);
			
			//destroy the body
			WorldVals.world.DestroyBody(_body);
			
			//remove actor from the world
			//TODO FINISH THIS LATER
			
		}
		
		protected function cleanUpBeforeRemoving():void 
		{
			//the function does nothing
			//will be overridden by children
		}
		
		private function updateMyLook():void 
		{
			_costume.x = _body.GetPosition().x * WorldVals.RATIO;
			_costume.y = _body.GetPosition().y * WorldVals.RATIO;
			_costume.rotation = _body.GetAngle() * 180 / Math.PI;
			
		}
		
		public function getBody():b2Body
		{
			return _body;
		}
		
		public function getFacing():String
		{
			return _facing;
		}
		
		public function aboutFace():void
		{
			if (_facing == "Left") 
			{
				_facing = "Right";
				_costume.scaleX = Math.abs(_costume.scaleX);
			} else if (_facing == "Right") 
			{
				_facing = "Left";
				_costume.scaleX = -Math.abs(_costume.scaleX);
			}
		}
		
	}

}