package  
{
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Dynamics.b2ContactFilter;
	/**
	 * ...
	 * @author Scott Simpson
	 * 
	 * I don't think we are going to need this
	 * call, but I am leaving it here for a place 
	 * holder just in case we realize that we do.
	 * 
	 */
	public class ContactFilter 
	{
		static public var b2_defaultFilter:b2ContactFilter = new b2ContactFilter
		
		public function ContactFilter() 
		{
			
		}
		
		public virtual function ShouldCollide(shape1:b2Shape, shape2:b2Shape):Boolean 
		{
			var filter1:b2FilterData = shape1.GetFilterData();
			var filter2:b2FilterData = shape2.GetFilterData();
			
			if (filter1.groupIndex == filter2.groupIndex && filter1.groupIndex != 0){
				return filter1.groupIndex > 0;
			}
			
			var collide:Boolean = (filter1.maskBits & filter2.categoryBits) != 0 && (filter1.categoryBits & filter2.maskBits) != 0;
			return collide;
			
		}
		
	}

}