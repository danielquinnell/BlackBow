package GameSystems 
{
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.Joints.b2DistanceJoint;
	import Box2D.Dynamics.Joints.b2DistanceJointDef;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import flash.events.EventDispatcher;
	import GameComponents.PhysicsComponent;
	import GameEvents.CollisionEvent;
	/**
	 * ...
	 * @author Austin Shindlecker
	 */
	public class ProjectileSystem extends GameSystem
	{
		public function ProjectileSystem() 
		{
			
		}
		
		override public function AddEventListeners(dispatcher:EventDispatcher):void 
		{
			super.AddEventListeners(dispatcher);
			dispatcher.addEventListener(GameEventTypes.COLLISION, onCollision);
		}
		
		override public function RemoveEventListeners(dispatcher:EventDispatcher):void 
		{
			super.RemoveEventListeners(dispatcher);
			dispatcher.removeEventListener(GameEventTypes.COLLISION, onCollision);
		}
		
		private function onCollision(event:CollisionEvent)
		{
			if(event.CollisionType == CollisionEvent.ENTER)
			{
				if (event.Object1.Tag == "arrow" && event.Object2.Tag == "level")
				{
					event.Object1.RemoveComponent(event.Object1.Physics);
				}
			}
		}
		
		override public function Update(deltaTime:Number):void 
		{
			super.Update(deltaTime);
			
			for each(var gObject:GameObject in gameObjects)
			{
				if (!gObject || !gObject.HasComponent(GameComponent.PHYSICS) || !gObject.Position)
					continue;
				
				var physics:PhysicsComponent= gObject.GetComponent(GameComponent.PHYSICS) as PhysicsComponent;
				
				if(physics.BodyDefinition.fixedRotation == false)
					gObject.Position.Rotation = Math.atan2(physics.Body.GetLinearVelocity().y, physics.Body.GetLinearVelocity().x) * PhysicsSystem.DegreePerRadian;
			}
		}
	}
}