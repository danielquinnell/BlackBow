package GameSystems 
{
	import flash.events.EventDispatcher;
	/**
	 * Default Standard IGameSystem implementation
	 * @author Austin Shindlecker
	 */
	public class GameSystem implements IGameSystem
	{
		protected var gameScene:GameScene;
		protected var gameObjects:Array;
		
		public function GameSystem() { gameScene = null; gameObjects = null; }
		
		public function Update(deltaTime:Number):void {/* should be overrided */}
		
		public function SetGameScene(gamescene:GameScene):void { gameScene = gamescene; }
		
		public function Initialize(gameobjects:Array):void 
		{
			gameObjects = gameobjects;
			for each(var gameobj:GameObject in gameObjects)
			{
				GameObjectAdded(gameobj);
			}
		}
		
		public function GameObjectComponentRemoved(gameObjId:uint, component:GameComponent) {/* chould be overrided */}
		public function GameObjectComponentAdded(gameObjId:uint, component:GameComponent) {/* chould be overrided */}
		
		public function GameObjectRemoved(gameObj:GameObject):void {/* could be overrided */}
		public function GameObjectAdded(gameObj:GameObject):void {/* could be overrided */}
		
		public function AddEventListeners(dispatcher:EventDispatcher):void {/* chould be overrided */}
		public function RemoveEventListeners(dispatcher:EventDispatcher):void {/* chould be overrided */}
	}

}