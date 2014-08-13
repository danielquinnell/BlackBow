package
{
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
    import flash.utils.Dictionary;
	import GameComponents.PhysicsComponent;

    public class PhysicsData extends Object
	{
		// ptm ratio
        public var ptm_ratio:Number = 32;
		
		// the physcis data 
		var dict:Dictionary;
		
        //
        // bodytype:
        //  b2_staticBody
        //  b2_kinematicBody
        //  b2_dynamicBody

        public function createComponent(name:String):PhysicsComponent
        {
			var component:PhysicsComponent = new PhysicsComponent(0, 0, b2Body.b2_staticBody);
            var fixtures:Array = dict[name];
            var f:Number;

            // prepare fixtures
            for(f=0; f<fixtures.length; f++)
            {
                var fixture:Array = fixtures[f];

                

                if(fixture[7] == "POLYGON")
                {                    
                    var p:Number;
                    var polygons:Array = fixture[8];
                    for(p=0; p<polygons.length; p++)
                    {
						var fixtureDef:b2FixtureDef = new b2FixtureDef();

						fixtureDef.density=fixture[0];
						fixtureDef.friction=fixture[1];
						fixtureDef.restitution=fixture[2];

						fixtureDef.filter.categoryBits = fixture[3];
						fixtureDef.filter.maskBits = fixture[4];
						fixtureDef.filter.groupIndex = fixture[5];
						fixtureDef.isSensor = fixture[6];
                        var polygonShape:b2PolygonShape = new b2PolygonShape();
                        polygonShape.SetAsArray(polygons[p], polygons[p].length);
                        fixtureDef.shape = polygonShape;
						
						component.FixtureDefinitions.push(fixtureDef);
                    }
                }
                else if(fixture[7] == "CIRCLE")
                {
					var fixtureDef:b2FixtureDef = new b2FixtureDef();

					fixtureDef.density=fixture[0];
					fixtureDef.friction=fixture[1];
					fixtureDef.restitution=fixture[2];

					fixtureDef.filter.categoryBits = fixture[3];
					fixtureDef.filter.maskBits = fixture[4];
					fixtureDef.filter.groupIndex = fixture[5];
					fixtureDef.isSensor = fixture[6];
                    var circleShape:b2CircleShape = new b2CircleShape(fixture[9]);                    
                    circleShape.SetLocalPosition(fixture[8]);
                    fixtureDef.shape=circleShape;
					
					component.FixtureDefinitions.push(fixtureDef);               
                }                
            }
			
            return component;
        }

		
        public function PhysicsData(): void
		{
			dict = new Dictionary();
			

			dict["a6"] = [

										[
											// density, friction, restitution
                                            2, 0, 0,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(396.5/ptm_ratio, 261/ptm_ratio)  ,  new b2Vec2(466.5/ptm_ratio, 271/ptm_ratio)  ,  new b2Vec2(422/ptm_ratio, 311.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(234.5/ptm_ratio, 138/ptm_ratio)  ,  new b2Vec2(294/ptm_ratio, 134.5/ptm_ratio)  ,  new b2Vec2(305.5/ptm_ratio, 162/ptm_ratio)  ,  new b2Vec2(260.5/ptm_ratio, 237/ptm_ratio)  ] ,
                                                [   new b2Vec2(162/ptm_ratio, 77.5/ptm_ratio)  ,  new b2Vec2(202.5/ptm_ratio, 80/ptm_ratio)  ,  new b2Vec2(179.5/ptm_ratio, 100/ptm_ratio)  ] ,
                                                [   new b2Vec2(623.5/ptm_ratio, 294/ptm_ratio)  ,  new b2Vec2(697.5/ptm_ratio, 336/ptm_ratio)  ,  new b2Vec2(661.5/ptm_ratio, 393/ptm_ratio)  ] ,
                                                [   new b2Vec2(582.5/ptm_ratio, 293/ptm_ratio)  ,  new b2Vec2(623.5/ptm_ratio, 294/ptm_ratio)  ,  new b2Vec2(590/ptm_ratio, 313.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(505.5/ptm_ratio, 246/ptm_ratio)  ,  new b2Vec2(582.5/ptm_ratio, 293/ptm_ratio)  ,  new b2Vec2(534/ptm_ratio, 293.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(54/ptm_ratio, 117.5/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 143.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(363.5/ptm_ratio, 214/ptm_ratio)  ,  new b2Vec2(339.5/ptm_ratio, 157/ptm_ratio)  ,  new b2Vec2(797/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(505.5/ptm_ratio, 246/ptm_ratio)  ,  new b2Vec2(466.5/ptm_ratio, 271/ptm_ratio)  ,  new b2Vec2(396.5/ptm_ratio, 261/ptm_ratio)  ] ,
                                                [   new b2Vec2(720/ptm_ratio, 352.5/ptm_ratio)  ,  new b2Vec2(697.5/ptm_ratio, 336/ptm_ratio)  ,  new b2Vec2(784/ptm_ratio, 355.5/ptm_ratio)  ,  new b2Vec2(765/ptm_ratio, 370.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(202.5/ptm_ratio, 80/ptm_ratio)  ,  new b2Vec2(234.5/ptm_ratio, 138/ptm_ratio)  ,  new b2Vec2(225.5/ptm_ratio, 165/ptm_ratio)  ] ,
                                                [   new b2Vec2(202.5/ptm_ratio, 80/ptm_ratio)  ,  new b2Vec2(797/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(294/ptm_ratio, 134.5/ptm_ratio)  ,  new b2Vec2(234.5/ptm_ratio, 138/ptm_ratio)  ] ,
                                                [   new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(145/ptm_ratio, 65.5/ptm_ratio)  ,  new b2Vec2(90.5/ptm_ratio, 116/ptm_ratio)  ,  new b2Vec2(54/ptm_ratio, 117.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(145/ptm_ratio, 65.5/ptm_ratio)  ,  new b2Vec2(202.5/ptm_ratio, 80/ptm_ratio)  ,  new b2Vec2(162/ptm_ratio, 77.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(505.5/ptm_ratio, 246/ptm_ratio)  ,  new b2Vec2(797/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(623.5/ptm_ratio, 294/ptm_ratio)  ,  new b2Vec2(582.5/ptm_ratio, 293/ptm_ratio)  ] ,
                                                [   new b2Vec2(623.5/ptm_ratio, 294/ptm_ratio)  ,  new b2Vec2(797/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(784/ptm_ratio, 355.5/ptm_ratio)  ,  new b2Vec2(697.5/ptm_ratio, 336/ptm_ratio)  ] ,
                                                [   new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(797/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(202.5/ptm_ratio, 80/ptm_ratio)  ,  new b2Vec2(145/ptm_ratio, 65.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(784/ptm_ratio, 355.5/ptm_ratio)  ,  new b2Vec2(797/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 362/ptm_ratio)  ] ,
                                                [   new b2Vec2(294/ptm_ratio, 134.5/ptm_ratio)  ,  new b2Vec2(797/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(339.5/ptm_ratio, 157/ptm_ratio)  ]
											]

										]
 ,
										[
											// density, friction, restitution
                                            2, 0, 0,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(485/ptm_ratio, 387/ptm_ratio)  ,  new b2Vec2(512/ptm_ratio, 392/ptm_ratio)  ,  new b2Vec2(526/ptm_ratio, 402/ptm_ratio)  ,  new b2Vec2(535/ptm_ratio, 421/ptm_ratio)  ,  new b2Vec2(451/ptm_ratio, 407/ptm_ratio)  ,  new b2Vec2(458/ptm_ratio, 394/ptm_ratio)  ] ,
                                                [   new b2Vec2(800/ptm_ratio, 599/ptm_ratio)  ,  new b2Vec2(729/ptm_ratio, 518/ptm_ratio)  ,  new b2Vec2(777/ptm_ratio, 513/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, 520/ptm_ratio)  ] ,
                                                [   new b2Vec2(569/ptm_ratio, 457/ptm_ratio)  ,  new b2Vec2(418/ptm_ratio, 428/ptm_ratio)  ,  new b2Vec2(451/ptm_ratio, 407/ptm_ratio)  ,  new b2Vec2(535/ptm_ratio, 421/ptm_ratio)  ] ,
                                                [   new b2Vec2(164/ptm_ratio, 336/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 600/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 273/ptm_ratio)  ,  new b2Vec2(53/ptm_ratio, 240/ptm_ratio)  ,  new b2Vec2(65/ptm_ratio, 234/ptm_ratio)  ,  new b2Vec2(113/ptm_ratio, 252/ptm_ratio)  ] ,
                                                [   new b2Vec2(729/ptm_ratio, 518/ptm_ratio)  ,  new b2Vec2(800/ptm_ratio, 599/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 600/ptm_ratio)  ,  new b2Vec2(621/ptm_ratio, 500/ptm_ratio)  ,  new b2Vec2(675/ptm_ratio, 496/ptm_ratio)  ] ,
                                                [   new b2Vec2(569/ptm_ratio, 457/ptm_ratio)  ,  new b2Vec2(621/ptm_ratio, 500/ptm_ratio)  ,  new b2Vec2(361/ptm_ratio, 453/ptm_ratio)  ,  new b2Vec2(418/ptm_ratio, 428/ptm_ratio)  ] ,
                                                [   new b2Vec2(1/ptm_ratio, 600/ptm_ratio)  ,  new b2Vec2(361/ptm_ratio, 453/ptm_ratio)  ,  new b2Vec2(621/ptm_ratio, 500/ptm_ratio)  ] ,
                                                [   new b2Vec2(1/ptm_ratio, 600/ptm_ratio)  ,  new b2Vec2(303/ptm_ratio, 432/ptm_ratio)  ,  new b2Vec2(304/ptm_ratio, 432/ptm_ratio)  ,  new b2Vec2(361/ptm_ratio, 453/ptm_ratio)  ] ,
                                                [   new b2Vec2(222/ptm_ratio, 388/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 600/ptm_ratio)  ,  new b2Vec2(164/ptm_ratio, 336/ptm_ratio)  ] ,
                                                [   new b2Vec2(303/ptm_ratio, 432/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 600/ptm_ratio)  ,  new b2Vec2(222/ptm_ratio, 388/ptm_ratio)  ]
											]

										]

									];

		}
	}
}
