package
{
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
    import flash.utils.Dictionary;

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

        public function createBody(name:String, world:b2World, bodyType:uint, userData:*):b2Body
        {
            var fixtures:Array = dict[name];

            var body:b2Body;
            var f:Number;

            // prepare body def
            var bodyDef:b2BodyDef = new b2BodyDef();
            bodyDef.type = bodyType;
            bodyDef.userData = userData;

            // create the body
            body = world.CreateBody(bodyDef);

            // prepare fixtures
            for(f=0; f<fixtures.length; f++)
            {
                var fixture:Array = fixtures[f];

                var fixtureDef:b2FixtureDef = new b2FixtureDef();

                fixtureDef.density=fixture[0];
                fixtureDef.friction=fixture[1];
                fixtureDef.restitution=fixture[2];

                fixtureDef.filter.categoryBits = fixture[3];
                fixtureDef.filter.maskBits = fixture[4];
                fixtureDef.filter.groupIndex = fixture[5];
                fixtureDef.isSensor = fixture[6];

                if(fixture[7] == "POLYGON")
                {                    
                    var p:Number;
                    var polygons:Array = fixture[8];
                    for(p=0; p<polygons.length; p++)
                    {
                        var polygonShape:b2PolygonShape = new b2PolygonShape();
                        polygonShape.SetAsArray(polygons[p], polygons[p].length);
                        fixtureDef.shape=polygonShape;

                        body.CreateFixture(fixtureDef);
                    }
                }
                else if(fixture[7] == "CIRCLE")
                {
                    var circleShape:b2CircleShape = new b2CircleShape(fixture[9]);                    
                    circleShape.SetLocalPosition(fixture[8]);
                    fixtureDef.shape=circleShape;
                    body.CreateFixture(fixtureDef);                    
                }                
            }

            return body;
        }

		
        public function PhysicsData(): void
		{
			dict = new Dictionary();
			

			dict["c5"] = [

										[
											// density, friction, restitution
                                            2, 0, 0,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(58/ptm_ratio, 316/ptm_ratio)  ,  new b2Vec2(55/ptm_ratio, 267/ptm_ratio)  ,  new b2Vec2(97/ptm_ratio, 293/ptm_ratio)  ] ,
                                                [   new b2Vec2(98/ptm_ratio, 85/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 1/ptm_ratio)  ,  new b2Vec2(157/ptm_ratio, 1/ptm_ratio)  ] ,
                                                [   new b2Vec2(73/ptm_ratio, 174/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 1/ptm_ratio)  ,  new b2Vec2(91/ptm_ratio, 112/ptm_ratio)  ,  new b2Vec2(97/ptm_ratio, 139/ptm_ratio)  ] ,
                                                [   new b2Vec2(2/ptm_ratio, 413/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 1/ptm_ratio)  ,  new b2Vec2(55/ptm_ratio, 267/ptm_ratio)  ,  new b2Vec2(58/ptm_ratio, 316/ptm_ratio)  ,  new b2Vec2(45/ptm_ratio, 371/ptm_ratio)  ] ,
                                                [   new b2Vec2(91/ptm_ratio, 112/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 1/ptm_ratio)  ,  new b2Vec2(98/ptm_ratio, 85/ptm_ratio)  ] ,
                                                [   new b2Vec2(56/ptm_ratio, 223/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 1/ptm_ratio)  ,  new b2Vec2(73/ptm_ratio, 174/ptm_ratio)  ] ,
                                                [   new b2Vec2(55/ptm_ratio, 267/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 1/ptm_ratio)  ,  new b2Vec2(56/ptm_ratio, 223/ptm_ratio)  ]
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

                                                [   new b2Vec2(746/ptm_ratio, 55.5/ptm_ratio)  ,  new b2Vec2(655/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(799/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(800.5/ptm_ratio, 60/ptm_ratio)  ] ,
                                                [   new b2Vec2(614/ptm_ratio, 44.5/ptm_ratio)  ,  new b2Vec2(655/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(680/ptm_ratio, 56.5/ptm_ratio)  ,  new b2Vec2(644/ptm_ratio, 62.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(707/ptm_ratio, 60.5/ptm_ratio)  ,  new b2Vec2(680/ptm_ratio, 56.5/ptm_ratio)  ,  new b2Vec2(655/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(746/ptm_ratio, 55.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(572/ptm_ratio, 35.5/ptm_ratio)  ,  new b2Vec2(655/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(614/ptm_ratio, 44.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(485/ptm_ratio, 20.5/ptm_ratio)  ,  new b2Vec2(654/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(655/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(572/ptm_ratio, 35.5/ptm_ratio)  ,  new b2Vec2(545/ptm_ratio, 39.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(397.5/ptm_ratio, 1/ptm_ratio)  ,  new b2Vec2(654/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(485/ptm_ratio, 20.5/ptm_ratio)  ,  new b2Vec2(407/ptm_ratio, 10.5/ptm_ratio)  ]
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

                                                [   new b2Vec2(801/ptm_ratio, 601/ptm_ratio)  ,  new b2Vec2(727/ptm_ratio, 559/ptm_ratio)  ,  new b2Vec2(774/ptm_ratio, 549/ptm_ratio)  ,  new b2Vec2(800/ptm_ratio, 549/ptm_ratio)  ] ,
                                                [   new b2Vec2(114/ptm_ratio, 560/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, 601/ptm_ratio)  ,  new b2Vec2(71/ptm_ratio, 536/ptm_ratio)  ,  new b2Vec2(98/ptm_ratio, 540/ptm_ratio)  ] ,
                                                [   new b2Vec2(30/ptm_ratio, 502/ptm_ratio)  ,  new b2Vec2(71/ptm_ratio, 536/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, 601/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 497/ptm_ratio)  ] ,
                                                [   new b2Vec2(801/ptm_ratio, 601/ptm_ratio)  ,  new b2Vec2(653/ptm_ratio, 561/ptm_ratio)  ,  new b2Vec2(677/ptm_ratio, 553/ptm_ratio)  ,  new b2Vec2(727/ptm_ratio, 559/ptm_ratio)  ] ,
                                                [   new b2Vec2(132/ptm_ratio, 567/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, 601/ptm_ratio)  ,  new b2Vec2(114/ptm_ratio, 560/ptm_ratio)  ] ,
                                                [   new b2Vec2(247/ptm_ratio, 573/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, 601/ptm_ratio)  ,  new b2Vec2(132/ptm_ratio, 567/ptm_ratio)  ,  new b2Vec2(213/ptm_ratio, 564/ptm_ratio)  ] ,
                                                [   new b2Vec2(653/ptm_ratio, 561/ptm_ratio)  ,  new b2Vec2(801/ptm_ratio, 601/ptm_ratio)  ,  new b2Vec2(560/ptm_ratio, 569/ptm_ratio)  ,  new b2Vec2(623/ptm_ratio, 558/ptm_ratio)  ] ,
                                                [   new b2Vec2(457/ptm_ratio, 560/ptm_ratio)  ,  new b2Vec2(560/ptm_ratio, 569/ptm_ratio)  ,  new b2Vec2(247/ptm_ratio, 573/ptm_ratio)  ,  new b2Vec2(333/ptm_ratio, 558/ptm_ratio)  ] ,
                                                [   new b2Vec2(2/ptm_ratio, 601/ptm_ratio)  ,  new b2Vec2(247/ptm_ratio, 573/ptm_ratio)  ,  new b2Vec2(560/ptm_ratio, 569/ptm_ratio)  ,  new b2Vec2(801/ptm_ratio, 601/ptm_ratio)  ] ,
                                                [   new b2Vec2(457/ptm_ratio, 560/ptm_ratio)  ,  new b2Vec2(458/ptm_ratio, 560/ptm_ratio)  ,  new b2Vec2(560/ptm_ratio, 569/ptm_ratio)  ]
											]

										]

									];

			dict["c6"] = [

										[
											// density, friction, restitution
                                            2, 0, 0,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(296/ptm_ratio, 246.5/ptm_ratio)  ,  new b2Vec2(259.5/ptm_ratio, 189/ptm_ratio)  ,  new b2Vec2(317.5/ptm_ratio, 201/ptm_ratio)  ,  new b2Vec2(318.5/ptm_ratio, 234/ptm_ratio)  ,  new b2Vec2(311.5/ptm_ratio, 246/ptm_ratio)  ] ,
                                                [   new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(167/ptm_ratio, 92.5/ptm_ratio)  ,  new b2Vec2(125/ptm_ratio, 95.5/ptm_ratio)  ,  new b2Vec2(41/ptm_ratio, 89.5/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, 63.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(41/ptm_ratio, 89.5/ptm_ratio)  ,  new b2Vec2(125/ptm_ratio, 95.5/ptm_ratio)  ,  new b2Vec2(95/ptm_ratio, 115.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(341.5/ptm_ratio, 185/ptm_ratio)  ,  new b2Vec2(374.5/ptm_ratio, 186/ptm_ratio)  ,  new b2Vec2(364.5/ptm_ratio, 213/ptm_ratio)  ,  new b2Vec2(352/ptm_ratio, 217.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(341.5/ptm_ratio, 185/ptm_ratio)  ,  new b2Vec2(336/ptm_ratio, 180.5/ptm_ratio)  ,  new b2Vec2(394/ptm_ratio, 155.5/ptm_ratio)  ,  new b2Vec2(374.5/ptm_ratio, 186/ptm_ratio)  ] ,
                                                [   new b2Vec2(491/ptm_ratio, 217.5/ptm_ratio)  ,  new b2Vec2(483.5/ptm_ratio, 187/ptm_ratio)  ,  new b2Vec2(507.5/ptm_ratio, 195/ptm_ratio)  ,  new b2Vec2(500.5/ptm_ratio, 216/ptm_ratio)  ] ,
                                                [   new b2Vec2(259.5/ptm_ratio, 189/ptm_ratio)  ,  new b2Vec2(227/ptm_ratio, 169.5/ptm_ratio)  ,  new b2Vec2(194.5/ptm_ratio, 104/ptm_ratio)  ,  new b2Vec2(327/ptm_ratio, 182.5/ptm_ratio)  ,  new b2Vec2(317.5/ptm_ratio, 201/ptm_ratio)  ] ,
                                                [   new b2Vec2(465.5/ptm_ratio, 160/ptm_ratio)  ,  new b2Vec2(630.5/ptm_ratio, 178/ptm_ratio)  ,  new b2Vec2(561/ptm_ratio, 190.5/ptm_ratio)  ,  new b2Vec2(507.5/ptm_ratio, 195/ptm_ratio)  ,  new b2Vec2(483.5/ptm_ratio, 187/ptm_ratio)  ] ,
                                                [   new b2Vec2(507.5/ptm_ratio, 195/ptm_ratio)  ,  new b2Vec2(561/ptm_ratio, 190.5/ptm_ratio)  ,  new b2Vec2(525/ptm_ratio, 209.5/ptm_ratio)  ,  new b2Vec2(513/ptm_ratio, 203.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(630.5/ptm_ratio, 178/ptm_ratio)  ,  new b2Vec2(797/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(720/ptm_ratio, 225.5/ptm_ratio)  ,  new b2Vec2(645/ptm_ratio, 197.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(561/ptm_ratio, 190.5/ptm_ratio)  ,  new b2Vec2(630.5/ptm_ratio, 178/ptm_ratio)  ,  new b2Vec2(576/ptm_ratio, 192.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(442/ptm_ratio, 145.5/ptm_ratio)  ,  new b2Vec2(797/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(630.5/ptm_ratio, 178/ptm_ratio)  ,  new b2Vec2(465.5/ptm_ratio, 160/ptm_ratio)  ] ,
                                                [   new b2Vec2(788/ptm_ratio, 268.5/ptm_ratio)  ,  new b2Vec2(797/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 281/ptm_ratio)  ] ,
                                                [   new b2Vec2(720/ptm_ratio, 225.5/ptm_ratio)  ,  new b2Vec2(797/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(788/ptm_ratio, 268.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(442/ptm_ratio, 145.5/ptm_ratio)  ,  new b2Vec2(412/ptm_ratio, 147.5/ptm_ratio)  ,  new b2Vec2(194.5/ptm_ratio, 104/ptm_ratio)  ,  new b2Vec2(167/ptm_ratio, 92.5/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(797/ptm_ratio, -0.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(194.5/ptm_ratio, 104/ptm_ratio)  ,  new b2Vec2(412/ptm_ratio, 147.5/ptm_ratio)  ,  new b2Vec2(336/ptm_ratio, 180.5/ptm_ratio)  ,  new b2Vec2(327/ptm_ratio, 182.5/ptm_ratio)  ]
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

                                                [   new b2Vec2(410.5/ptm_ratio, 374/ptm_ratio)  ,  new b2Vec2(397.5/ptm_ratio, 354/ptm_ratio)  ,  new b2Vec2(392/ptm_ratio, 317/ptm_ratio)  ,  new b2Vec2(425/ptm_ratio, 313.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(54/ptm_ratio, 508.5/ptm_ratio)  ,  new b2Vec2(347/ptm_ratio, 577.5/ptm_ratio)  ,  new b2Vec2(319/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 518/ptm_ratio)  ] ,
                                                [   new b2Vec2(469/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(461.5/ptm_ratio, 578/ptm_ratio)  ,  new b2Vec2(797/ptm_ratio, 484.5/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 598/ptm_ratio)  ] ,
                                                [   new b2Vec2(392/ptm_ratio, 317/ptm_ratio)  ,  new b2Vec2(373.5/ptm_ratio, 323/ptm_ratio)  ,  new b2Vec2(362/ptm_ratio, 316.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(392/ptm_ratio, 317/ptm_ratio)  ,  new b2Vec2(397.5/ptm_ratio, 354/ptm_ratio)  ,  new b2Vec2(373.5/ptm_ratio, 323/ptm_ratio)  ] ,
                                                [   new b2Vec2(797/ptm_ratio, 484.5/ptm_ratio)  ,  new b2Vec2(747/ptm_ratio, 494/ptm_ratio)  ,  new b2Vec2(770/ptm_ratio, 484.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(410.5/ptm_ratio, 404/ptm_ratio)  ,  new b2Vec2(398.5/ptm_ratio, 450/ptm_ratio)  ,  new b2Vec2(397.5/ptm_ratio, 354/ptm_ratio)  ,  new b2Vec2(410.5/ptm_ratio, 374/ptm_ratio)  ] ,
                                                [   new b2Vec2(416.5/ptm_ratio, 431/ptm_ratio)  ,  new b2Vec2(398.5/ptm_ratio, 450/ptm_ratio)  ,  new b2Vec2(410.5/ptm_ratio, 404/ptm_ratio)  ] ,
                                                [   new b2Vec2(428/ptm_ratio, 444.5/ptm_ratio)  ,  new b2Vec2(398.5/ptm_ratio, 450/ptm_ratio)  ,  new b2Vec2(416.5/ptm_ratio, 431/ptm_ratio)  ] ,
                                                [   new b2Vec2(476/ptm_ratio, 466.5/ptm_ratio)  ,  new b2Vec2(497/ptm_ratio, 485.5/ptm_ratio)  ,  new b2Vec2(398.5/ptm_ratio, 451/ptm_ratio)  ,  new b2Vec2(398.5/ptm_ratio, 450/ptm_ratio)  ,  new b2Vec2(428/ptm_ratio, 444.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(168/ptm_ratio, 533.5/ptm_ratio)  ,  new b2Vec2(102/ptm_ratio, 518.5/ptm_ratio)  ,  new b2Vec2(132/ptm_ratio, 519.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(347/ptm_ratio, 506.5/ptm_ratio)  ,  new b2Vec2(380/ptm_ratio, 498.5/ptm_ratio)  ,  new b2Vec2(497/ptm_ratio, 485.5/ptm_ratio)  ,  new b2Vec2(584/ptm_ratio, 497.5/ptm_ratio)  ,  new b2Vec2(303/ptm_ratio, 537.5/ptm_ratio)  ,  new b2Vec2(316.5/ptm_ratio, 522/ptm_ratio)  ] ,
                                                [   new b2Vec2(347/ptm_ratio, 577.5/ptm_ratio)  ,  new b2Vec2(168/ptm_ratio, 533.5/ptm_ratio)  ,  new b2Vec2(437/ptm_ratio, 558.5/ptm_ratio)  ,  new b2Vec2(404/ptm_ratio, 572.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(747/ptm_ratio, 494/ptm_ratio)  ,  new b2Vec2(584/ptm_ratio, 497.5/ptm_ratio)  ,  new b2Vec2(641/ptm_ratio, 485.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(437/ptm_ratio, 558.5/ptm_ratio)  ,  new b2Vec2(797/ptm_ratio, 484.5/ptm_ratio)  ,  new b2Vec2(461.5/ptm_ratio, 578/ptm_ratio)  ] ,
                                                [   new b2Vec2(497/ptm_ratio, 485.5/ptm_ratio)  ,  new b2Vec2(380/ptm_ratio, 498.5/ptm_ratio)  ,  new b2Vec2(398.5/ptm_ratio, 451/ptm_ratio)  ] ,
                                                [   new b2Vec2(747/ptm_ratio, 494/ptm_ratio)  ,  new b2Vec2(437/ptm_ratio, 558.5/ptm_ratio)  ,  new b2Vec2(303/ptm_ratio, 537.5/ptm_ratio)  ,  new b2Vec2(584/ptm_ratio, 497.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(303/ptm_ratio, 537.5/ptm_ratio)  ,  new b2Vec2(437/ptm_ratio, 558.5/ptm_ratio)  ,  new b2Vec2(255/ptm_ratio, 540.5/ptm_ratio)  ]
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

                                                [   new b2Vec2(327/ptm_ratio, 341.5/ptm_ratio)  ,  new b2Vec2(328/ptm_ratio, 341.5/ptm_ratio)  ,  new b2Vec2(343/ptm_ratio, 343.5/ptm_ratio)  ,  new b2Vec2(321.5/ptm_ratio, 376/ptm_ratio)  ,  new b2Vec2(290/ptm_ratio, 355.5/ptm_ratio)  ]
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

                                                [   new b2Vec2(273.5/ptm_ratio, 420/ptm_ratio)  ,  new b2Vec2(248.5/ptm_ratio, 462/ptm_ratio)  ,  new b2Vec2(224.5/ptm_ratio, 396/ptm_ratio)  ,  new b2Vec2(257/ptm_ratio, 399/ptm_ratio)  ,  new b2Vec2(271/ptm_ratio, 401.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(224.5/ptm_ratio, 396/ptm_ratio)  ,  new b2Vec2(248.5/ptm_ratio, 462/ptm_ratio)  ,  new b2Vec2(243.5/ptm_ratio, 483/ptm_ratio)  ]
											]

										]

									];

			dict["c7"] = [

										[
											// density, friction, restitution
                                            2, 0, 0,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(34/ptm_ratio, 22/ptm_ratio)  ,  new b2Vec2(51/ptm_ratio, 20/ptm_ratio)  ,  new b2Vec2(43/ptm_ratio, 31/ptm_ratio)  ] ,
                                                [   new b2Vec2(298/ptm_ratio, 261/ptm_ratio)  ,  new b2Vec2(278/ptm_ratio, 285/ptm_ratio)  ,  new b2Vec2(248/ptm_ratio, 289/ptm_ratio)  ,  new b2Vec2(273/ptm_ratio, 225/ptm_ratio)  ,  new b2Vec2(300/ptm_ratio, 233/ptm_ratio)  ] ,
                                                [   new b2Vec2(313/ptm_ratio, 310/ptm_ratio)  ,  new b2Vec2(278/ptm_ratio, 285/ptm_ratio)  ,  new b2Vec2(298/ptm_ratio, 261/ptm_ratio)  ,  new b2Vec2(342/ptm_ratio, 292/ptm_ratio)  ] ,
                                                [   new b2Vec2(81/ptm_ratio, 46/ptm_ratio)  ,  new b2Vec2(95/ptm_ratio, 74/ptm_ratio)  ,  new b2Vec2(79/ptm_ratio, 66/ptm_ratio)  ,  new b2Vec2(74/ptm_ratio, 57/ptm_ratio)  ] ,
                                                [   new b2Vec2(182/ptm_ratio, 306/ptm_ratio)  ,  new b2Vec2(167/ptm_ratio, 291/ptm_ratio)  ,  new b2Vec2(230/ptm_ratio, 296/ptm_ratio)  ,  new b2Vec2(206/ptm_ratio, 315/ptm_ratio)  ] ,
                                                [   new b2Vec2(248/ptm_ratio, 289/ptm_ratio)  ,  new b2Vec2(179/ptm_ratio, 166/ptm_ratio)  ,  new b2Vec2(230/ptm_ratio, 187/ptm_ratio)  ,  new b2Vec2(273/ptm_ratio, 225/ptm_ratio)  ] ,
                                                [   new b2Vec2(482/ptm_ratio, 405/ptm_ratio)  ,  new b2Vec2(469/ptm_ratio, 386/ptm_ratio)  ,  new b2Vec2(438/ptm_ratio, 326/ptm_ratio)  ,  new b2Vec2(427/ptm_ratio, 278/ptm_ratio)  ,  new b2Vec2(797/ptm_ratio, -2/ptm_ratio)  ,  new b2Vec2(551/ptm_ratio, 402/ptm_ratio)  ,  new b2Vec2(499/ptm_ratio, 426/ptm_ratio)  ] ,
                                                [   new b2Vec2(47/ptm_ratio, 74/ptm_ratio)  ,  new b2Vec2(31/ptm_ratio, 260/ptm_ratio)  ,  new b2Vec2(21/ptm_ratio, 56/ptm_ratio)  ,  new b2Vec2(41/ptm_ratio, 61/ptm_ratio)  ] ,
                                                [   new b2Vec2(55/ptm_ratio, 268/ptm_ratio)  ,  new b2Vec2(76/ptm_ratio, 101/ptm_ratio)  ,  new b2Vec2(90/ptm_ratio, 104/ptm_ratio)  ,  new b2Vec2(117/ptm_ratio, 135/ptm_ratio)  ,  new b2Vec2(140/ptm_ratio, 275/ptm_ratio)  ,  new b2Vec2(104/ptm_ratio, 285/ptm_ratio)  ,  new b2Vec2(77/ptm_ratio, 286/ptm_ratio)  ] ,
                                                [   new b2Vec2(477/ptm_ratio, 586/ptm_ratio)  ,  new b2Vec2(501/ptm_ratio, 579/ptm_ratio)  ,  new b2Vec2(599/ptm_ratio, 560/ptm_ratio)  ,  new b2Vec2(644/ptm_ratio, 553/ptm_ratio)  ,  new b2Vec2(800/ptm_ratio, 599/ptm_ratio)  ,  new b2Vec2(472/ptm_ratio, 599/ptm_ratio)  ,  new b2Vec2(470/ptm_ratio, 594/ptm_ratio)  ] ,
                                                [   new b2Vec2(599/ptm_ratio, 560/ptm_ratio)  ,  new b2Vec2(501/ptm_ratio, 579/ptm_ratio)  ,  new b2Vec2(530/ptm_ratio, 549/ptm_ratio)  ] ,
                                                [   new b2Vec2(34/ptm_ratio, 22/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, -2/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, -2/ptm_ratio)  ,  new b2Vec2(63/ptm_ratio, 10/ptm_ratio)  ,  new b2Vec2(51/ptm_ratio, 20/ptm_ratio)  ] ,
                                                [   new b2Vec2(81/ptm_ratio, 46/ptm_ratio)  ,  new b2Vec2(75/ptm_ratio, 28/ptm_ratio)  ,  new b2Vec2(300/ptm_ratio, 164/ptm_ratio)  ,  new b2Vec2(255/ptm_ratio, 166/ptm_ratio)  ] ,
                                                [   new b2Vec2(179/ptm_ratio, 166/ptm_ratio)  ,  new b2Vec2(248/ptm_ratio, 289/ptm_ratio)  ,  new b2Vec2(230/ptm_ratio, 296/ptm_ratio)  ,  new b2Vec2(140/ptm_ratio, 275/ptm_ratio)  ,  new b2Vec2(117/ptm_ratio, 135/ptm_ratio)  ,  new b2Vec2(159/ptm_ratio, 146/ptm_ratio)  ] ,
                                                [   new b2Vec2(636/ptm_ratio, 502/ptm_ratio)  ,  new b2Vec2(583/ptm_ratio, 436/ptm_ratio)  ,  new b2Vec2(577/ptm_ratio, 421/ptm_ratio)  ,  new b2Vec2(797/ptm_ratio, -2/ptm_ratio)  ,  new b2Vec2(681/ptm_ratio, 512/ptm_ratio)  ,  new b2Vec2(663/ptm_ratio, 513/ptm_ratio)  ] ,
                                                [   new b2Vec2(104/ptm_ratio, 285/ptm_ratio)  ,  new b2Vec2(140/ptm_ratio, 275/ptm_ratio)  ,  new b2Vec2(110/ptm_ratio, 289/ptm_ratio)  ] ,
                                                [   new b2Vec2(140/ptm_ratio, 275/ptm_ratio)  ,  new b2Vec2(230/ptm_ratio, 296/ptm_ratio)  ,  new b2Vec2(167/ptm_ratio, 291/ptm_ratio)  ] ,
                                                [   new b2Vec2(81/ptm_ratio, 46/ptm_ratio)  ,  new b2Vec2(205/ptm_ratio, 132/ptm_ratio)  ,  new b2Vec2(149/ptm_ratio, 112/ptm_ratio)  ,  new b2Vec2(114/ptm_ratio, 94/ptm_ratio)  ,  new b2Vec2(95/ptm_ratio, 74/ptm_ratio)  ] ,
                                                [   new b2Vec2(469/ptm_ratio, 386/ptm_ratio)  ,  new b2Vec2(482/ptm_ratio, 405/ptm_ratio)  ,  new b2Vec2(290/ptm_ratio, 405/ptm_ratio)  ,  new b2Vec2(288/ptm_ratio, 385/ptm_ratio)  ] ,
                                                [   new b2Vec2(1/ptm_ratio, -2/ptm_ratio)  ,  new b2Vec2(21/ptm_ratio, 56/ptm_ratio)  ,  new b2Vec2(31/ptm_ratio, 260/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, 281/ptm_ratio)  ] ,
                                                [   new b2Vec2(31/ptm_ratio, 260/ptm_ratio)  ,  new b2Vec2(63/ptm_ratio, 90/ptm_ratio)  ,  new b2Vec2(76/ptm_ratio, 101/ptm_ratio)  ,  new b2Vec2(55/ptm_ratio, 268/ptm_ratio)  ] ,
                                                [   new b2Vec2(683/ptm_ratio, 538/ptm_ratio)  ,  new b2Vec2(800/ptm_ratio, 599/ptm_ratio)  ,  new b2Vec2(644/ptm_ratio, 553/ptm_ratio)  ] ,
                                                [   new b2Vec2(694/ptm_ratio, 530/ptm_ratio)  ,  new b2Vec2(800/ptm_ratio, 599/ptm_ratio)  ,  new b2Vec2(683/ptm_ratio, 538/ptm_ratio)  ] ,
                                                [   new b2Vec2(694/ptm_ratio, 530/ptm_ratio)  ,  new b2Vec2(681/ptm_ratio, 512/ptm_ratio)  ,  new b2Vec2(797/ptm_ratio, -2/ptm_ratio)  ,  new b2Vec2(800/ptm_ratio, 599/ptm_ratio)  ] ,
                                                [   new b2Vec2(31/ptm_ratio, 260/ptm_ratio)  ,  new b2Vec2(47/ptm_ratio, 74/ptm_ratio)  ,  new b2Vec2(63/ptm_ratio, 90/ptm_ratio)  ] ,
                                                [   new b2Vec2(300/ptm_ratio, 164/ptm_ratio)  ,  new b2Vec2(797/ptm_ratio, -2/ptm_ratio)  ,  new b2Vec2(427/ptm_ratio, 278/ptm_ratio)  ,  new b2Vec2(368/ptm_ratio, 237/ptm_ratio)  ] ,
                                                [   new b2Vec2(1/ptm_ratio, -2/ptm_ratio)  ,  new b2Vec2(34/ptm_ratio, 22/ptm_ratio)  ,  new b2Vec2(21/ptm_ratio, 56/ptm_ratio)  ] ,
                                                [   new b2Vec2(63/ptm_ratio, 10/ptm_ratio)  ,  new b2Vec2(797/ptm_ratio, -2/ptm_ratio)  ,  new b2Vec2(300/ptm_ratio, 164/ptm_ratio)  ,  new b2Vec2(75/ptm_ratio, 28/ptm_ratio)  ] ,
                                                [   new b2Vec2(551/ptm_ratio, 402/ptm_ratio)  ,  new b2Vec2(797/ptm_ratio, -2/ptm_ratio)  ,  new b2Vec2(577/ptm_ratio, 421/ptm_ratio)  ] ,
                                                [   new b2Vec2(63/ptm_ratio, 10/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, -2/ptm_ratio)  ,  new b2Vec2(797/ptm_ratio, -2/ptm_ratio)  ]
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

                                                [   new b2Vec2(85/ptm_ratio, 443.5/ptm_ratio)  ,  new b2Vec2(66/ptm_ratio, 475.5/ptm_ratio)  ,  new b2Vec2(56.5/ptm_ratio, 421/ptm_ratio)  ] ,
                                                [   new b2Vec2(188.5/ptm_ratio, 516/ptm_ratio)  ,  new b2Vec2(122/ptm_ratio, 482.5/ptm_ratio)  ,  new b2Vec2(158/ptm_ratio, 458.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(289.5/ptm_ratio, 578/ptm_ratio)  ,  new b2Vec2(247/ptm_ratio, 551.5/ptm_ratio)  ,  new b2Vec2(277/ptm_ratio, 550.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(-0.5/ptm_ratio, 487/ptm_ratio)  ,  new b2Vec2(33/ptm_ratio, 486.5/ptm_ratio)  ,  new b2Vec2(320.5/ptm_ratio, 599/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, 600.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(320.5/ptm_ratio, 599/ptm_ratio)  ,  new b2Vec2(289.5/ptm_ratio, 578/ptm_ratio)  ,  new b2Vec2(316/ptm_ratio, 587.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(247/ptm_ratio, 551.5/ptm_ratio)  ,  new b2Vec2(188.5/ptm_ratio, 516/ptm_ratio)  ,  new b2Vec2(225/ptm_ratio, 528.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(289.5/ptm_ratio, 578/ptm_ratio)  ,  new b2Vec2(320.5/ptm_ratio, 599/ptm_ratio)  ,  new b2Vec2(33/ptm_ratio, 486.5/ptm_ratio)  ,  new b2Vec2(66/ptm_ratio, 475.5/ptm_ratio)  ,  new b2Vec2(122/ptm_ratio, 482.5/ptm_ratio)  ,  new b2Vec2(188.5/ptm_ratio, 516/ptm_ratio)  ] ,
                                                [   new b2Vec2(86/ptm_ratio, 443.5/ptm_ratio)  ,  new b2Vec2(122/ptm_ratio, 482.5/ptm_ratio)  ,  new b2Vec2(66/ptm_ratio, 475.5/ptm_ratio)  ,  new b2Vec2(85/ptm_ratio, 443.5/ptm_ratio)  ]
											]

										]

									];

			dict["a1"] = [

										[
											// density, friction, restitution
                                            2, 0, 0,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(409.5/ptm_ratio, 347/ptm_ratio)  ,  new b2Vec2(391/ptm_ratio, 347/ptm_ratio)  ,  new b2Vec2(397.5/ptm_ratio, 329/ptm_ratio)  ] ,
                                                [   new b2Vec2(736.5/ptm_ratio, 273/ptm_ratio)  ,  new b2Vec2(728.5/ptm_ratio, 279/ptm_ratio)  ,  new b2Vec2(717.5/ptm_ratio, 268/ptm_ratio)  ,  new b2Vec2(744/ptm_ratio, 255.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(798.5/ptm_ratio, 600/ptm_ratio)  ,  new b2Vec2(708/ptm_ratio, 516.5/ptm_ratio)  ,  new b2Vec2(729/ptm_ratio, 506.5/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, 503.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(391/ptm_ratio, 347/ptm_ratio)  ,  new b2Vec2(381/ptm_ratio, 367.5/ptm_ratio)  ,  new b2Vec2(377.5/ptm_ratio, 335/ptm_ratio)  ] ,
                                                [   new b2Vec2(464/ptm_ratio, 175.5/ptm_ratio)  ,  new b2Vec2(464.5/ptm_ratio, 164/ptm_ratio)  ,  new b2Vec2(477/ptm_ratio, 159.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(542.5/ptm_ratio, 266/ptm_ratio)  ,  new b2Vec2(555/ptm_ratio, 277.5/ptm_ratio)  ,  new b2Vec2(565/ptm_ratio, 301.5/ptm_ratio)  ,  new b2Vec2(544/ptm_ratio, 293.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(341.5/ptm_ratio, 418/ptm_ratio)  ,  new b2Vec2(338.5/ptm_ratio, 406/ptm_ratio)  ,  new b2Vec2(351.5/ptm_ratio, 388/ptm_ratio)  ,  new b2Vec2(383/ptm_ratio, 427.5/ptm_ratio)  ,  new b2Vec2(359/ptm_ratio, 434.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(409.5/ptm_ratio, 347/ptm_ratio)  ,  new b2Vec2(440/ptm_ratio, 355.5/ptm_ratio)  ,  new b2Vec2(445.5/ptm_ratio, 364/ptm_ratio)  ,  new b2Vec2(444.5/ptm_ratio, 376/ptm_ratio)  ,  new b2Vec2(381/ptm_ratio, 367.5/ptm_ratio)  ,  new b2Vec2(391/ptm_ratio, 347/ptm_ratio)  ] ,
                                                [   new b2Vec2(523.5/ptm_ratio, 419/ptm_ratio)  ,  new b2Vec2(483/ptm_ratio, 399.5/ptm_ratio)  ,  new b2Vec2(497/ptm_ratio, 397.5/ptm_ratio)  ,  new b2Vec2(518/ptm_ratio, 401.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(448/ptm_ratio, 152.5/ptm_ratio)  ,  new b2Vec2(459.5/ptm_ratio, 158/ptm_ratio)  ,  new b2Vec2(464.5/ptm_ratio, 164/ptm_ratio)  ,  new b2Vec2(452.5/ptm_ratio, 163/ptm_ratio)  ,  new b2Vec2(442/ptm_ratio, 154.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(427.5/ptm_ratio, 189/ptm_ratio)  ,  new b2Vec2(442/ptm_ratio, 178.5/ptm_ratio)  ,  new b2Vec2(441/ptm_ratio, 186.5/ptm_ratio)  ,  new b2Vec2(422/ptm_ratio, 204.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(527/ptm_ratio, 234.5/ptm_ratio)  ,  new b2Vec2(530/ptm_ratio, 215.5/ptm_ratio)  ,  new b2Vec2(536.5/ptm_ratio, 193/ptm_ratio)  ,  new b2Vec2(542.5/ptm_ratio, 220/ptm_ratio)  ] ,
                                                [   new b2Vec2(511/ptm_ratio, 180.5/ptm_ratio)  ,  new b2Vec2(499.5/ptm_ratio, 185/ptm_ratio)  ,  new b2Vec2(485.5/ptm_ratio, 166/ptm_ratio)  ] ,
                                                [   new b2Vec2(507.5/ptm_ratio, 198/ptm_ratio)  ,  new b2Vec2(498/ptm_ratio, 194.5/ptm_ratio)  ,  new b2Vec2(499.5/ptm_ratio, 185/ptm_ratio)  ,  new b2Vec2(511/ptm_ratio, 180.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(733/ptm_ratio, 353.5/ptm_ratio)  ,  new b2Vec2(737.5/ptm_ratio, 341/ptm_ratio)  ,  new b2Vec2(746.5/ptm_ratio, 333/ptm_ratio)  ,  new b2Vec2(751/ptm_ratio, 334.5/ptm_ratio)  ,  new b2Vec2(745.5/ptm_ratio, 350/ptm_ratio)  ] ,
                                                [   new b2Vec2(726.5/ptm_ratio, 297/ptm_ratio)  ,  new b2Vec2(715.5/ptm_ratio, 311/ptm_ratio)  ,  new b2Vec2(717.5/ptm_ratio, 268/ptm_ratio)  ,  new b2Vec2(728.5/ptm_ratio, 279/ptm_ratio)  ] ,
                                                [   new b2Vec2(628/ptm_ratio, 215.5/ptm_ratio)  ,  new b2Vec2(648/ptm_ratio, 239.5/ptm_ratio)  ,  new b2Vec2(637.5/ptm_ratio, 246/ptm_ratio)  ,  new b2Vec2(627.5/ptm_ratio, 236/ptm_ratio)  ,  new b2Vec2(616.5/ptm_ratio, 209/ptm_ratio)  ] ,
                                                [   new b2Vec2(444/ptm_ratio, 317.5/ptm_ratio)  ,  new b2Vec2(459/ptm_ratio, 319.5/ptm_ratio)  ,  new b2Vec2(467/ptm_ratio, 323.5/ptm_ratio)  ,  new b2Vec2(452/ptm_ratio, 327.5/ptm_ratio)  ,  new b2Vec2(443.5/ptm_ratio, 323/ptm_ratio)  ] ,
                                                [   new b2Vec2(457/ptm_ratio, 263.5/ptm_ratio)  ,  new b2Vec2(469/ptm_ratio, 272.5/ptm_ratio)  ,  new b2Vec2(442/ptm_ratio, 265.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(499/ptm_ratio, 453.5/ptm_ratio)  ,  new b2Vec2(475/ptm_ratio, 444.5/ptm_ratio)  ,  new b2Vec2(539/ptm_ratio, 437.5/ptm_ratio)  ,  new b2Vec2(526/ptm_ratio, 453.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(442/ptm_ratio, 178.5/ptm_ratio)  ,  new b2Vec2(427.5/ptm_ratio, 189/ptm_ratio)  ,  new b2Vec2(415/ptm_ratio, 185.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(454/ptm_ratio, 181.5/ptm_ratio)  ,  new b2Vec2(459/ptm_ratio, 193.5/ptm_ratio)  ,  new b2Vec2(441/ptm_ratio, 186.5/ptm_ratio)  ,  new b2Vec2(442/ptm_ratio, 178.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(584.5/ptm_ratio, 233/ptm_ratio)  ,  new b2Vec2(576/ptm_ratio, 228.5/ptm_ratio)  ,  new b2Vec2(595/ptm_ratio, 209.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(536.5/ptm_ratio, 193/ptm_ratio)  ,  new b2Vec2(524.5/ptm_ratio, 200/ptm_ratio)  ,  new b2Vec2(528.5/ptm_ratio, 185/ptm_ratio)  ,  new b2Vec2(546/ptm_ratio, 162.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(536.5/ptm_ratio, 193/ptm_ratio)  ,  new b2Vec2(530/ptm_ratio, 215.5/ptm_ratio)  ,  new b2Vec2(524.5/ptm_ratio, 200/ptm_ratio)  ] ,
                                                [   new b2Vec2(555/ptm_ratio, 277.5/ptm_ratio)  ,  new b2Vec2(542.5/ptm_ratio, 266/ptm_ratio)  ,  new b2Vec2(548.5/ptm_ratio, 251/ptm_ratio)  ,  new b2Vec2(559/ptm_ratio, 241.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(449.5/ptm_ratio, 289/ptm_ratio)  ,  new b2Vec2(474/ptm_ratio, 280.5/ptm_ratio)  ,  new b2Vec2(506/ptm_ratio, 323/ptm_ratio)  ,  new b2Vec2(479/ptm_ratio, 329.5/ptm_ratio)  ,  new b2Vec2(459/ptm_ratio, 319.5/ptm_ratio)  ,  new b2Vec2(445.5/ptm_ratio, 301/ptm_ratio)  ] ,
                                                [   new b2Vec2(464.5/ptm_ratio, 164/ptm_ratio)  ,  new b2Vec2(459.5/ptm_ratio, 158/ptm_ratio)  ,  new b2Vec2(459.5/ptm_ratio, 149/ptm_ratio)  ] ,
                                                [   new b2Vec2(464/ptm_ratio, 175.5/ptm_ratio)  ,  new b2Vec2(459/ptm_ratio, 193.5/ptm_ratio)  ,  new b2Vec2(454/ptm_ratio, 181.5/ptm_ratio)  ,  new b2Vec2(452.5/ptm_ratio, 163/ptm_ratio)  ,  new b2Vec2(464.5/ptm_ratio, 164/ptm_ratio)  ] ,
                                                [   new b2Vec2(476.5/ptm_ratio, 196/ptm_ratio)  ,  new b2Vec2(459/ptm_ratio, 193.5/ptm_ratio)  ,  new b2Vec2(464/ptm_ratio, 175.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(476.5/ptm_ratio, 196/ptm_ratio)  ,  new b2Vec2(457/ptm_ratio, 263.5/ptm_ratio)  ,  new b2Vec2(446.5/ptm_ratio, 230/ptm_ratio)  ,  new b2Vec2(450.5/ptm_ratio, 209/ptm_ratio)  ,  new b2Vec2(459/ptm_ratio, 193.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(487.5/ptm_ratio, 387/ptm_ratio)  ,  new b2Vec2(483/ptm_ratio, 399.5/ptm_ratio)  ,  new b2Vec2(477.5/ptm_ratio, 388/ptm_ratio)  ,  new b2Vec2(494/ptm_ratio, 362.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(497/ptm_ratio, 397.5/ptm_ratio)  ,  new b2Vec2(483/ptm_ratio, 399.5/ptm_ratio)  ,  new b2Vec2(487.5/ptm_ratio, 387/ptm_ratio)  ] ,
                                                [   new b2Vec2(110/ptm_ratio, 558.5/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 596/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, 560.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(704/ptm_ratio, 372.5/ptm_ratio)  ,  new b2Vec2(715.5/ptm_ratio, 311/ptm_ratio)  ,  new b2Vec2(735.5/ptm_ratio, 329/ptm_ratio)  ,  new b2Vec2(733/ptm_ratio, 353.5/ptm_ratio)  ,  new b2Vec2(719.5/ptm_ratio, 370/ptm_ratio)  ] ,
                                                [   new b2Vec2(529/ptm_ratio, 342.5/ptm_ratio)  ,  new b2Vec2(571/ptm_ratio, 383.5/ptm_ratio)  ,  new b2Vec2(535/ptm_ratio, 380.5/ptm_ratio)  ,  new b2Vec2(522/ptm_ratio, 363.5/ptm_ratio)  ,  new b2Vec2(518.5/ptm_ratio, 357/ptm_ratio)  ] ,
                                                [   new b2Vec2(351.5/ptm_ratio, 388/ptm_ratio)  ,  new b2Vec2(410/ptm_ratio, 428.5/ptm_ratio)  ,  new b2Vec2(383/ptm_ratio, 427.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(444.5/ptm_ratio, 376/ptm_ratio)  ,  new b2Vec2(467.5/ptm_ratio, 398/ptm_ratio)  ,  new b2Vec2(357.5/ptm_ratio, 388/ptm_ratio)  ,  new b2Vec2(381/ptm_ratio, 367.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(672/ptm_ratio, 246.5/ptm_ratio)  ,  new b2Vec2(704/ptm_ratio, 372.5/ptm_ratio)  ,  new b2Vec2(695.5/ptm_ratio, 387/ptm_ratio)  ,  new b2Vec2(632/ptm_ratio, 292.5/ptm_ratio)  ,  new b2Vec2(631.5/ptm_ratio, 258/ptm_ratio)  ,  new b2Vec2(637.5/ptm_ratio, 246/ptm_ratio)  ,  new b2Vec2(648/ptm_ratio, 239.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(498/ptm_ratio, 194.5/ptm_ratio)  ,  new b2Vec2(507.5/ptm_ratio, 198/ptm_ratio)  ,  new b2Vec2(521/ptm_ratio, 221.5/ptm_ratio)  ,  new b2Vec2(469/ptm_ratio, 272.5/ptm_ratio)  ,  new b2Vec2(457/ptm_ratio, 263.5/ptm_ratio)  ,  new b2Vec2(476.5/ptm_ratio, 196/ptm_ratio)  ] ,
                                                [   new b2Vec2(733/ptm_ratio, 353.5/ptm_ratio)  ,  new b2Vec2(735.5/ptm_ratio, 329/ptm_ratio)  ,  new b2Vec2(737.5/ptm_ratio, 341/ptm_ratio)  ] ,
                                                [   new b2Vec2(576/ptm_ratio, 228.5/ptm_ratio)  ,  new b2Vec2(584.5/ptm_ratio, 233/ptm_ratio)  ,  new b2Vec2(597.5/ptm_ratio, 257/ptm_ratio)  ,  new b2Vec2(549/ptm_ratio, 217.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(624.5/ptm_ratio, 286/ptm_ratio)  ,  new b2Vec2(597.5/ptm_ratio, 257/ptm_ratio)  ,  new b2Vec2(584.5/ptm_ratio, 233/ptm_ratio)  ,  new b2Vec2(608/ptm_ratio, 249.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(631.5/ptm_ratio, 258/ptm_ratio)  ,  new b2Vec2(631.5/ptm_ratio, 277/ptm_ratio)  ,  new b2Vec2(617.5/ptm_ratio, 247/ptm_ratio)  ,  new b2Vec2(620/ptm_ratio, 244.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(475/ptm_ratio, 444.5/ptm_ratio)  ,  new b2Vec2(523.5/ptm_ratio, 419/ptm_ratio)  ,  new b2Vec2(587/ptm_ratio, 394.5/ptm_ratio)  ,  new b2Vec2(584/ptm_ratio, 410.5/ptm_ratio)  ,  new b2Vec2(539/ptm_ratio, 437.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(717.5/ptm_ratio, 268/ptm_ratio)  ,  new b2Vec2(715.5/ptm_ratio, 311/ptm_ratio)  ,  new b2Vec2(704/ptm_ratio, 372.5/ptm_ratio)  ,  new b2Vec2(672/ptm_ratio, 246.5/ptm_ratio)  ,  new b2Vec2(698.5/ptm_ratio, 233/ptm_ratio)  ,  new b2Vec2(712.5/ptm_ratio, 250/ptm_ratio)  ] ,
                                                [   new b2Vec2(569/ptm_ratio, 287.5/ptm_ratio)  ,  new b2Vec2(565/ptm_ratio, 301.5/ptm_ratio)  ,  new b2Vec2(555/ptm_ratio, 277.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(569/ptm_ratio, 287.5/ptm_ratio)  ,  new b2Vec2(608/ptm_ratio, 284.5/ptm_ratio)  ,  new b2Vec2(624.5/ptm_ratio, 286/ptm_ratio)  ,  new b2Vec2(632/ptm_ratio, 292.5/ptm_ratio)  ,  new b2Vec2(601/ptm_ratio, 301.5/ptm_ratio)  ,  new b2Vec2(565/ptm_ratio, 301.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(410/ptm_ratio, 428.5/ptm_ratio)  ,  new b2Vec2(351.5/ptm_ratio, 388/ptm_ratio)  ,  new b2Vec2(357.5/ptm_ratio, 388/ptm_ratio)  ,  new b2Vec2(467.5/ptm_ratio, 398/ptm_ratio)  ,  new b2Vec2(523.5/ptm_ratio, 419/ptm_ratio)  ,  new b2Vec2(475/ptm_ratio, 444.5/ptm_ratio)  ,  new b2Vec2(433/ptm_ratio, 441.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(698.5/ptm_ratio, 233/ptm_ratio)  ,  new b2Vec2(672/ptm_ratio, 246.5/ptm_ratio)  ,  new b2Vec2(699/ptm_ratio, 226.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(474/ptm_ratio, 280.5/ptm_ratio)  ,  new b2Vec2(518.5/ptm_ratio, 271/ptm_ratio)  ,  new b2Vec2(525.5/ptm_ratio, 297/ptm_ratio)  ,  new b2Vec2(526/ptm_ratio, 330/ptm_ratio)  ,  new b2Vec2(506/ptm_ratio, 323/ptm_ratio)  ] ,
                                                [   new b2Vec2(684.5/ptm_ratio, 429/ptm_ratio)  ,  new b2Vec2(632/ptm_ratio, 292.5/ptm_ratio)  ,  new b2Vec2(695.5/ptm_ratio, 387/ptm_ratio)  ] ,
                                                [   new b2Vec2(679.5/ptm_ratio, 504/ptm_ratio)  ,  new b2Vec2(601/ptm_ratio, 301.5/ptm_ratio)  ,  new b2Vec2(632/ptm_ratio, 292.5/ptm_ratio)  ,  new b2Vec2(684.5/ptm_ratio, 429/ptm_ratio)  ,  new b2Vec2(687.5/ptm_ratio, 465/ptm_ratio)  ] ,
                                                [   new b2Vec2(611/ptm_ratio, 501.5/ptm_ratio)  ,  new b2Vec2(679.5/ptm_ratio, 504/ptm_ratio)  ,  new b2Vec2(683/ptm_ratio, 516.5/ptm_ratio)  ,  new b2Vec2(569/ptm_ratio, 531.5/ptm_ratio)  ,  new b2Vec2(587/ptm_ratio, 514.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(521/ptm_ratio, 221.5/ptm_ratio)  ,  new b2Vec2(530/ptm_ratio, 215.5/ptm_ratio)  ,  new b2Vec2(527/ptm_ratio, 234.5/ptm_ratio)  ,  new b2Vec2(518.5/ptm_ratio, 271/ptm_ratio)  ,  new b2Vec2(474/ptm_ratio, 280.5/ptm_ratio)  ,  new b2Vec2(469/ptm_ratio, 272.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(798.5/ptm_ratio, 600/ptm_ratio)  ,  new b2Vec2(485/ptm_ratio, 551.5/ptm_ratio)  ,  new b2Vec2(683/ptm_ratio, 516.5/ptm_ratio)  ,  new b2Vec2(708/ptm_ratio, 516.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(624.5/ptm_ratio, 286/ptm_ratio)  ,  new b2Vec2(608/ptm_ratio, 284.5/ptm_ratio)  ,  new b2Vec2(597.5/ptm_ratio, 257/ptm_ratio)  ] ,
                                                [   new b2Vec2(679.5/ptm_ratio, 504/ptm_ratio)  ,  new b2Vec2(631.5/ptm_ratio, 437/ptm_ratio)  ,  new b2Vec2(565/ptm_ratio, 309.5/ptm_ratio)  ,  new b2Vec2(601/ptm_ratio, 301.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(526/ptm_ratio, 330/ptm_ratio)  ,  new b2Vec2(525.5/ptm_ratio, 297/ptm_ratio)  ,  new b2Vec2(565/ptm_ratio, 309.5/ptm_ratio)  ,  new b2Vec2(587/ptm_ratio, 394.5/ptm_ratio)  ,  new b2Vec2(571/ptm_ratio, 383.5/ptm_ratio)  ,  new b2Vec2(529/ptm_ratio, 342.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(523.5/ptm_ratio, 419/ptm_ratio)  ,  new b2Vec2(467.5/ptm_ratio, 398/ptm_ratio)  ,  new b2Vec2(483/ptm_ratio, 399.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(284/ptm_ratio, 554.5/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 596/ptm_ratio)  ,  new b2Vec2(110/ptm_ratio, 558.5/ptm_ratio)  ,  new b2Vec2(185/ptm_ratio, 548.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(485/ptm_ratio, 551.5/ptm_ratio)  ,  new b2Vec2(362/ptm_ratio, 554.5/ptm_ratio)  ,  new b2Vec2(404/ptm_ratio, 549.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(362/ptm_ratio, 554.5/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 596/ptm_ratio)  ,  new b2Vec2(284/ptm_ratio, 554.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(485/ptm_ratio, 551.5/ptm_ratio)  ,  new b2Vec2(798.5/ptm_ratio, 600/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 596/ptm_ratio)  ,  new b2Vec2(362/ptm_ratio, 554.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(587/ptm_ratio, 394.5/ptm_ratio)  ,  new b2Vec2(608/ptm_ratio, 414.5/ptm_ratio)  ,  new b2Vec2(584/ptm_ratio, 410.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(565/ptm_ratio, 309.5/ptm_ratio)  ,  new b2Vec2(617/ptm_ratio, 417.5/ptm_ratio)  ,  new b2Vec2(608/ptm_ratio, 414.5/ptm_ratio)  ,  new b2Vec2(587/ptm_ratio, 394.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(565/ptm_ratio, 309.5/ptm_ratio)  ,  new b2Vec2(631.5/ptm_ratio, 437/ptm_ratio)  ,  new b2Vec2(617/ptm_ratio, 417.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(679.5/ptm_ratio, 504/ptm_ratio)  ,  new b2Vec2(630.5/ptm_ratio, 476/ptm_ratio)  ,  new b2Vec2(631.5/ptm_ratio, 437/ptm_ratio)  ] ,
                                                [   new b2Vec2(679.5/ptm_ratio, 504/ptm_ratio)  ,  new b2Vec2(611/ptm_ratio, 501.5/ptm_ratio)  ,  new b2Vec2(630.5/ptm_ratio, 476/ptm_ratio)  ] ,
                                                [   new b2Vec2(683/ptm_ratio, 516.5/ptm_ratio)  ,  new b2Vec2(485/ptm_ratio, 551.5/ptm_ratio)  ,  new b2Vec2(569/ptm_ratio, 531.5/ptm_ratio)  ]
											]

										]

									];

			dict["a2"] = [

										[
											// density, friction, restitution
                                            2, 0, 0,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(799.5/ptm_ratio, 274/ptm_ratio)  ,  new b2Vec2(779/ptm_ratio, 286.5/ptm_ratio)  ,  new b2Vec2(782/ptm_ratio, 271.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(75/ptm_ratio, 506.5/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 506/ptm_ratio)  ] ,
                                                [   new b2Vec2(779/ptm_ratio, 286.5/ptm_ratio)  ,  new b2Vec2(769.5/ptm_ratio, 299/ptm_ratio)  ,  new b2Vec2(769.5/ptm_ratio, 287/ptm_ratio)  ] ,
                                                [   new b2Vec2(722/ptm_ratio, 374.5/ptm_ratio)  ,  new b2Vec2(713.5/ptm_ratio, 386/ptm_ratio)  ,  new b2Vec2(713.5/ptm_ratio, 377/ptm_ratio)  ] ,
                                                [   new b2Vec2(649/ptm_ratio, 490.5/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(637/ptm_ratio, 502.5/ptm_ratio)  ,  new b2Vec2(639.5/ptm_ratio, 491/ptm_ratio)  ] ,
                                                [   new b2Vec2(667.5/ptm_ratio, 459/ptm_ratio)  ,  new b2Vec2(658.5/ptm_ratio, 474/ptm_ratio)  ,  new b2Vec2(658.5/ptm_ratio, 462/ptm_ratio)  ] ,
                                                [   new b2Vec2(704.5/ptm_ratio, 401/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(695.5/ptm_ratio, 416/ptm_ratio)  ,  new b2Vec2(695.5/ptm_ratio, 404/ptm_ratio)  ] ,
                                                [   new b2Vec2(713.5/ptm_ratio, 386/ptm_ratio)  ,  new b2Vec2(704.5/ptm_ratio, 401/ptm_ratio)  ,  new b2Vec2(704.5/ptm_ratio, 389/ptm_ratio)  ] ,
                                                [   new b2Vec2(685/ptm_ratio, 432.5/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(676/ptm_ratio, 447.5/ptm_ratio)  ,  new b2Vec2(676.5/ptm_ratio, 435/ptm_ratio)  ] ,
                                                [   new b2Vec2(741/ptm_ratio, 344.5/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(732/ptm_ratio, 359.5/ptm_ratio)  ,  new b2Vec2(732.5/ptm_ratio, 347/ptm_ratio)  ] ,
                                                [   new b2Vec2(750/ptm_ratio, 329.5/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(741/ptm_ratio, 344.5/ptm_ratio)  ,  new b2Vec2(741.5/ptm_ratio, 332/ptm_ratio)  ] ,
                                                [   new b2Vec2(759/ptm_ratio, 314.5/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(750/ptm_ratio, 329.5/ptm_ratio)  ,  new b2Vec2(750.5/ptm_ratio, 317/ptm_ratio)  ] ,
                                                [   new b2Vec2(658.5/ptm_ratio, 474/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(649/ptm_ratio, 490.5/ptm_ratio)  ,  new b2Vec2(649.5/ptm_ratio, 478/ptm_ratio)  ] ,
                                                [   new b2Vec2(769.5/ptm_ratio, 299/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(759/ptm_ratio, 314.5/ptm_ratio)  ,  new b2Vec2(760.5/ptm_ratio, 302/ptm_ratio)  ] ,
                                                [   new b2Vec2(732/ptm_ratio, 359.5/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(722/ptm_ratio, 374.5/ptm_ratio)  ,  new b2Vec2(723.5/ptm_ratio, 362/ptm_ratio)  ] ,
                                                [   new b2Vec2(695.5/ptm_ratio, 416/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(685/ptm_ratio, 432.5/ptm_ratio)  ,  new b2Vec2(686.5/ptm_ratio, 420/ptm_ratio)  ] ,
                                                [   new b2Vec2(676/ptm_ratio, 447.5/ptm_ratio)  ,  new b2Vec2(667.5/ptm_ratio, 459/ptm_ratio)  ,  new b2Vec2(670/ptm_ratio, 447.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(126/ptm_ratio, 498.5/ptm_ratio)  ,  new b2Vec2(796/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(75/ptm_ratio, 506.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(462/ptm_ratio, 421.5/ptm_ratio)  ,  new b2Vec2(526/ptm_ratio, 472.5/ptm_ratio)  ,  new b2Vec2(276/ptm_ratio, 440.5/ptm_ratio)  ,  new b2Vec2(363/ptm_ratio, 395.5/ptm_ratio)  ,  new b2Vec2(402/ptm_ratio, 395.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(799.5/ptm_ratio, 274/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(769.5/ptm_ratio, 299/ptm_ratio)  ,  new b2Vec2(779/ptm_ratio, 286.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(275/ptm_ratio, 440.5/ptm_ratio)  ,  new b2Vec2(276/ptm_ratio, 440.5/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(796/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(126/ptm_ratio, 498.5/ptm_ratio)  ,  new b2Vec2(198/ptm_ratio, 463.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(676/ptm_ratio, 447.5/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(658.5/ptm_ratio, 474/ptm_ratio)  ,  new b2Vec2(667.5/ptm_ratio, 459/ptm_ratio)  ] ,
                                                [   new b2Vec2(722/ptm_ratio, 374.5/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(704.5/ptm_ratio, 401/ptm_ratio)  ,  new b2Vec2(713.5/ptm_ratio, 386/ptm_ratio)  ] ,
                                                [   new b2Vec2(637/ptm_ratio, 502.5/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(276/ptm_ratio, 440.5/ptm_ratio)  ,  new b2Vec2(526/ptm_ratio, 472.5/ptm_ratio)  ]
											]

										]

									];

			dict["a3"] = [

										[
											// density, friction, restitution
                                            2, 0, 0,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(183/ptm_ratio, 284.5/ptm_ratio)  ,  new b2Vec2(312/ptm_ratio, 300.5/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 597/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 597/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 276/ptm_ratio)  ] ,
                                                [   new b2Vec2(799.5/ptm_ratio, 597/ptm_ratio)  ,  new b2Vec2(732/ptm_ratio, 329/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, 326.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(799.5/ptm_ratio, 597/ptm_ratio)  ,  new b2Vec2(651/ptm_ratio, 324.5/ptm_ratio)  ,  new b2Vec2(732/ptm_ratio, 329/ptm_ratio)  ] ,
                                                [   new b2Vec2(799.5/ptm_ratio, 597/ptm_ratio)  ,  new b2Vec2(434/ptm_ratio, 303.5/ptm_ratio)  ,  new b2Vec2(435/ptm_ratio, 303.5/ptm_ratio)  ,  new b2Vec2(651/ptm_ratio, 324.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(375/ptm_ratio, 298.5/ptm_ratio)  ,  new b2Vec2(434/ptm_ratio, 303.5/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 597/ptm_ratio)  ,  new b2Vec2(312/ptm_ratio, 300.5/ptm_ratio)  ]
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

                                                [   new b2Vec2(746/ptm_ratio, 204/ptm_ratio)  ,  new b2Vec2(796/ptm_ratio, 0/ptm_ratio)  ,  new b2Vec2(766/ptm_ratio, 213/ptm_ratio)  ,  new b2Vec2(754/ptm_ratio, 225/ptm_ratio)  ] ,
                                                [   new b2Vec2(406/ptm_ratio, 73/ptm_ratio)  ,  new b2Vec2(438/ptm_ratio, 75/ptm_ratio)  ,  new b2Vec2(405/ptm_ratio, 107/ptm_ratio)  ] ,
                                                [   new b2Vec2(667/ptm_ratio, 173/ptm_ratio)  ,  new b2Vec2(714/ptm_ratio, 195/ptm_ratio)  ,  new b2Vec2(688/ptm_ratio, 217/ptm_ratio)  ] ,
                                                [   new b2Vec2(714/ptm_ratio, 195/ptm_ratio)  ,  new b2Vec2(796/ptm_ratio, 0/ptm_ratio)  ,  new b2Vec2(746/ptm_ratio, 204/ptm_ratio)  ,  new b2Vec2(724/ptm_ratio, 258/ptm_ratio)  ] ,
                                                [   new b2Vec2(348/ptm_ratio, 18/ptm_ratio)  ,  new b2Vec2(379/ptm_ratio, 41/ptm_ratio)  ,  new b2Vec2(360/ptm_ratio, 44/ptm_ratio)  ] ,
                                                [   new b2Vec2(391/ptm_ratio, 47/ptm_ratio)  ,  new b2Vec2(438/ptm_ratio, 75/ptm_ratio)  ,  new b2Vec2(406/ptm_ratio, 73/ptm_ratio)  ] ,
                                                [   new b2Vec2(438/ptm_ratio, 75/ptm_ratio)  ,  new b2Vec2(516/ptm_ratio, 86/ptm_ratio)  ,  new b2Vec2(485/ptm_ratio, 105/ptm_ratio)  ] ,
                                                [   new b2Vec2(309/ptm_ratio, 0/ptm_ratio)  ,  new b2Vec2(310/ptm_ratio, 0/ptm_ratio)  ,  new b2Vec2(348/ptm_ratio, 18/ptm_ratio)  ,  new b2Vec2(324/ptm_ratio, 17/ptm_ratio)  ] ,
                                                [   new b2Vec2(592/ptm_ratio, 105/ptm_ratio)  ,  new b2Vec2(667/ptm_ratio, 173/ptm_ratio)  ,  new b2Vec2(628/ptm_ratio, 174/ptm_ratio)  ] ,
                                                [   new b2Vec2(391/ptm_ratio, 47/ptm_ratio)  ,  new b2Vec2(348/ptm_ratio, 18/ptm_ratio)  ,  new b2Vec2(541/ptm_ratio, 76/ptm_ratio)  ,  new b2Vec2(516/ptm_ratio, 86/ptm_ratio)  ,  new b2Vec2(438/ptm_ratio, 75/ptm_ratio)  ] ,
                                                [   new b2Vec2(766/ptm_ratio, 213/ptm_ratio)  ,  new b2Vec2(796/ptm_ratio, 0/ptm_ratio)  ,  new b2Vec2(799/ptm_ratio, 243/ptm_ratio)  ,  new b2Vec2(778/ptm_ratio, 228/ptm_ratio)  ] ,
                                                [   new b2Vec2(592/ptm_ratio, 105/ptm_ratio)  ,  new b2Vec2(796/ptm_ratio, 0/ptm_ratio)  ,  new b2Vec2(714/ptm_ratio, 195/ptm_ratio)  ,  new b2Vec2(667/ptm_ratio, 173/ptm_ratio)  ] ,
                                                [   new b2Vec2(576/ptm_ratio, 139/ptm_ratio)  ,  new b2Vec2(541/ptm_ratio, 76/ptm_ratio)  ,  new b2Vec2(592/ptm_ratio, 105/ptm_ratio)  ,  new b2Vec2(579/ptm_ratio, 141/ptm_ratio)  ] ,
                                                [   new b2Vec2(541/ptm_ratio, 76/ptm_ratio)  ,  new b2Vec2(796/ptm_ratio, 0/ptm_ratio)  ,  new b2Vec2(592/ptm_ratio, 105/ptm_ratio)  ] ,
                                                [   new b2Vec2(541/ptm_ratio, 76/ptm_ratio)  ,  new b2Vec2(348/ptm_ratio, 18/ptm_ratio)  ,  new b2Vec2(310/ptm_ratio, 0/ptm_ratio)  ,  new b2Vec2(796/ptm_ratio, 0/ptm_ratio)  ] ,
                                                [   new b2Vec2(348/ptm_ratio, 18/ptm_ratio)  ,  new b2Vec2(391/ptm_ratio, 47/ptm_ratio)  ,  new b2Vec2(379/ptm_ratio, 41/ptm_ratio)  ]
											]

										]

									];

			dict["a4"] = [

										[
											// density, friction, restitution
                                            2, 0, 0,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(108.5/ptm_ratio, 95/ptm_ratio)  ,  new b2Vec2(141/ptm_ratio, 114/ptm_ratio)  ,  new b2Vec2(112/ptm_ratio, 149.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(707/ptm_ratio, 301.5/ptm_ratio)  ,  new b2Vec2(800.5/ptm_ratio, 320/ptm_ratio)  ,  new b2Vec2(753/ptm_ratio, 345.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(469/ptm_ratio, 238.5/ptm_ratio)  ,  new b2Vec2(436/ptm_ratio, 228.5/ptm_ratio)  ,  new b2Vec2(407/ptm_ratio, 208.5/ptm_ratio)  ,  new b2Vec2(387.5/ptm_ratio, 179/ptm_ratio)  ,  new b2Vec2(499/ptm_ratio, 216.5/ptm_ratio)  ,  new b2Vec2(490/ptm_ratio, 239.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(800.5/ptm_ratio, 320/ptm_ratio)  ,  new b2Vec2(295.5/ptm_ratio, 126/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, -0.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(108.5/ptm_ratio, 95/ptm_ratio)  ,  new b2Vec2(103.5/ptm_ratio, 83/ptm_ratio)  ,  new b2Vec2(162/ptm_ratio, 105/ptm_ratio)  ,  new b2Vec2(141/ptm_ratio, 114/ptm_ratio)  ] ,
                                                [   new b2Vec2(204.5/ptm_ratio, 106/ptm_ratio)  ,  new b2Vec2(295.5/ptm_ratio, 126/ptm_ratio)  ,  new b2Vec2(235/ptm_ratio, 130.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(295.5/ptm_ratio, 126/ptm_ratio)  ,  new b2Vec2(360/ptm_ratio, 158.5/ptm_ratio)  ,  new b2Vec2(324.5/ptm_ratio, 191/ptm_ratio)  ,  new b2Vec2(306/ptm_ratio, 198.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(32.5/ptm_ratio, 60/ptm_ratio)  ,  new b2Vec2(22.5/ptm_ratio, 90/ptm_ratio)  ,  new b2Vec2(19.5/ptm_ratio, 89/ptm_ratio)  ,  new b2Vec2(0.5/ptm_ratio, 53/ptm_ratio)  ] ,
                                                [   new b2Vec2(499/ptm_ratio, 216.5/ptm_ratio)  ,  new b2Vec2(617/ptm_ratio, 263/ptm_ratio)  ,  new b2Vec2(592/ptm_ratio, 275.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(103.5/ptm_ratio, 83/ptm_ratio)  ,  new b2Vec2(86.5/ptm_ratio, 70/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(186/ptm_ratio, 100/ptm_ratio)  ,  new b2Vec2(162/ptm_ratio, 105/ptm_ratio)  ] ,
                                                [   new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(38/ptm_ratio, 56.5/ptm_ratio)  ,  new b2Vec2(32.5/ptm_ratio, 60/ptm_ratio)  ] ,
                                                [   new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(65/ptm_ratio, 59.5/ptm_ratio)  ,  new b2Vec2(38/ptm_ratio, 56.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(377/ptm_ratio, 165/ptm_ratio)  ,  new b2Vec2(295.5/ptm_ratio, 126/ptm_ratio)  ,  new b2Vec2(643.5/ptm_ratio, 261/ptm_ratio)  ,  new b2Vec2(617/ptm_ratio, 263/ptm_ratio)  ] ,
                                                [   new b2Vec2(377/ptm_ratio, 165/ptm_ratio)  ,  new b2Vec2(499/ptm_ratio, 216.5/ptm_ratio)  ,  new b2Vec2(387.5/ptm_ratio, 179/ptm_ratio)  ] ,
                                                [   new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(86.5/ptm_ratio, 70/ptm_ratio)  ,  new b2Vec2(65/ptm_ratio, 59.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(681.5/ptm_ratio, 345/ptm_ratio)  ,  new b2Vec2(643.5/ptm_ratio, 261/ptm_ratio)  ,  new b2Vec2(707/ptm_ratio, 301.5/ptm_ratio)  ,  new b2Vec2(684.5/ptm_ratio, 346/ptm_ratio)  ] ,
                                                [   new b2Vec2(643.5/ptm_ratio, 261/ptm_ratio)  ,  new b2Vec2(800.5/ptm_ratio, 320/ptm_ratio)  ,  new b2Vec2(707/ptm_ratio, 301.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(295.5/ptm_ratio, 126/ptm_ratio)  ,  new b2Vec2(377/ptm_ratio, 165/ptm_ratio)  ,  new b2Vec2(360/ptm_ratio, 158.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(186/ptm_ratio, 100/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(295.5/ptm_ratio, 126/ptm_ratio)  ,  new b2Vec2(204.5/ptm_ratio, 106/ptm_ratio)  ]
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

                                                [   new b2Vec2(800.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(728/ptm_ratio, 551.5/ptm_ratio)  ,  new b2Vec2(800/ptm_ratio, 549.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(72/ptm_ratio, 479.5/ptm_ratio)  ,  new b2Vec2(125/ptm_ratio, 499/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 597/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 471/ptm_ratio)  ] ,
                                                [   new b2Vec2(800.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(494/ptm_ratio, 527/ptm_ratio)  ,  new b2Vec2(551/ptm_ratio, 515.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(242/ptm_ratio, 501.5/ptm_ratio)  ,  new b2Vec2(180/ptm_ratio, 495/ptm_ratio)  ,  new b2Vec2(185/ptm_ratio, 492.5/ptm_ratio)  ,  new b2Vec2(212/ptm_ratio, 490.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(180/ptm_ratio, 495/ptm_ratio)  ,  new b2Vec2(242/ptm_ratio, 501.5/ptm_ratio)  ,  new b2Vec2(800.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 597/ptm_ratio)  ,  new b2Vec2(125/ptm_ratio, 499/ptm_ratio)  ] ,
                                                [   new b2Vec2(494/ptm_ratio, 527/ptm_ratio)  ,  new b2Vec2(338/ptm_ratio, 506.5/ptm_ratio)  ,  new b2Vec2(428/ptm_ratio, 505/ptm_ratio)  ] ,
                                                [   new b2Vec2(800.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(614/ptm_ratio, 535.5/ptm_ratio)  ,  new b2Vec2(659/ptm_ratio, 532.5/ptm_ratio)  ,  new b2Vec2(728/ptm_ratio, 551.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(800.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(242/ptm_ratio, 501.5/ptm_ratio)  ,  new b2Vec2(287/ptm_ratio, 497.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(800.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(338/ptm_ratio, 506.5/ptm_ratio)  ,  new b2Vec2(494/ptm_ratio, 527/ptm_ratio)  ]
											]

										]

									];

			dict["a5"] = [

										[
											// density, friction, restitution
                                            2, 0, 0,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(379/ptm_ratio, 151.5/ptm_ratio)  ,  new b2Vec2(436/ptm_ratio, 138.5/ptm_ratio)  ,  new b2Vec2(402/ptm_ratio, 189.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(96/ptm_ratio, 110.5/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 135.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(147.5/ptm_ratio, 135/ptm_ratio)  ,  new b2Vec2(232/ptm_ratio, 132.5/ptm_ratio)  ,  new b2Vec2(173/ptm_ratio, 177.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(581/ptm_ratio, 193/ptm_ratio)  ,  new b2Vec2(684/ptm_ratio, 274.5/ptm_ratio)  ,  new b2Vec2(641/ptm_ratio, 311.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(284/ptm_ratio, 141/ptm_ratio)  ,  new b2Vec2(379/ptm_ratio, 151.5/ptm_ratio)  ,  new b2Vec2(334/ptm_ratio, 165.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(684/ptm_ratio, 274.5/ptm_ratio)  ,  new b2Vec2(581/ptm_ratio, 193/ptm_ratio)  ,  new b2Vec2(800/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(731/ptm_ratio, 255/ptm_ratio)  ,  new b2Vec2(705/ptm_ratio, 277.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(731/ptm_ratio, 255/ptm_ratio)  ,  new b2Vec2(800/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(800.5/ptm_ratio, 330/ptm_ratio)  ] ,
                                                [   new b2Vec2(436/ptm_ratio, 138.5/ptm_ratio)  ,  new b2Vec2(547/ptm_ratio, 195.5/ptm_ratio)  ,  new b2Vec2(522/ptm_ratio, 212.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(96/ptm_ratio, 110.5/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(248/ptm_ratio, 127/ptm_ratio)  ,  new b2Vec2(232/ptm_ratio, 132.5/ptm_ratio)  ,  new b2Vec2(147.5/ptm_ratio, 135/ptm_ratio)  ] ,
                                                [   new b2Vec2(284/ptm_ratio, 141/ptm_ratio)  ,  new b2Vec2(248/ptm_ratio, 127/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(800/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(436/ptm_ratio, 138.5/ptm_ratio)  ,  new b2Vec2(379/ptm_ratio, 151.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(436/ptm_ratio, 138.5/ptm_ratio)  ,  new b2Vec2(800/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(581/ptm_ratio, 193/ptm_ratio)  ,  new b2Vec2(547/ptm_ratio, 195.5/ptm_ratio)  ]
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

                                                [   new b2Vec2(799.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(684/ptm_ratio, 534.5/ptm_ratio)  ,  new b2Vec2(750/ptm_ratio, 530.5/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, 540.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(83/ptm_ratio, 441.5/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, 436.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(215/ptm_ratio, 445.5/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(83/ptm_ratio, 441.5/ptm_ratio)  ,  new b2Vec2(149/ptm_ratio, 423.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(453.5/ptm_ratio, 455/ptm_ratio)  ,  new b2Vec2(311/ptm_ratio, 403.5/ptm_ratio)  ,  new b2Vec2(329.5/ptm_ratio, 382/ptm_ratio)  ,  new b2Vec2(414/ptm_ratio, 386/ptm_ratio)  ,  new b2Vec2(435.5/ptm_ratio, 398/ptm_ratio)  ] ,
                                                [   new b2Vec2(396/ptm_ratio, 363.5/ptm_ratio)  ,  new b2Vec2(414/ptm_ratio, 386/ptm_ratio)  ,  new b2Vec2(329.5/ptm_ratio, 382/ptm_ratio)  ,  new b2Vec2(381/ptm_ratio, 356.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(684/ptm_ratio, 534.5/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(549/ptm_ratio, 535.5/ptm_ratio)  ,  new b2Vec2(612/ptm_ratio, 523.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(453.5/ptm_ratio, 455/ptm_ratio)  ,  new b2Vec2(290/ptm_ratio, 420/ptm_ratio)  ,  new b2Vec2(311/ptm_ratio, 403.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(453.5/ptm_ratio, 455/ptm_ratio)  ,  new b2Vec2(465.5/ptm_ratio, 478/ptm_ratio)  ,  new b2Vec2(465.5/ptm_ratio, 479/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(215/ptm_ratio, 445.5/ptm_ratio)  ,  new b2Vec2(290/ptm_ratio, 420/ptm_ratio)  ] ,
                                                [   new b2Vec2(-0.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(549/ptm_ratio, 535.5/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 598/ptm_ratio)  ] ,
                                                [   new b2Vec2(-0.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(477.5/ptm_ratio, 492/ptm_ratio)  ,  new b2Vec2(549/ptm_ratio, 535.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(-0.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(465.5/ptm_ratio, 479/ptm_ratio)  ,  new b2Vec2(477.5/ptm_ratio, 492/ptm_ratio)  ]
											]

										]

									];

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
                                                [   new b2Vec2(234/ptm_ratio, 135/ptm_ratio)  ,  new b2Vec2(294/ptm_ratio, 134.5/ptm_ratio)  ,  new b2Vec2(305.5/ptm_ratio, 162/ptm_ratio)  ,  new b2Vec2(260.5/ptm_ratio, 237/ptm_ratio)  ] ,
                                                [   new b2Vec2(162/ptm_ratio, 77.5/ptm_ratio)  ,  new b2Vec2(202.5/ptm_ratio, 80/ptm_ratio)  ,  new b2Vec2(179.5/ptm_ratio, 100/ptm_ratio)  ] ,
                                                [   new b2Vec2(623.5/ptm_ratio, 294/ptm_ratio)  ,  new b2Vec2(697.5/ptm_ratio, 336/ptm_ratio)  ,  new b2Vec2(661.5/ptm_ratio, 393/ptm_ratio)  ] ,
                                                [   new b2Vec2(582.5/ptm_ratio, 293/ptm_ratio)  ,  new b2Vec2(623.5/ptm_ratio, 294/ptm_ratio)  ,  new b2Vec2(590/ptm_ratio, 313.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(505.5/ptm_ratio, 246/ptm_ratio)  ,  new b2Vec2(582.5/ptm_ratio, 293/ptm_ratio)  ,  new b2Vec2(534/ptm_ratio, 293.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(54/ptm_ratio, 117.5/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 143.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(363.5/ptm_ratio, 214/ptm_ratio)  ,  new b2Vec2(339.5/ptm_ratio, 157/ptm_ratio)  ,  new b2Vec2(797/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(505.5/ptm_ratio, 246/ptm_ratio)  ,  new b2Vec2(466.5/ptm_ratio, 271/ptm_ratio)  ,  new b2Vec2(396.5/ptm_ratio, 261/ptm_ratio)  ] ,
                                                [   new b2Vec2(720/ptm_ratio, 352.5/ptm_ratio)  ,  new b2Vec2(697.5/ptm_ratio, 336/ptm_ratio)  ,  new b2Vec2(784/ptm_ratio, 355.5/ptm_ratio)  ,  new b2Vec2(765/ptm_ratio, 370.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(202.5/ptm_ratio, 80/ptm_ratio)  ,  new b2Vec2(234/ptm_ratio, 135/ptm_ratio)  ,  new b2Vec2(225.5/ptm_ratio, 165/ptm_ratio)  ] ,
                                                [   new b2Vec2(202.5/ptm_ratio, 80/ptm_ratio)  ,  new b2Vec2(797/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(294/ptm_ratio, 134.5/ptm_ratio)  ,  new b2Vec2(234/ptm_ratio, 135/ptm_ratio)  ] ,
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

                                                [   new b2Vec2(113/ptm_ratio, 251.5/ptm_ratio)  ,  new b2Vec2(158.5/ptm_ratio, 330/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(1.5/ptm_ratio, 269/ptm_ratio)  ,  new b2Vec2(65/ptm_ratio, 233.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(221.5/ptm_ratio, 387/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(158.5/ptm_ratio, 330/ptm_ratio)  ] ,
                                                [   new b2Vec2(485/ptm_ratio, 386.5/ptm_ratio)  ,  new b2Vec2(512/ptm_ratio, 391.5/ptm_ratio)  ,  new b2Vec2(526/ptm_ratio, 401.5/ptm_ratio)  ,  new b2Vec2(534.5/ptm_ratio, 420/ptm_ratio)  ,  new b2Vec2(445/ptm_ratio, 409.5/ptm_ratio)  ,  new b2Vec2(458/ptm_ratio, 393.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(799.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(729/ptm_ratio, 517.5/ptm_ratio)  ,  new b2Vec2(777/ptm_ratio, 512.5/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, 519.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(568.5/ptm_ratio, 456/ptm_ratio)  ,  new b2Vec2(417/ptm_ratio, 430/ptm_ratio)  ,  new b2Vec2(445/ptm_ratio, 409.5/ptm_ratio)  ,  new b2Vec2(534.5/ptm_ratio, 420/ptm_ratio)  ] ,
                                                [   new b2Vec2(729/ptm_ratio, 517.5/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(620.5/ptm_ratio, 499/ptm_ratio)  ,  new b2Vec2(675/ptm_ratio, 495.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(620.5/ptm_ratio, 499/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(417/ptm_ratio, 430/ptm_ratio)  ,  new b2Vec2(568.5/ptm_ratio, 456/ptm_ratio)  ] ,
                                                [   new b2Vec2(264/ptm_ratio, 410.5/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(221.5/ptm_ratio, 387/ptm_ratio)  ] ,
                                                [   new b2Vec2(307/ptm_ratio, 433.5/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(264/ptm_ratio, 410.5/ptm_ratio)  ,  new b2Vec2(265/ptm_ratio, 410.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(361/ptm_ratio, 452.5/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(307/ptm_ratio, 433.5/ptm_ratio)  ]
											]

										]

									];

			dict["a7"] = [

										[
											// density, friction, restitution
                                            2, 0, 0,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(510.5/ptm_ratio, 354/ptm_ratio)  ,  new b2Vec2(570/ptm_ratio, 385.5/ptm_ratio)  ,  new b2Vec2(541/ptm_ratio, 426.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(293/ptm_ratio, 116/ptm_ratio)  ,  new b2Vec2(322.5/ptm_ratio, 138/ptm_ratio)  ,  new b2Vec2(303.5/ptm_ratio, 158/ptm_ratio)  ] ,
                                                [   new b2Vec2(570/ptm_ratio, 385.5/ptm_ratio)  ,  new b2Vec2(629/ptm_ratio, 391.5/ptm_ratio)  ,  new b2Vec2(593/ptm_ratio, 407.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(629/ptm_ratio, 391.5/ptm_ratio)  ,  new b2Vec2(770/ptm_ratio, 391/ptm_ratio)  ,  new b2Vec2(687/ptm_ratio, 438.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(344.5/ptm_ratio, 160/ptm_ratio)  ,  new b2Vec2(527/ptm_ratio, 158.5/ptm_ratio)  ,  new b2Vec2(519.5/ptm_ratio, 180/ptm_ratio)  ,  new b2Vec2(480/ptm_ratio, 213.5/ptm_ratio)  ,  new b2Vec2(447/ptm_ratio, 222.5/ptm_ratio)  ,  new b2Vec2(408/ptm_ratio, 221.5/ptm_ratio)  ,  new b2Vec2(366/ptm_ratio, 210.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(701/ptm_ratio, 122.5/ptm_ratio)  ,  new b2Vec2(800/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(772.5/ptm_ratio, 164/ptm_ratio)  ,  new b2Vec2(745/ptm_ratio, 173.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(760.5/ptm_ratio, 236/ptm_ratio)  ,  new b2Vec2(800.5/ptm_ratio, 411/ptm_ratio)  ,  new b2Vec2(770/ptm_ratio, 391/ptm_ratio)  ,  new b2Vec2(739/ptm_ratio, 323.5/ptm_ratio)  ,  new b2Vec2(732.5/ptm_ratio, 284/ptm_ratio)  ] ,
                                                [   new b2Vec2(60/ptm_ratio, 336.5/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(293/ptm_ratio, 116/ptm_ratio)  ,  new b2Vec2(245.5/ptm_ratio, 225/ptm_ratio)  ,  new b2Vec2(204/ptm_ratio, 287.5/ptm_ratio)  ,  new b2Vec2(114/ptm_ratio, 345.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(739/ptm_ratio, 323.5/ptm_ratio)  ,  new b2Vec2(770/ptm_ratio, 391/ptm_ratio)  ,  new b2Vec2(610/ptm_ratio, 330.5/ptm_ratio)  ,  new b2Vec2(658/ptm_ratio, 309.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(610/ptm_ratio, 330.5/ptm_ratio)  ,  new b2Vec2(770/ptm_ratio, 391/ptm_ratio)  ,  new b2Vec2(629/ptm_ratio, 391.5/ptm_ratio)  ,  new b2Vec2(510.5/ptm_ratio, 354/ptm_ratio)  ,  new b2Vec2(507.5/ptm_ratio, 345/ptm_ratio)  ,  new b2Vec2(553/ptm_ratio, 326.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(510.5/ptm_ratio, 354/ptm_ratio)  ,  new b2Vec2(629/ptm_ratio, 391.5/ptm_ratio)  ,  new b2Vec2(570/ptm_ratio, 385.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(60/ptm_ratio, 336.5/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 362.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(480/ptm_ratio, 213.5/ptm_ratio)  ,  new b2Vec2(519.5/ptm_ratio, 180/ptm_ratio)  ,  new b2Vec2(504/ptm_ratio, 199.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(584/ptm_ratio, 129.5/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(800/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(701/ptm_ratio, 122.5/ptm_ratio)  ,  new b2Vec2(650/ptm_ratio, 135.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(344.5/ptm_ratio, 160/ptm_ratio)  ,  new b2Vec2(322.5/ptm_ratio, 138/ptm_ratio)  ,  new b2Vec2(584/ptm_ratio, 129.5/ptm_ratio)  ,  new b2Vec2(527/ptm_ratio, 158.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(760.5/ptm_ratio, 236/ptm_ratio)  ,  new b2Vec2(800/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(800.5/ptm_ratio, 411/ptm_ratio)  ] ,
                                                [   new b2Vec2(293/ptm_ratio, 116/ptm_ratio)  ,  new b2Vec2(584/ptm_ratio, 129.5/ptm_ratio)  ,  new b2Vec2(322.5/ptm_ratio, 138/ptm_ratio)  ] ,
                                                [   new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(584/ptm_ratio, 129.5/ptm_ratio)  ,  new b2Vec2(293/ptm_ratio, 116/ptm_ratio)  ]
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

                                                [   new b2Vec2(289/ptm_ratio, 397/ptm_ratio)  ,  new b2Vec2(369/ptm_ratio, 334/ptm_ratio)  ,  new b2Vec2(374/ptm_ratio, 339/ptm_ratio)  ,  new b2Vec2(378/ptm_ratio, 372/ptm_ratio)  ,  new b2Vec2(352/ptm_ratio, 396/ptm_ratio)  ,  new b2Vec2(322/ptm_ratio, 416/ptm_ratio)  ] ,
                                                [   new b2Vec2(65/ptm_ratio, 485/ptm_ratio)  ,  new b2Vec2(66/ptm_ratio, 485/ptm_ratio)  ,  new b2Vec2(316/ptm_ratio, 557/ptm_ratio)  ,  new b2Vec2(337/ptm_ratio, 564/ptm_ratio)  ,  new b2Vec2(-1/ptm_ratio, 599/ptm_ratio)  ,  new b2Vec2(-1/ptm_ratio, 521/ptm_ratio)  ] ,
                                                [   new b2Vec2(800/ptm_ratio, 597/ptm_ratio)  ,  new b2Vec2(733/ptm_ratio, 569/ptm_ratio)  ,  new b2Vec2(799/ptm_ratio, 563/ptm_ratio)  ] ,
                                                [   new b2Vec2(315/ptm_ratio, 511/ptm_ratio)  ,  new b2Vec2(307/ptm_ratio, 547/ptm_ratio)  ,  new b2Vec2(66/ptm_ratio, 485/ptm_ratio)  ,  new b2Vec2(87/ptm_ratio, 474/ptm_ratio)  ,  new b2Vec2(227/ptm_ratio, 474/ptm_ratio)  ,  new b2Vec2(296/ptm_ratio, 477/ptm_ratio)  ] ,
                                                [   new b2Vec2(309/ptm_ratio, 338/ptm_ratio)  ,  new b2Vec2(237/ptm_ratio, 360/ptm_ratio)  ,  new b2Vec2(264/ptm_ratio, 339/ptm_ratio)  ] ,
                                                [   new b2Vec2(369/ptm_ratio, 334/ptm_ratio)  ,  new b2Vec2(309/ptm_ratio, 338/ptm_ratio)  ,  new b2Vec2(333/ptm_ratio, 329/ptm_ratio)  ] ,
                                                [   new b2Vec2(237/ptm_ratio, 360/ptm_ratio)  ,  new b2Vec2(309/ptm_ratio, 338/ptm_ratio)  ,  new b2Vec2(369/ptm_ratio, 334/ptm_ratio)  ,  new b2Vec2(289/ptm_ratio, 397/ptm_ratio)  ,  new b2Vec2(253/ptm_ratio, 415/ptm_ratio)  ,  new b2Vec2(87/ptm_ratio, 474/ptm_ratio)  ,  new b2Vec2(150/ptm_ratio, 402/ptm_ratio)  ] ,
                                                [   new b2Vec2(733/ptm_ratio, 569/ptm_ratio)  ,  new b2Vec2(800/ptm_ratio, 597/ptm_ratio)  ,  new b2Vec2(595/ptm_ratio, 567/ptm_ratio)  ,  new b2Vec2(628/ptm_ratio, 553/ptm_ratio)  ,  new b2Vec2(685/ptm_ratio, 552/ptm_ratio)  ] ,
                                                [   new b2Vec2(595/ptm_ratio, 567/ptm_ratio)  ,  new b2Vec2(421/ptm_ratio, 564/ptm_ratio)  ,  new b2Vec2(469/ptm_ratio, 547/ptm_ratio)  ] ,
                                                [   new b2Vec2(421/ptm_ratio, 564/ptm_ratio)  ,  new b2Vec2(337/ptm_ratio, 564/ptm_ratio)  ,  new b2Vec2(373/ptm_ratio, 560/ptm_ratio)  ] ,
                                                [   new b2Vec2(800/ptm_ratio, 597/ptm_ratio)  ,  new b2Vec2(-1/ptm_ratio, 599/ptm_ratio)  ,  new b2Vec2(337/ptm_ratio, 564/ptm_ratio)  ,  new b2Vec2(595/ptm_ratio, 567/ptm_ratio)  ] ,
                                                [   new b2Vec2(216/ptm_ratio, 445/ptm_ratio)  ,  new b2Vec2(87/ptm_ratio, 474/ptm_ratio)  ,  new b2Vec2(253/ptm_ratio, 415/ptm_ratio)  ] ,
                                                [   new b2Vec2(227/ptm_ratio, 474/ptm_ratio)  ,  new b2Vec2(87/ptm_ratio, 474/ptm_ratio)  ,  new b2Vec2(216/ptm_ratio, 445/ptm_ratio)  ] ,
                                                [   new b2Vec2(316/ptm_ratio, 557/ptm_ratio)  ,  new b2Vec2(66/ptm_ratio, 485/ptm_ratio)  ,  new b2Vec2(307/ptm_ratio, 547/ptm_ratio)  ]
											]

										]

									];

			dict["a8"] = [

										[
											// density, friction, restitution
                                            2, 0, 0,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(548.5/ptm_ratio, 486/ptm_ratio)  ,  new b2Vec2(592/ptm_ratio, 504.5/ptm_ratio)  ,  new b2Vec2(559.5/ptm_ratio, 552/ptm_ratio)  ] ,
                                                [   new b2Vec2(798.5/ptm_ratio, 599/ptm_ratio)  ,  new b2Vec2(618.5/ptm_ratio, 522/ptm_ratio)  ,  new b2Vec2(592/ptm_ratio, 504.5/ptm_ratio)  ,  new b2Vec2(3/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, -0.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(174.5/ptm_ratio, 453/ptm_ratio)  ,  new b2Vec2(260/ptm_ratio, 478.5/ptm_ratio)  ,  new b2Vec2(161/ptm_ratio, 492.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(637.5/ptm_ratio, 564/ptm_ratio)  ,  new b2Vec2(798.5/ptm_ratio, 599/ptm_ratio)  ,  new b2Vec2(633/ptm_ratio, 599.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(3/ptm_ratio, 416.5/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(122/ptm_ratio, 449/ptm_ratio)  ,  new b2Vec2(75/ptm_ratio, 452.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(618.5/ptm_ratio, 522/ptm_ratio)  ,  new b2Vec2(798.5/ptm_ratio, 599/ptm_ratio)  ,  new b2Vec2(637.5/ptm_ratio, 564/ptm_ratio)  ] ,
                                                [   new b2Vec2(311/ptm_ratio, 497.5/ptm_ratio)  ,  new b2Vec2(260/ptm_ratio, 478.5/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(482/ptm_ratio, 484.5/ptm_ratio)  ,  new b2Vec2(386/ptm_ratio, 506.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(174.5/ptm_ratio, 453/ptm_ratio)  ,  new b2Vec2(122/ptm_ratio, 449/ptm_ratio)  ] ,
                                                [   new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(260/ptm_ratio, 478.5/ptm_ratio)  ,  new b2Vec2(174.5/ptm_ratio, 453/ptm_ratio)  ] ,
                                                [   new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(3/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(545/ptm_ratio, 484.5/ptm_ratio)  ,  new b2Vec2(482/ptm_ratio, 484.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(545/ptm_ratio, 484.5/ptm_ratio)  ,  new b2Vec2(3/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(592/ptm_ratio, 504.5/ptm_ratio)  ]
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

                                                [   new b2Vec2(48/ptm_ratio, 555.5/ptm_ratio)  ,  new b2Vec2(143/ptm_ratio, 556/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 597/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 563/ptm_ratio)  ] ,
                                                [   new b2Vec2(143/ptm_ratio, 556/ptm_ratio)  ,  new b2Vec2(48/ptm_ratio, 555.5/ptm_ratio)  ,  new b2Vec2(96/ptm_ratio, 538.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(475/ptm_ratio, 574.5/ptm_ratio)  ,  new b2Vec2(495.5/ptm_ratio, 599/ptm_ratio)  ,  new b2Vec2(370/ptm_ratio, 549.5/ptm_ratio)  ,  new b2Vec2(421/ptm_ratio, 545.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(495.5/ptm_ratio, 599/ptm_ratio)  ,  new b2Vec2(256/ptm_ratio, 550.5/ptm_ratio)  ,  new b2Vec2(325/ptm_ratio, 532.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(0/ptm_ratio, 597/ptm_ratio)  ,  new b2Vec2(143/ptm_ratio, 556/ptm_ratio)  ,  new b2Vec2(221/ptm_ratio, 546/ptm_ratio)  ,  new b2Vec2(256/ptm_ratio, 550.5/ptm_ratio)  ,  new b2Vec2(495.5/ptm_ratio, 599/ptm_ratio)  ]
											]

										]

									];

			dict["b1"] = [

										[
											// density, friction, restitution
                                            2, 0, 0,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(334/ptm_ratio, 599/ptm_ratio)  ,  new b2Vec2(333/ptm_ratio, 497/ptm_ratio)  ,  new b2Vec2(337/ptm_ratio, 491/ptm_ratio)  ,  new b2Vec2(797/ptm_ratio, -1/ptm_ratio)  ,  new b2Vec2(800/ptm_ratio, 599/ptm_ratio)  ] ,
                                                [   new b2Vec2(797/ptm_ratio, -1/ptm_ratio)  ,  new b2Vec2(334/ptm_ratio, 176/ptm_ratio)  ,  new b2Vec2(333/ptm_ratio, -1/ptm_ratio)  ] ,
                                                [   new b2Vec2(797/ptm_ratio, -1/ptm_ratio)  ,  new b2Vec2(335/ptm_ratio, 269/ptm_ratio)  ,  new b2Vec2(329/ptm_ratio, 254/ptm_ratio)  ,  new b2Vec2(334/ptm_ratio, 176/ptm_ratio)  ] ,
                                                [   new b2Vec2(336/ptm_ratio, 317/ptm_ratio)  ,  new b2Vec2(797/ptm_ratio, -1/ptm_ratio)  ,  new b2Vec2(337/ptm_ratio, 491/ptm_ratio)  ,  new b2Vec2(332/ptm_ratio, 365/ptm_ratio)  ] ,
                                                [   new b2Vec2(797/ptm_ratio, -1/ptm_ratio)  ,  new b2Vec2(336/ptm_ratio, 317/ptm_ratio)  ,  new b2Vec2(335/ptm_ratio, 269/ptm_ratio)  ]
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

                                                [   new b2Vec2(2/ptm_ratio, 600.5/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 1/ptm_ratio)  ,  new b2Vec2(280/ptm_ratio, 0/ptm_ratio)  ,  new b2Vec2(281.5/ptm_ratio, 35/ptm_ratio)  ,  new b2Vec2(281.5/ptm_ratio, 599/ptm_ratio)  ]
											]

										]

									];

			dict["b5"] = [

										[
											// density, friction, restitution
                                            2, 0, 0,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(273/ptm_ratio, 354.5/ptm_ratio)  ,  new b2Vec2(346.5/ptm_ratio, 252/ptm_ratio)  ,  new b2Vec2(350.5/ptm_ratio, 330/ptm_ratio)  ,  new b2Vec2(312/ptm_ratio, 375.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(765/ptm_ratio, 78.5/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(800.5/ptm_ratio, 80/ptm_ratio)  ] ,
                                                [   new b2Vec2(346.5/ptm_ratio, 252/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 1/ptm_ratio)  ,  new b2Vec2(365/ptm_ratio, 220/ptm_ratio)  ,  new b2Vec2(363.5/ptm_ratio, 239/ptm_ratio)  ] ,
                                                [   new b2Vec2(158/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(192/ptm_ratio, 531/ptm_ratio)  ,  new b2Vec2(222/ptm_ratio, 540/ptm_ratio)  ] ,
                                                [   new b2Vec2(158/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, 600.5/ptm_ratio)  ,  new b2Vec2(158.5/ptm_ratio, 515/ptm_ratio)  ,  new b2Vec2(192/ptm_ratio, 531/ptm_ratio)  ] ,
                                                [   new b2Vec2(687/ptm_ratio, 116.5/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 1/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(765/ptm_ratio, 78.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(-0.5/ptm_ratio, 1/ptm_ratio)  ,  new b2Vec2(183/ptm_ratio, 406.5/ptm_ratio)  ,  new b2Vec2(191.5/ptm_ratio, 449/ptm_ratio)  ,  new b2Vec2(158.5/ptm_ratio, 515/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, 600.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(477/ptm_ratio, 128.5/ptm_ratio)  ,  new b2Vec2(654/ptm_ratio, 111.5/ptm_ratio)  ,  new b2Vec2(528/ptm_ratio, 157.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(365/ptm_ratio, 220/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 1/ptm_ratio)  ,  new b2Vec2(477/ptm_ratio, 128.5/ptm_ratio)  ,  new b2Vec2(422.5/ptm_ratio, 194/ptm_ratio)  ] ,
                                                [   new b2Vec2(183/ptm_ratio, 406.5/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 1/ptm_ratio)  ,  new b2Vec2(346.5/ptm_ratio, 252/ptm_ratio)  ,  new b2Vec2(273/ptm_ratio, 354.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(-0.5/ptm_ratio, 1/ptm_ratio)  ,  new b2Vec2(654/ptm_ratio, 111.5/ptm_ratio)  ,  new b2Vec2(477/ptm_ratio, 128.5/ptm_ratio)  ]
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

                                                [   new b2Vec2(527/ptm_ratio, 236.5/ptm_ratio)  ,  new b2Vec2(509/ptm_ratio, 236.5/ptm_ratio)  ,  new b2Vec2(509/ptm_ratio, 216/ptm_ratio)  ,  new b2Vec2(527/ptm_ratio, 216/ptm_ratio)  ]
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

                                                [   new b2Vec2(427/ptm_ratio, 273/ptm_ratio)  ,  new b2Vec2(426/ptm_ratio, 293/ptm_ratio)  ,  new b2Vec2(409/ptm_ratio, 293.5/ptm_ratio)  ,  new b2Vec2(406/ptm_ratio, 273/ptm_ratio)  ]
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

                                                [   new b2Vec2(329.5/ptm_ratio, 474/ptm_ratio)  ,  new b2Vec2(309/ptm_ratio, 474.5/ptm_ratio)  ,  new b2Vec2(308.5/ptm_ratio, 454/ptm_ratio)  ,  new b2Vec2(329/ptm_ratio, 453.5/ptm_ratio)  ]
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

                                                [   new b2Vec2(424/ptm_ratio, 397.5/ptm_ratio)  ,  new b2Vec2(408/ptm_ratio, 397.5/ptm_ratio)  ,  new b2Vec2(407/ptm_ratio, 378/ptm_ratio)  ,  new b2Vec2(425/ptm_ratio, 377/ptm_ratio)  ]
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

                                                [   new b2Vec2(581/ptm_ratio, 318.5/ptm_ratio)  ,  new b2Vec2(581/ptm_ratio, 297/ptm_ratio)  ,  new b2Vec2(601/ptm_ratio, 297.5/ptm_ratio)  ,  new b2Vec2(601.5/ptm_ratio, 318/ptm_ratio)  ]
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

                                                [   new b2Vec2(652/ptm_ratio, 176/ptm_ratio)  ,  new b2Vec2(672/ptm_ratio, 176/ptm_ratio)  ,  new b2Vec2(672.5/ptm_ratio, 196/ptm_ratio)  ,  new b2Vec2(652/ptm_ratio, 197.5/ptm_ratio)  ]
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

                                                [   new b2Vec2(800.5/ptm_ratio, 146/ptm_ratio)  ,  new b2Vec2(780/ptm_ratio, 147.5/ptm_ratio)  ,  new b2Vec2(780/ptm_ratio, 128/ptm_ratio)  ,  new b2Vec2(800/ptm_ratio, 125/ptm_ratio)  ]
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

                                                [   new b2Vec2(800/ptm_ratio, 600/ptm_ratio)  ,  new b2Vec2(647/ptm_ratio, 562/ptm_ratio)  ,  new b2Vec2(721/ptm_ratio, 542/ptm_ratio)  ,  new b2Vec2(800/ptm_ratio, 533/ptm_ratio)  ] ,
                                                [   new b2Vec2(647/ptm_ratio, 562/ptm_ratio)  ,  new b2Vec2(800/ptm_ratio, 600/ptm_ratio)  ,  new b2Vec2(399/ptm_ratio, 601/ptm_ratio)  ,  new b2Vec2(411/ptm_ratio, 589/ptm_ratio)  ] ,
                                                [   new b2Vec2(647/ptm_ratio, 562/ptm_ratio)  ,  new b2Vec2(443/ptm_ratio, 585/ptm_ratio)  ,  new b2Vec2(473/ptm_ratio, 567/ptm_ratio)  ]
											]

										]

									];

			dict["b6"] = [

										[
											// density, friction, restitution
                                            2, 0, 0,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(325/ptm_ratio, 50.5/ptm_ratio)  ,  new b2Vec2(357.5/ptm_ratio, 49/ptm_ratio)  ,  new b2Vec2(341.5/ptm_ratio, 81/ptm_ratio)  ] ,
                                                [   new b2Vec2(414/ptm_ratio, 39/ptm_ratio)  ,  new b2Vec2(467/ptm_ratio, 49/ptm_ratio)  ,  new b2Vec2(436/ptm_ratio, 77.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(467/ptm_ratio, 49/ptm_ratio)  ,  new b2Vec2(495.5/ptm_ratio, 56/ptm_ratio)  ,  new b2Vec2(484.5/ptm_ratio, 91/ptm_ratio)  ] ,
                                                [   new b2Vec2(232.5/ptm_ratio, 70/ptm_ratio)  ,  new b2Vec2(282.5/ptm_ratio, 104/ptm_ratio)  ,  new b2Vec2(266/ptm_ratio, 139/ptm_ratio)  ] ,
                                                [   new b2Vec2(232.5/ptm_ratio, 70/ptm_ratio)  ,  new b2Vec2(213/ptm_ratio, 50/ptm_ratio)  ,  new b2Vec2(325/ptm_ratio, 50.5/ptm_ratio)  ,  new b2Vec2(282.5/ptm_ratio, 104/ptm_ratio)  ] ,
                                                [   new b2Vec2(495.5/ptm_ratio, 56/ptm_ratio)  ,  new b2Vec2(522/ptm_ratio, 77/ptm_ratio)  ,  new b2Vec2(518.5/ptm_ratio, 119/ptm_ratio)  ] ,
                                                [   new b2Vec2(136/ptm_ratio, 121/ptm_ratio)  ,  new b2Vec2(165.5/ptm_ratio, 97/ptm_ratio)  ,  new b2Vec2(150.5/ptm_ratio, 185/ptm_ratio)  ] ,
                                                [   new b2Vec2(109.5/ptm_ratio, 50/ptm_ratio)  ,  new b2Vec2(177/ptm_ratio, 72.5/ptm_ratio)  ,  new b2Vec2(165.5/ptm_ratio, 97/ptm_ratio)  ,  new b2Vec2(136/ptm_ratio, 121/ptm_ratio)  ] ,
                                                [   new b2Vec2(522/ptm_ratio, 77/ptm_ratio)  ,  new b2Vec2(495.5/ptm_ratio, 56/ptm_ratio)  ,  new b2Vec2(548.5/ptm_ratio, 43/ptm_ratio)  ,  new b2Vec2(540/ptm_ratio, 70.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(109.5/ptm_ratio, 50/ptm_ratio)  ,  new b2Vec2(213/ptm_ratio, 50/ptm_ratio)  ,  new b2Vec2(177/ptm_ratio, 72.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(325/ptm_ratio, 50.5/ptm_ratio)  ,  new b2Vec2(213/ptm_ratio, 50/ptm_ratio)  ,  new b2Vec2(384/ptm_ratio, 29/ptm_ratio)  ,  new b2Vec2(357.5/ptm_ratio, 49/ptm_ratio)  ] ,
                                                [   new b2Vec2(766/ptm_ratio, 183.5/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 212/ptm_ratio)  ,  new b2Vec2(729/ptm_ratio, 208.5/ptm_ratio)  ,  new b2Vec2(701/ptm_ratio, 201.5/ptm_ratio)  ,  new b2Vec2(670/ptm_ratio, 184.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(782/ptm_ratio, 173/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 212/ptm_ratio)  ,  new b2Vec2(766/ptm_ratio, 183.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(495.5/ptm_ratio, 56/ptm_ratio)  ,  new b2Vec2(467/ptm_ratio, 49/ptm_ratio)  ,  new b2Vec2(566/ptm_ratio, 19/ptm_ratio)  ,  new b2Vec2(548.5/ptm_ratio, 43/ptm_ratio)  ] ,
                                                [   new b2Vec2(616.5/ptm_ratio, 74/ptm_ratio)  ,  new b2Vec2(674/ptm_ratio, 38.5/ptm_ratio)  ,  new b2Vec2(620.5/ptm_ratio, 93/ptm_ratio)  ] ,
                                                [   new b2Vec2(595.5/ptm_ratio, 41/ptm_ratio)  ,  new b2Vec2(674/ptm_ratio, 38.5/ptm_ratio)  ,  new b2Vec2(616.5/ptm_ratio, 74/ptm_ratio)  ] ,
                                                [   new b2Vec2(52.5/ptm_ratio, 357/ptm_ratio)  ,  new b2Vec2(78/ptm_ratio, 372/ptm_ratio)  ,  new b2Vec2(90/ptm_ratio, 380.5/ptm_ratio)  ,  new b2Vec2(107/ptm_ratio, 426.5/ptm_ratio)  ,  new b2Vec2(70.5/ptm_ratio, 397/ptm_ratio)  ] ,
                                                [   new b2Vec2(150/ptm_ratio, 416.5/ptm_ratio)  ,  new b2Vec2(90/ptm_ratio, 380.5/ptm_ratio)  ,  new b2Vec2(218/ptm_ratio, 394.5/ptm_ratio)  ,  new b2Vec2(194/ptm_ratio, 412.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(107/ptm_ratio, 426.5/ptm_ratio)  ,  new b2Vec2(90/ptm_ratio, 380.5/ptm_ratio)  ,  new b2Vec2(150/ptm_ratio, 416.5/ptm_ratio)  ,  new b2Vec2(123/ptm_ratio, 429.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(566/ptm_ratio, 19/ptm_ratio)  ,  new b2Vec2(710/ptm_ratio, 24.5/ptm_ratio)  ,  new b2Vec2(674/ptm_ratio, 38.5/ptm_ratio)  ,  new b2Vec2(595.5/ptm_ratio, 41/ptm_ratio)  ] ,
                                                [   new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(17.5/ptm_ratio, 101/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 78/ptm_ratio)  ] ,
                                                [   new b2Vec2(779.5/ptm_ratio, 133/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 212/ptm_ratio)  ,  new b2Vec2(782/ptm_ratio, 173/ptm_ratio)  ] ,
                                                [   new b2Vec2(414/ptm_ratio, 39/ptm_ratio)  ,  new b2Vec2(384/ptm_ratio, 29/ptm_ratio)  ,  new b2Vec2(566/ptm_ratio, 19/ptm_ratio)  ,  new b2Vec2(467/ptm_ratio, 49/ptm_ratio)  ] ,
                                                [   new b2Vec2(758.5/ptm_ratio, 65/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(779.5/ptm_ratio, 133/ptm_ratio)  ] ,
                                                [   new b2Vec2(737.5/ptm_ratio, 38/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(758.5/ptm_ratio, 65/ptm_ratio)  ] ,
                                                [   new b2Vec2(710/ptm_ratio, 24.5/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(737.5/ptm_ratio, 38/ptm_ratio)  ] ,
                                                [   new b2Vec2(218/ptm_ratio, 394.5/ptm_ratio)  ,  new b2Vec2(90/ptm_ratio, 380.5/ptm_ratio)  ,  new b2Vec2(262/ptm_ratio, 377.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(566/ptm_ratio, 19/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(710/ptm_ratio, 24.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(109.5/ptm_ratio, 50/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(384/ptm_ratio, 29/ptm_ratio)  ,  new b2Vec2(213/ptm_ratio, 50/ptm_ratio)  ] ,
                                                [   new b2Vec2(384/ptm_ratio, 29/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, -0.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(72.5/ptm_ratio, 121/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(109.5/ptm_ratio, 50/ptm_ratio)  ] ,
                                                [   new b2Vec2(63.5/ptm_ratio, 257/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(72.5/ptm_ratio, 121/ptm_ratio)  ] ,
                                                [   new b2Vec2(66/ptm_ratio, 322/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(63.5/ptm_ratio, 257/ptm_ratio)  ] ,
                                                [   new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(27.5/ptm_ratio, 137/ptm_ratio)  ,  new b2Vec2(17.5/ptm_ratio, 101/ptm_ratio)  ] ,
                                                [   new b2Vec2(52.5/ptm_ratio, 357/ptm_ratio)  ,  new b2Vec2(44.5/ptm_ratio, 237/ptm_ratio)  ,  new b2Vec2(78/ptm_ratio, 372/ptm_ratio)  ] ,
                                                [   new b2Vec2(27.5/ptm_ratio, 137/ptm_ratio)  ,  new b2Vec2(66/ptm_ratio, 322/ptm_ratio)  ,  new b2Vec2(44.5/ptm_ratio, 237/ptm_ratio)  ]
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

                                                [   new b2Vec2(595/ptm_ratio, 227/ptm_ratio)  ,  new b2Vec2(476/ptm_ratio, 180.5/ptm_ratio)  ,  new b2Vec2(580/ptm_ratio, 180.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(306/ptm_ratio, 182/ptm_ratio)  ,  new b2Vec2(354.5/ptm_ratio, 227/ptm_ratio)  ,  new b2Vec2(345.5/ptm_ratio, 263/ptm_ratio)  ] ,
                                                [   new b2Vec2(799.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(583/ptm_ratio, 497/ptm_ratio)  ,  new b2Vec2(593.5/ptm_ratio, 462/ptm_ratio)  ,  new b2Vec2(676/ptm_ratio, 275.5/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 290/ptm_ratio)  ] ,
                                                [   new b2Vec2(306/ptm_ratio, 182/ptm_ratio)  ,  new b2Vec2(373/ptm_ratio, 209.5/ptm_ratio)  ,  new b2Vec2(354.5/ptm_ratio, 227/ptm_ratio)  ] ,
                                                [   new b2Vec2(475/ptm_ratio, 180.5/ptm_ratio)  ,  new b2Vec2(373/ptm_ratio, 209.5/ptm_ratio)  ,  new b2Vec2(306/ptm_ratio, 182/ptm_ratio)  ] ,
                                                [   new b2Vec2(475/ptm_ratio, 180.5/ptm_ratio)  ,  new b2Vec2(398.5/ptm_ratio, 231/ptm_ratio)  ,  new b2Vec2(373/ptm_ratio, 209.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(475/ptm_ratio, 180.5/ptm_ratio)  ,  new b2Vec2(426.5/ptm_ratio, 280/ptm_ratio)  ,  new b2Vec2(398.5/ptm_ratio, 231/ptm_ratio)  ] ,
                                                [   new b2Vec2(475/ptm_ratio, 180.5/ptm_ratio)  ,  new b2Vec2(476/ptm_ratio, 180.5/ptm_ratio)  ,  new b2Vec2(578/ptm_ratio, 421/ptm_ratio)  ,  new b2Vec2(450/ptm_ratio, 355/ptm_ratio)  ,  new b2Vec2(426.5/ptm_ratio, 280/ptm_ratio)  ] ,
                                                [   new b2Vec2(449/ptm_ratio, 380/ptm_ratio)  ,  new b2Vec2(578/ptm_ratio, 421/ptm_ratio)  ,  new b2Vec2(377/ptm_ratio, 393/ptm_ratio)  ,  new b2Vec2(338/ptm_ratio, 380.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(450/ptm_ratio, 355/ptm_ratio)  ,  new b2Vec2(578/ptm_ratio, 421/ptm_ratio)  ,  new b2Vec2(449/ptm_ratio, 380/ptm_ratio)  ] ,
                                                [   new b2Vec2(560/ptm_ratio, 527.5/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 600.5/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, 534/ptm_ratio)  ] ,
                                                [   new b2Vec2(583/ptm_ratio, 497/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(560/ptm_ratio, 527.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(676/ptm_ratio, 275.5/ptm_ratio)  ,  new b2Vec2(590.5/ptm_ratio, 438/ptm_ratio)  ,  new b2Vec2(578/ptm_ratio, 421/ptm_ratio)  ,  new b2Vec2(476/ptm_ratio, 180.5/ptm_ratio)  ,  new b2Vec2(595/ptm_ratio, 227/ptm_ratio)  ,  new b2Vec2(647/ptm_ratio, 250.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(590.5/ptm_ratio, 438/ptm_ratio)  ,  new b2Vec2(676/ptm_ratio, 275.5/ptm_ratio)  ,  new b2Vec2(593.5/ptm_ratio, 462/ptm_ratio)  ]
											]

										]

									];

			dict["b7"] = [

										[
											// density, friction, restitution
                                            2, 0, 0,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(119/ptm_ratio, 127.5/ptm_ratio)  ,  new b2Vec2(93/ptm_ratio, 149.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(453.5/ptm_ratio, 130/ptm_ratio)  ,  new b2Vec2(474/ptm_ratio, 130.5/ptm_ratio)  ,  new b2Vec2(462.5/ptm_ratio, 153/ptm_ratio)  ] ,
                                                [   new b2Vec2(389/ptm_ratio, 148.5/ptm_ratio)  ,  new b2Vec2(407/ptm_ratio, 142.5/ptm_ratio)  ,  new b2Vec2(400.5/ptm_ratio, 167/ptm_ratio)  ] ,
                                                [   new b2Vec2(164/ptm_ratio, 132/ptm_ratio)  ,  new b2Vec2(195/ptm_ratio, 130.5/ptm_ratio)  ,  new b2Vec2(177/ptm_ratio, 148.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(195/ptm_ratio, 130.5/ptm_ratio)  ,  new b2Vec2(247/ptm_ratio, 135.5/ptm_ratio)  ,  new b2Vec2(221.5/ptm_ratio, 158/ptm_ratio)  ] ,
                                                [   new b2Vec2(334/ptm_ratio, 135/ptm_ratio)  ,  new b2Vec2(365/ptm_ratio, 130.5/ptm_ratio)  ,  new b2Vec2(351/ptm_ratio, 145.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(426/ptm_ratio, 131.5/ptm_ratio)  ,  new b2Vec2(453.5/ptm_ratio, 130/ptm_ratio)  ,  new b2Vec2(446.5/ptm_ratio, 145/ptm_ratio)  ] ,
                                                [   new b2Vec2(520.5/ptm_ratio, 133/ptm_ratio)  ,  new b2Vec2(543/ptm_ratio, 144.5/ptm_ratio)  ,  new b2Vec2(535.5/ptm_ratio, 159/ptm_ratio)  ] ,
                                                [   new b2Vec2(747/ptm_ratio, 479.5/ptm_ratio)  ,  new b2Vec2(754.5/ptm_ratio, 260/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 364/ptm_ratio)  ,  new b2Vec2(765.5/ptm_ratio, 484/ptm_ratio)  ,  new b2Vec2(760/ptm_ratio, 490.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(639/ptm_ratio, 521.5/ptm_ratio)  ,  new b2Vec2(693/ptm_ratio, 487/ptm_ratio)  ,  new b2Vec2(747/ptm_ratio, 479.5/ptm_ratio)  ,  new b2Vec2(711/ptm_ratio, 527.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(119/ptm_ratio, 127.5/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(164/ptm_ratio, 132/ptm_ratio)  ,  new b2Vec2(135/ptm_ratio, 140.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(365/ptm_ratio, 130.5/ptm_ratio)  ,  new b2Vec2(426/ptm_ratio, 131.5/ptm_ratio)  ,  new b2Vec2(407/ptm_ratio, 142.5/ptm_ratio)  ,  new b2Vec2(389/ptm_ratio, 148.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(586/ptm_ratio, 279/ptm_ratio)  ,  new b2Vec2(749/ptm_ratio, 279.5/ptm_ratio)  ,  new b2Vec2(650/ptm_ratio, 295.5/ptm_ratio)  ,  new b2Vec2(606/ptm_ratio, 297.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(75/ptm_ratio, 121/ptm_ratio)  ,  new b2Vec2(50/ptm_ratio, 143.5/ptm_ratio)  ,  new b2Vec2(42/ptm_ratio, 141.5/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 126/ptm_ratio)  ] ,
                                                [   new b2Vec2(453.5/ptm_ratio, 130/ptm_ratio)  ,  new b2Vec2(493/ptm_ratio, 123.5/ptm_ratio)  ,  new b2Vec2(474/ptm_ratio, 130.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(195/ptm_ratio, 130.5/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(279/ptm_ratio, 126.5/ptm_ratio)  ,  new b2Vec2(247/ptm_ratio, 135.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(749/ptm_ratio, 279.5/ptm_ratio)  ,  new b2Vec2(678.5/ptm_ratio, 301/ptm_ratio)  ,  new b2Vec2(650/ptm_ratio, 295.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(749/ptm_ratio, 279.5/ptm_ratio)  ,  new b2Vec2(703.5/ptm_ratio, 336/ptm_ratio)  ,  new b2Vec2(678.5/ptm_ratio, 301/ptm_ratio)  ] ,
                                                [   new b2Vec2(749/ptm_ratio, 279.5/ptm_ratio)  ,  new b2Vec2(713.5/ptm_ratio, 364/ptm_ratio)  ,  new b2Vec2(703.5/ptm_ratio, 336/ptm_ratio)  ] ,
                                                [   new b2Vec2(749/ptm_ratio, 279.5/ptm_ratio)  ,  new b2Vec2(747/ptm_ratio, 479.5/ptm_ratio)  ,  new b2Vec2(716.5/ptm_ratio, 404/ptm_ratio)  ,  new b2Vec2(713.5/ptm_ratio, 364/ptm_ratio)  ] ,
                                                [   new b2Vec2(543/ptm_ratio, 144.5/ptm_ratio)  ,  new b2Vec2(520.5/ptm_ratio, 133/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(661/ptm_ratio, 167/ptm_ratio)  ,  new b2Vec2(651/ptm_ratio, 177.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(279/ptm_ratio, 126.5/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(365/ptm_ratio, 130.5/ptm_ratio)  ,  new b2Vec2(334/ptm_ratio, 135/ptm_ratio)  ] ,
                                                [   new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(195/ptm_ratio, 130.5/ptm_ratio)  ,  new b2Vec2(164/ptm_ratio, 132/ptm_ratio)  ] ,
                                                [   new b2Vec2(469/ptm_ratio, 480/ptm_ratio)  ,  new b2Vec2(693/ptm_ratio, 487/ptm_ratio)  ,  new b2Vec2(639/ptm_ratio, 521.5/ptm_ratio)  ,  new b2Vec2(455/ptm_ratio, 489.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(711.5/ptm_ratio, 436/ptm_ratio)  ,  new b2Vec2(747/ptm_ratio, 479.5/ptm_ratio)  ,  new b2Vec2(693/ptm_ratio, 487/ptm_ratio)  ] ,
                                                [   new b2Vec2(716.5/ptm_ratio, 404/ptm_ratio)  ,  new b2Vec2(747/ptm_ratio, 479.5/ptm_ratio)  ,  new b2Vec2(711.5/ptm_ratio, 436/ptm_ratio)  ] ,
                                                [   new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(493/ptm_ratio, 123.5/ptm_ratio)  ,  new b2Vec2(453.5/ptm_ratio, 130/ptm_ratio)  ,  new b2Vec2(426/ptm_ratio, 131.5/ptm_ratio)  ,  new b2Vec2(365/ptm_ratio, 130.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(754.5/ptm_ratio, 260/ptm_ratio)  ,  new b2Vec2(747/ptm_ratio, 479.5/ptm_ratio)  ,  new b2Vec2(749/ptm_ratio, 279.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(750.5/ptm_ratio, 228/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(754.5/ptm_ratio, 260/ptm_ratio)  ] ,
                                                [   new b2Vec2(720/ptm_ratio, 192.5/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(750.5/ptm_ratio, 228/ptm_ratio)  ] ,
                                                [   new b2Vec2(661/ptm_ratio, 167/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(720/ptm_ratio, 192.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(493/ptm_ratio, 123.5/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(520.5/ptm_ratio, 133/ptm_ratio)  ]
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

                                                [   new b2Vec2(161/ptm_ratio, 410/ptm_ratio)  ,  new b2Vec2(182/ptm_ratio, 351/ptm_ratio)  ,  new b2Vec2(196/ptm_ratio, 391/ptm_ratio)  ] ,
                                                [   new b2Vec2(268/ptm_ratio, 504/ptm_ratio)  ,  new b2Vec2(197/ptm_ratio, 469/ptm_ratio)  ,  new b2Vec2(383/ptm_ratio, 469/ptm_ratio)  ] ,
                                                [   new b2Vec2(242/ptm_ratio, 526/ptm_ratio)  ,  new b2Vec2(173/ptm_ratio, 465/ptm_ratio)  ,  new b2Vec2(197/ptm_ratio, 469/ptm_ratio)  ,  new b2Vec2(268/ptm_ratio, 504/ptm_ratio)  ] ,
                                                [   new b2Vec2(800/ptm_ratio, 595/ptm_ratio)  ,  new b2Vec2(607/ptm_ratio, 574/ptm_ratio)  ,  new b2Vec2(799/ptm_ratio, 555/ptm_ratio)  ] ,
                                                [   new b2Vec2(72/ptm_ratio, 199/ptm_ratio)  ,  new b2Vec2(145/ptm_ratio, 249/ptm_ratio)  ,  new b2Vec2(138/ptm_ratio, 272/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 597/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 205/ptm_ratio)  ] ,
                                                [   new b2Vec2(242/ptm_ratio, 553/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 597/ptm_ratio)  ,  new b2Vec2(147/ptm_ratio, 446/ptm_ratio)  ,  new b2Vec2(161/ptm_ratio, 455/ptm_ratio)  ,  new b2Vec2(242/ptm_ratio, 526/ptm_ratio)  ] ,
                                                [   new b2Vec2(143/ptm_ratio, 428/ptm_ratio)  ,  new b2Vec2(158/ptm_ratio, 288/ptm_ratio)  ,  new b2Vec2(182/ptm_ratio, 351/ptm_ratio)  ,  new b2Vec2(161/ptm_ratio, 410/ptm_ratio)  ] ,
                                                [   new b2Vec2(217/ptm_ratio, 221/ptm_ratio)  ,  new b2Vec2(72/ptm_ratio, 199/ptm_ratio)  ,  new b2Vec2(296/ptm_ratio, 204/ptm_ratio)  ,  new b2Vec2(277/ptm_ratio, 213/ptm_ratio)  ] ,
                                                [   new b2Vec2(169/ptm_ratio, 235/ptm_ratio)  ,  new b2Vec2(72/ptm_ratio, 199/ptm_ratio)  ,  new b2Vec2(217/ptm_ratio, 221/ptm_ratio)  ] ,
                                                [   new b2Vec2(145/ptm_ratio, 249/ptm_ratio)  ,  new b2Vec2(72/ptm_ratio, 199/ptm_ratio)  ,  new b2Vec2(169/ptm_ratio, 235/ptm_ratio)  ] ,
                                                [   new b2Vec2(158/ptm_ratio, 288/ptm_ratio)  ,  new b2Vec2(143/ptm_ratio, 428/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 597/ptm_ratio)  ,  new b2Vec2(138/ptm_ratio, 272/ptm_ratio)  ] ,
                                                [   new b2Vec2(800/ptm_ratio, 595/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 597/ptm_ratio)  ,  new b2Vec2(309/ptm_ratio, 577/ptm_ratio)  ,  new b2Vec2(607/ptm_ratio, 574/ptm_ratio)  ] ,
                                                [   new b2Vec2(1/ptm_ratio, 597/ptm_ratio)  ,  new b2Vec2(242/ptm_ratio, 553/ptm_ratio)  ,  new b2Vec2(309/ptm_ratio, 577/ptm_ratio)  ] ,
                                                [   new b2Vec2(1/ptm_ratio, 597/ptm_ratio)  ,  new b2Vec2(143/ptm_ratio, 428/ptm_ratio)  ,  new b2Vec2(147/ptm_ratio, 446/ptm_ratio)  ] ,
                                                [   new b2Vec2(158/ptm_ratio, 288/ptm_ratio)  ,  new b2Vec2(206/ptm_ratio, 315/ptm_ratio)  ,  new b2Vec2(182/ptm_ratio, 351/ptm_ratio)  ] ,
                                                [   new b2Vec2(158/ptm_ratio, 288/ptm_ratio)  ,  new b2Vec2(442/ptm_ratio, 285/ptm_ratio)  ,  new b2Vec2(410/ptm_ratio, 294/ptm_ratio)  ,  new b2Vec2(206/ptm_ratio, 315/ptm_ratio)  ]
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

                                                [   new b2Vec2(625/ptm_ratio, 232.5/ptm_ratio)  ,  new b2Vec2(561/ptm_ratio, 233.5/ptm_ratio)  ,  new b2Vec2(478/ptm_ratio, 208.5/ptm_ratio)  ,  new b2Vec2(637/ptm_ratio, 210/ptm_ratio)  ,  new b2Vec2(650/ptm_ratio, 215.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(491/ptm_ratio, 248.5/ptm_ratio)  ,  new b2Vec2(477/ptm_ratio, 208.5/ptm_ratio)  ,  new b2Vec2(478/ptm_ratio, 208.5/ptm_ratio)  ,  new b2Vec2(528/ptm_ratio, 266.5/ptm_ratio)  ,  new b2Vec2(520/ptm_ratio, 266.5/ptm_ratio)  ,  new b2Vec2(500/ptm_ratio, 263.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(528/ptm_ratio, 266.5/ptm_ratio)  ,  new b2Vec2(478/ptm_ratio, 208.5/ptm_ratio)  ,  new b2Vec2(561/ptm_ratio, 233.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(477/ptm_ratio, 208.5/ptm_ratio)  ,  new b2Vec2(446/ptm_ratio, 235/ptm_ratio)  ,  new b2Vec2(403/ptm_ratio, 229.5/ptm_ratio)  ,  new b2Vec2(343/ptm_ratio, 208.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(477/ptm_ratio, 208.5/ptm_ratio)  ,  new b2Vec2(471/ptm_ratio, 241.5/ptm_ratio)  ,  new b2Vec2(446/ptm_ratio, 235/ptm_ratio)  ] ,
                                                [   new b2Vec2(477/ptm_ratio, 208.5/ptm_ratio)  ,  new b2Vec2(491/ptm_ratio, 248.5/ptm_ratio)  ,  new b2Vec2(471/ptm_ratio, 241.5/ptm_ratio)  ]
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

                                                [   new b2Vec2(441/ptm_ratio, 363/ptm_ratio)  ,  new b2Vec2(333/ptm_ratio, 387/ptm_ratio)  ,  new b2Vec2(265/ptm_ratio, 362/ptm_ratio)  ] ,
                                                [   new b2Vec2(441/ptm_ratio, 363/ptm_ratio)  ,  new b2Vec2(597/ptm_ratio, 386/ptm_ratio)  ,  new b2Vec2(577/ptm_ratio, 408/ptm_ratio)  ,  new b2Vec2(365/ptm_ratio, 409/ptm_ratio)  ,  new b2Vec2(333/ptm_ratio, 387/ptm_ratio)  ] ,
                                                [   new b2Vec2(597/ptm_ratio, 386/ptm_ratio)  ,  new b2Vec2(441/ptm_ratio, 363/ptm_ratio)  ,  new b2Vec2(442/ptm_ratio, 361/ptm_ratio)  ,  new b2Vec2(632/ptm_ratio, 362/ptm_ratio)  ,  new b2Vec2(625/ptm_ratio, 372/ptm_ratio)  ]
											]

										]

									];

			dict["b8"] = [

										[
											// density, friction, restitution
                                            2, 0, 0,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(276/ptm_ratio, 217/ptm_ratio)  ,  new b2Vec2(372/ptm_ratio, 182/ptm_ratio)  ,  new b2Vec2(320.5/ptm_ratio, 286/ptm_ratio)  ] ,
                                                [   new b2Vec2(30.5/ptm_ratio, 319/ptm_ratio)  ,  new b2Vec2(96/ptm_ratio, 288.5/ptm_ratio)  ,  new b2Vec2(61/ptm_ratio, 366.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(195/ptm_ratio, 199/ptm_ratio)  ,  new b2Vec2(276/ptm_ratio, 217/ptm_ratio)  ,  new b2Vec2(244/ptm_ratio, 259.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(96/ptm_ratio, 288.5/ptm_ratio)  ,  new b2Vec2(174/ptm_ratio, 236.5/ptm_ratio)  ,  new b2Vec2(132/ptm_ratio, 336.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(372/ptm_ratio, 182/ptm_ratio)  ,  new b2Vec2(484.5/ptm_ratio, 41/ptm_ratio)  ,  new b2Vec2(504.5/ptm_ratio, 101/ptm_ratio)  ,  new b2Vec2(439.5/ptm_ratio, 216/ptm_ratio)  ] ,
                                                [   new b2Vec2(195/ptm_ratio, 199/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(494/ptm_ratio, 1.5/ptm_ratio)  ,  new b2Vec2(484.5/ptm_ratio, 41/ptm_ratio)  ,  new b2Vec2(372/ptm_ratio, 182/ptm_ratio)  ,  new b2Vec2(276/ptm_ratio, 217/ptm_ratio)  ] ,
                                                [   new b2Vec2(96/ptm_ratio, 288.5/ptm_ratio)  ,  new b2Vec2(30.5/ptm_ratio, 319/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(195/ptm_ratio, 199/ptm_ratio)  ,  new b2Vec2(174/ptm_ratio, 236.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(30.5/ptm_ratio, 319/ptm_ratio)  ,  new b2Vec2(1.5/ptm_ratio, 362/ptm_ratio)  ]
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

                                                [   new b2Vec2(413/ptm_ratio, 338/ptm_ratio)  ,  new b2Vec2(387/ptm_ratio, 417.5/ptm_ratio)  ,  new b2Vec2(337/ptm_ratio, 463.5/ptm_ratio)  ,  new b2Vec2(251/ptm_ratio, 383/ptm_ratio)  ] ,
                                                [   new b2Vec2(614/ptm_ratio, 257/ptm_ratio)  ,  new b2Vec2(584/ptm_ratio, 235/ptm_ratio)  ,  new b2Vec2(630/ptm_ratio, 233/ptm_ratio)  ] ,
                                                [   new b2Vec2(460.5/ptm_ratio, 382/ptm_ratio)  ,  new b2Vec2(413/ptm_ratio, 338/ptm_ratio)  ,  new b2Vec2(518/ptm_ratio, 243.5/ptm_ratio)  ,  new b2Vec2(593.5/ptm_ratio, 379/ptm_ratio)  ,  new b2Vec2(546/ptm_ratio, 445.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(387/ptm_ratio, 417.5/ptm_ratio)  ,  new b2Vec2(413/ptm_ratio, 338/ptm_ratio)  ,  new b2Vec2(439/ptm_ratio, 398/ptm_ratio)  ,  new b2Vec2(405/ptm_ratio, 434.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(571.5/ptm_ratio, 338/ptm_ratio)  ,  new b2Vec2(518/ptm_ratio, 243.5/ptm_ratio)  ,  new b2Vec2(584/ptm_ratio, 235/ptm_ratio)  ,  new b2Vec2(614/ptm_ratio, 257/ptm_ratio)  ] ,
                                                [   new b2Vec2(439/ptm_ratio, 398/ptm_ratio)  ,  new b2Vec2(413/ptm_ratio, 338/ptm_ratio)  ,  new b2Vec2(460.5/ptm_ratio, 382/ptm_ratio)  ]
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

                                                [   new b2Vec2(637/ptm_ratio, 63/ptm_ratio)  ,  new b2Vec2(800/ptm_ratio, 2/ptm_ratio)  ,  new b2Vec2(685/ptm_ratio, 132/ptm_ratio)  ,  new b2Vec2(626/ptm_ratio, 90/ptm_ratio)  ,  new b2Vec2(623/ptm_ratio, 73/ptm_ratio)  ] ,
                                                [   new b2Vec2(800/ptm_ratio, 2/ptm_ratio)  ,  new b2Vec2(637/ptm_ratio, 63/ptm_ratio)  ,  new b2Vec2(630/ptm_ratio, 1/ptm_ratio)  ] ,
                                                [   new b2Vec2(685/ptm_ratio, 132/ptm_ratio)  ,  new b2Vec2(706/ptm_ratio, 172/ptm_ratio)  ,  new b2Vec2(695/ptm_ratio, 191/ptm_ratio)  ] ,
                                                [   new b2Vec2(685/ptm_ratio, 132/ptm_ratio)  ,  new b2Vec2(800/ptm_ratio, 2/ptm_ratio)  ,  new b2Vec2(717/ptm_ratio, 157/ptm_ratio)  ,  new b2Vec2(706/ptm_ratio, 172/ptm_ratio)  ] ,
                                                [   new b2Vec2(800/ptm_ratio, 2/ptm_ratio)  ,  new b2Vec2(744/ptm_ratio, 254/ptm_ratio)  ,  new b2Vec2(717/ptm_ratio, 157/ptm_ratio)  ] ,
                                                [   new b2Vec2(744/ptm_ratio, 254/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(743/ptm_ratio, 446/ptm_ratio)  ,  new b2Vec2(722/ptm_ratio, 334/ptm_ratio)  ] ,
                                                [   new b2Vec2(798/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(744/ptm_ratio, 254/ptm_ratio)  ,  new b2Vec2(800/ptm_ratio, 2/ptm_ratio)  ] ,
                                                [   new b2Vec2(798/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(780/ptm_ratio, 597/ptm_ratio)  ,  new b2Vec2(739/ptm_ratio, 494/ptm_ratio)  ,  new b2Vec2(743/ptm_ratio, 446/ptm_ratio)  ]
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

                                                [   new b2Vec2(168/ptm_ratio, 540.5/ptm_ratio)  ,  new b2Vec2(254/ptm_ratio, 565/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 598/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 556/ptm_ratio)  ] ,
                                                [   new b2Vec2(613/ptm_ratio, 576.5/ptm_ratio)  ,  new b2Vec2(642/ptm_ratio, 595.5/ptm_ratio)  ,  new b2Vec2(485/ptm_ratio, 568.5/ptm_ratio)  ,  new b2Vec2(561/ptm_ratio, 559.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(254/ptm_ratio, 565/ptm_ratio)  ,  new b2Vec2(485/ptm_ratio, 568.5/ptm_ratio)  ,  new b2Vec2(642/ptm_ratio, 595.5/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 598/ptm_ratio)  ] ,
                                                [   new b2Vec2(392/ptm_ratio, 548.5/ptm_ratio)  ,  new b2Vec2(485/ptm_ratio, 568.5/ptm_ratio)  ,  new b2Vec2(254/ptm_ratio, 565/ptm_ratio)  ,  new b2Vec2(364/ptm_ratio, 543.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(392/ptm_ratio, 548.5/ptm_ratio)  ,  new b2Vec2(393/ptm_ratio, 548.5/ptm_ratio)  ,  new b2Vec2(420/ptm_ratio, 551/ptm_ratio)  ,  new b2Vec2(485/ptm_ratio, 568.5/ptm_ratio)  ]
											]

										]

									];

			dict["c8"] = [

										[
											// density, friction, restitution
                                            2, 0, 0,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(798/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(785.5/ptm_ratio, 29/ptm_ratio)  ,  new b2Vec2(781.5/ptm_ratio, 1/ptm_ratio)  ] ,
                                                [   new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(351/ptm_ratio, 551/ptm_ratio)  ,  new b2Vec2(343.5/ptm_ratio, 575/ptm_ratio)  ,  new b2Vec2(321/ptm_ratio, 600.5/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 599.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(351/ptm_ratio, 551/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(402/ptm_ratio, 525.5/ptm_ratio)  ,  new b2Vec2(388.5/ptm_ratio, 548/ptm_ratio)  ] ,
                                                [   new b2Vec2(422.5/ptm_ratio, 531/ptm_ratio)  ,  new b2Vec2(774/ptm_ratio, 47.5/ptm_ratio)  ,  new b2Vec2(796.5/ptm_ratio, 600/ptm_ratio)  ,  new b2Vec2(460.5/ptm_ratio, 570/ptm_ratio)  ,  new b2Vec2(435/ptm_ratio, 552/ptm_ratio)  ] ,
                                                [   new b2Vec2(460.5/ptm_ratio, 570/ptm_ratio)  ,  new b2Vec2(796.5/ptm_ratio, 600/ptm_ratio)  ,  new b2Vec2(472/ptm_ratio, 600.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(774/ptm_ratio, 47.5/ptm_ratio)  ,  new b2Vec2(422.5/ptm_ratio, 531/ptm_ratio)  ,  new b2Vec2(402/ptm_ratio, 525.5/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(666/ptm_ratio, 15.5/ptm_ratio)  ,  new b2Vec2(730/ptm_ratio, 29.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(666/ptm_ratio, 15.5/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(646/ptm_ratio, -0.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(796.5/ptm_ratio, 600/ptm_ratio)  ,  new b2Vec2(785.5/ptm_ratio, 29/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, -0.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(796.5/ptm_ratio, 600/ptm_ratio)  ,  new b2Vec2(774/ptm_ratio, 47.5/ptm_ratio)  ,  new b2Vec2(785.5/ptm_ratio, 29/ptm_ratio)  ]
											]

										]

									];

			dict["d6"] = [

										[
											// density, friction, restitution
                                            2, 0, 0,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(232/ptm_ratio, 186/ptm_ratio)  ,  new b2Vec2(141/ptm_ratio, 288/ptm_ratio)  ,  new b2Vec2(154/ptm_ratio, 185/ptm_ratio)  ,  new b2Vec2(189/ptm_ratio, 144.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(141/ptm_ratio, 288/ptm_ratio)  ,  new b2Vec2(156/ptm_ratio, 302.5/ptm_ratio)  ,  new b2Vec2(130.5/ptm_ratio, 288/ptm_ratio)  ] ,
                                                [   new b2Vec2(224/ptm_ratio, 302.5/ptm_ratio)  ,  new b2Vec2(156/ptm_ratio, 302.5/ptm_ratio)  ,  new b2Vec2(241/ptm_ratio, 287/ptm_ratio)  ,  new b2Vec2(250/ptm_ratio, 287/ptm_ratio)  ] ,
                                                [   new b2Vec2(156/ptm_ratio, 302.5/ptm_ratio)  ,  new b2Vec2(141/ptm_ratio, 288/ptm_ratio)  ,  new b2Vec2(232/ptm_ratio, 186/ptm_ratio)  ,  new b2Vec2(241/ptm_ratio, 184/ptm_ratio)  ,  new b2Vec2(241/ptm_ratio, 287/ptm_ratio)  ] ,
                                                [   new b2Vec2(154/ptm_ratio, 185/ptm_ratio)  ,  new b2Vec2(141/ptm_ratio, 288/ptm_ratio)  ,  new b2Vec2(141.5/ptm_ratio, 184/ptm_ratio)  ]
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

                                                [   new b2Vec2(554/ptm_ratio, 287/ptm_ratio)  ,  new b2Vec2(635/ptm_ratio, 302.5/ptm_ratio)  ,  new b2Vec2(567/ptm_ratio, 302.5/ptm_ratio)  ,  new b2Vec2(545/ptm_ratio, 288/ptm_ratio)  ] ,
                                                [   new b2Vec2(635/ptm_ratio, 302.5/ptm_ratio)  ,  new b2Vec2(651/ptm_ratio, 288/ptm_ratio)  ,  new b2Vec2(662/ptm_ratio, 287/ptm_ratio)  ] ,
                                                [   new b2Vec2(552.5/ptm_ratio, 181/ptm_ratio)  ,  new b2Vec2(563/ptm_ratio, 185/ptm_ratio)  ,  new b2Vec2(651/ptm_ratio, 288/ptm_ratio)  ,  new b2Vec2(635/ptm_ratio, 302.5/ptm_ratio)  ,  new b2Vec2(554/ptm_ratio, 287/ptm_ratio)  ] ,
                                                [   new b2Vec2(651/ptm_ratio, 288/ptm_ratio)  ,  new b2Vec2(641/ptm_ratio, 187/ptm_ratio)  ,  new b2Vec2(651/ptm_ratio, 182/ptm_ratio)  ] ,
                                                [   new b2Vec2(651/ptm_ratio, 288/ptm_ratio)  ,  new b2Vec2(563/ptm_ratio, 185/ptm_ratio)  ,  new b2Vec2(601/ptm_ratio, 143.5/ptm_ratio)  ,  new b2Vec2(602/ptm_ratio, 143.5/ptm_ratio)  ,  new b2Vec2(641/ptm_ratio, 187/ptm_ratio)  ]
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

                                                [   new b2Vec2(290/ptm_ratio, 28/ptm_ratio)  ,  new b2Vec2(300/ptm_ratio, 18/ptm_ratio)  ,  new b2Vec2(306/ptm_ratio, 34/ptm_ratio)  ] ,
                                                [   new b2Vec2(725/ptm_ratio, 143/ptm_ratio)  ,  new b2Vec2(728/ptm_ratio, 135/ptm_ratio)  ,  new b2Vec2(800/ptm_ratio, 135/ptm_ratio)  ,  new b2Vec2(739/ptm_ratio, 159/ptm_ratio)  ,  new b2Vec2(728/ptm_ratio, 154/ptm_ratio)  ] ,
                                                [   new b2Vec2(725/ptm_ratio, 505/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, 599/ptm_ratio)  ,  new b2Vec2(712/ptm_ratio, 532/ptm_ratio)  ,  new b2Vec2(714/ptm_ratio, 508/ptm_ratio)  ] ,
                                                [   new b2Vec2(269/ptm_ratio, 46/ptm_ratio)  ,  new b2Vec2(66/ptm_ratio, 47/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, -1/ptm_ratio)  ,  new b2Vec2(3/ptm_ratio, -1/ptm_ratio)  ,  new b2Vec2(290/ptm_ratio, 28/ptm_ratio)  ,  new b2Vec2(285/ptm_ratio, 40/ptm_ratio)  ] ,
                                                [   new b2Vec2(300/ptm_ratio, 18/ptm_ratio)  ,  new b2Vec2(3/ptm_ratio, -1/ptm_ratio)  ,  new b2Vec2(322/ptm_ratio, 3/ptm_ratio)  ,  new b2Vec2(316/ptm_ratio, 13/ptm_ratio)  ] ,
                                                [   new b2Vec2(800/ptm_ratio, 135/ptm_ratio)  ,  new b2Vec2(751/ptm_ratio, 173/ptm_ratio)  ,  new b2Vec2(739/ptm_ratio, 159/ptm_ratio)  ] ,
                                                [   new b2Vec2(745/ptm_ratio, 456/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, 599/ptm_ratio)  ,  new b2Vec2(737/ptm_ratio, 484/ptm_ratio)  ,  new b2Vec2(737/ptm_ratio, 469/ptm_ratio)  ] ,
                                                [   new b2Vec2(800/ptm_ratio, 135/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, 599/ptm_ratio)  ,  new b2Vec2(749/ptm_ratio, 397/ptm_ratio)  ,  new b2Vec2(751/ptm_ratio, 173/ptm_ratio)  ] ,
                                                [   new b2Vec2(798/ptm_ratio, 599/ptm_ratio)  ,  new b2Vec2(745/ptm_ratio, 456/ptm_ratio)  ,  new b2Vec2(749/ptm_ratio, 397/ptm_ratio)  ] ,
                                                [   new b2Vec2(798/ptm_ratio, 599/ptm_ratio)  ,  new b2Vec2(725/ptm_ratio, 505/ptm_ratio)  ,  new b2Vec2(737/ptm_ratio, 484/ptm_ratio)  ] ,
                                                [   new b2Vec2(2/ptm_ratio, 599/ptm_ratio)  ,  new b2Vec2(66/ptm_ratio, 533/ptm_ratio)  ,  new b2Vec2(712/ptm_ratio, 532/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, 599/ptm_ratio)  ] ,
                                                [   new b2Vec2(2/ptm_ratio, -1/ptm_ratio)  ,  new b2Vec2(66/ptm_ratio, 47/ptm_ratio)  ,  new b2Vec2(66/ptm_ratio, 533/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, 599/ptm_ratio)  ] ,
                                                [   new b2Vec2(290/ptm_ratio, 28/ptm_ratio)  ,  new b2Vec2(3/ptm_ratio, -1/ptm_ratio)  ,  new b2Vec2(300/ptm_ratio, 18/ptm_ratio)  ]
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

                                                [   new b2Vec2(493.5/ptm_ratio, 21/ptm_ratio)  ,  new b2Vec2(503.5/ptm_ratio, 29/ptm_ratio)  ,  new b2Vec2(487.5/ptm_ratio, 37/ptm_ratio)  ] ,
                                                [   new b2Vec2(712/ptm_ratio, 110.5/ptm_ratio)  ,  new b2Vec2(694/ptm_ratio, 77/ptm_ratio)  ,  new b2Vec2(800/ptm_ratio, 0/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, 110/ptm_ratio)  ] ,
                                                [   new b2Vec2(470/ptm_ratio, 0/ptm_ratio)  ,  new b2Vec2(623/ptm_ratio, 48/ptm_ratio)  ,  new b2Vec2(493.5/ptm_ratio, 21/ptm_ratio)  ,  new b2Vec2(477/ptm_ratio, 15.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(503.5/ptm_ratio, 29/ptm_ratio)  ,  new b2Vec2(623/ptm_ratio, 48/ptm_ratio)  ,  new b2Vec2(526/ptm_ratio, 47.5/ptm_ratio)  ,  new b2Vec2(506/ptm_ratio, 40.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(669/ptm_ratio, 60/ptm_ratio)  ,  new b2Vec2(800/ptm_ratio, 0/ptm_ratio)  ,  new b2Vec2(694/ptm_ratio, 77/ptm_ratio)  ] ,
                                                [   new b2Vec2(669/ptm_ratio, 60/ptm_ratio)  ,  new b2Vec2(623/ptm_ratio, 48/ptm_ratio)  ,  new b2Vec2(470/ptm_ratio, 0/ptm_ratio)  ,  new b2Vec2(800/ptm_ratio, 0/ptm_ratio)  ] ,
                                                [   new b2Vec2(493.5/ptm_ratio, 21/ptm_ratio)  ,  new b2Vec2(623/ptm_ratio, 48/ptm_ratio)  ,  new b2Vec2(503.5/ptm_ratio, 29/ptm_ratio)  ]
											]

										]

									];

			dict["d7"] = [

										[
											// density, friction, restitution
                                            2, 0, 0,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(289/ptm_ratio, 28.5/ptm_ratio)  ,  new b2Vec2(298/ptm_ratio, 18.5/ptm_ratio)  ,  new b2Vec2(305/ptm_ratio, 34.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(103/ptm_ratio, 68/ptm_ratio)  ,  new b2Vec2(78/ptm_ratio, 107/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 108/ptm_ratio)  ] ,
                                                [   new b2Vec2(298/ptm_ratio, 18.5/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(322/ptm_ratio, 0/ptm_ratio)  ,  new b2Vec2(314.5/ptm_ratio, 14/ptm_ratio)  ] ,
                                                [   new b2Vec2(264/ptm_ratio, 46.5/ptm_ratio)  ,  new b2Vec2(153/ptm_ratio, 50/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(289/ptm_ratio, 28.5/ptm_ratio)  ,  new b2Vec2(284/ptm_ratio, 40.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(153/ptm_ratio, 50/ptm_ratio)  ,  new b2Vec2(103/ptm_ratio, 68/ptm_ratio)  ] ,
                                                [   new b2Vec2(289/ptm_ratio, 28.5/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(298/ptm_ratio, 18.5/ptm_ratio)  ]
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

                                                [   new b2Vec2(492.5/ptm_ratio, 20/ptm_ratio)  ,  new b2Vec2(502.5/ptm_ratio, 29/ptm_ratio)  ,  new b2Vec2(487/ptm_ratio, 36.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(712/ptm_ratio, 109.5/ptm_ratio)  ,  new b2Vec2(693/ptm_ratio, 76/ptm_ratio)  ,  new b2Vec2(660/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(797/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 107/ptm_ratio)  ] ,
                                                [   new b2Vec2(470/ptm_ratio, 1/ptm_ratio)  ,  new b2Vec2(660/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(492.5/ptm_ratio, 20/ptm_ratio)  ,  new b2Vec2(476/ptm_ratio, 14.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(502.5/ptm_ratio, 29/ptm_ratio)  ,  new b2Vec2(660/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(610/ptm_ratio, 48.5/ptm_ratio)  ,  new b2Vec2(514/ptm_ratio, 44.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(660/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(502.5/ptm_ratio, 29/ptm_ratio)  ,  new b2Vec2(492.5/ptm_ratio, 20/ptm_ratio)  ] ,
                                                [   new b2Vec2(660/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(670/ptm_ratio, 57/ptm_ratio)  ,  new b2Vec2(610/ptm_ratio, 48.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(660/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(693/ptm_ratio, 76/ptm_ratio)  ,  new b2Vec2(670/ptm_ratio, 57/ptm_ratio)  ]
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

                                                [   new b2Vec2(428/ptm_ratio, 275.5/ptm_ratio)  ,  new b2Vec2(415.5/ptm_ratio, 264/ptm_ratio)  ,  new b2Vec2(428/ptm_ratio, 201.5/ptm_ratio)  ,  new b2Vec2(447.5/ptm_ratio, 245/ptm_ratio)  ,  new b2Vec2(454.5/ptm_ratio, 285/ptm_ratio)  ] ,
                                                [   new b2Vec2(483/ptm_ratio, 133/ptm_ratio)  ,  new b2Vec2(448/ptm_ratio, 205.5/ptm_ratio)  ,  new b2Vec2(428/ptm_ratio, 201.5/ptm_ratio)  ,  new b2Vec2(474/ptm_ratio, 114.5/ptm_ratio)  ,  new b2Vec2(487/ptm_ratio, 114.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(474/ptm_ratio, 114.5/ptm_ratio)  ,  new b2Vec2(428/ptm_ratio, 201.5/ptm_ratio)  ,  new b2Vec2(315/ptm_ratio, 204/ptm_ratio)  ,  new b2Vec2(310/ptm_ratio, 116/ptm_ratio)  ] ,
                                                [   new b2Vec2(315.5/ptm_ratio, 305/ptm_ratio)  ,  new b2Vec2(309.5/ptm_ratio, 253/ptm_ratio)  ,  new b2Vec2(315/ptm_ratio, 204/ptm_ratio)  ,  new b2Vec2(412.5/ptm_ratio, 296/ptm_ratio)  ,  new b2Vec2(446.5/ptm_ratio, 333/ptm_ratio)  ,  new b2Vec2(436.5/ptm_ratio, 361/ptm_ratio)  ,  new b2Vec2(402/ptm_ratio, 398.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(448/ptm_ratio, 205.5/ptm_ratio)  ,  new b2Vec2(483/ptm_ratio, 133/ptm_ratio)  ,  new b2Vec2(486.5/ptm_ratio, 167/ptm_ratio)  ,  new b2Vec2(477.5/ptm_ratio, 223/ptm_ratio)  ,  new b2Vec2(467/ptm_ratio, 222.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(315/ptm_ratio, 204/ptm_ratio)  ,  new b2Vec2(409.5/ptm_ratio, 276/ptm_ratio)  ,  new b2Vec2(412.5/ptm_ratio, 296/ptm_ratio)  ] ,
                                                [   new b2Vec2(315/ptm_ratio, 204/ptm_ratio)  ,  new b2Vec2(428/ptm_ratio, 201.5/ptm_ratio)  ,  new b2Vec2(415.5/ptm_ratio, 264/ptm_ratio)  ,  new b2Vec2(409.5/ptm_ratio, 276/ptm_ratio)  ]
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

                                                [   new b2Vec2(479/ptm_ratio, 507.5/ptm_ratio)  ,  new b2Vec2(496/ptm_ratio, 496.5/ptm_ratio)  ,  new b2Vec2(495.5/ptm_ratio, 516/ptm_ratio)  ] ,
                                                [   new b2Vec2(381/ptm_ratio, 461.5/ptm_ratio)  ,  new b2Vec2(367/ptm_ratio, 471.5/ptm_ratio)  ,  new b2Vec2(369.5/ptm_ratio, 460/ptm_ratio)  ] ,
                                                [   new b2Vec2(374/ptm_ratio, 437.5/ptm_ratio)  ,  new b2Vec2(377/ptm_ratio, 450.5/ptm_ratio)  ,  new b2Vec2(354.5/ptm_ratio, 453/ptm_ratio)  ,  new b2Vec2(355/ptm_ratio, 437.5/ptm_ratio)  ,  new b2Vec2(365/ptm_ratio, 429.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(451/ptm_ratio, 420.5/ptm_ratio)  ,  new b2Vec2(450/ptm_ratio, 432.5/ptm_ratio)  ,  new b2Vec2(424/ptm_ratio, 426.5/ptm_ratio)  ,  new b2Vec2(436/ptm_ratio, 414.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(388/ptm_ratio, 434.5/ptm_ratio)  ,  new b2Vec2(389/ptm_ratio, 434.5/ptm_ratio)  ,  new b2Vec2(479.5/ptm_ratio, 454/ptm_ratio)  ,  new b2Vec2(381/ptm_ratio, 461.5/ptm_ratio)  ,  new b2Vec2(377/ptm_ratio, 450.5/ptm_ratio)  ,  new b2Vec2(374/ptm_ratio, 437.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(336/ptm_ratio, 463.5/ptm_ratio)  ,  new b2Vec2(352/ptm_ratio, 461.5/ptm_ratio)  ,  new b2Vec2(352/ptm_ratio, 471.5/ptm_ratio)  ,  new b2Vec2(333/ptm_ratio, 484.5/ptm_ratio)  ,  new b2Vec2(327.5/ptm_ratio, 472/ptm_ratio)  ] ,
                                                [   new b2Vec2(472.5/ptm_ratio, 510/ptm_ratio)  ,  new b2Vec2(479/ptm_ratio, 507.5/ptm_ratio)  ,  new b2Vec2(476.5/ptm_ratio, 523/ptm_ratio)  ,  new b2Vec2(470.5/ptm_ratio, 518/ptm_ratio)  ] ,
                                                [   new b2Vec2(480/ptm_ratio, 426.5/ptm_ratio)  ,  new b2Vec2(484.5/ptm_ratio, 434/ptm_ratio)  ,  new b2Vec2(479.5/ptm_ratio, 454/ptm_ratio)  ,  new b2Vec2(462/ptm_ratio, 431.5/ptm_ratio)  ,  new b2Vec2(471/ptm_ratio, 422.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(503.5/ptm_ratio, 454/ptm_ratio)  ,  new b2Vec2(479.5/ptm_ratio, 454/ptm_ratio)  ,  new b2Vec2(490/ptm_ratio, 446.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(88.5/ptm_ratio, 532/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(73.5/ptm_ratio, 504/ptm_ratio)  ,  new b2Vec2(88.5/ptm_ratio, 508/ptm_ratio)  ] ,
                                                [   new b2Vec2(300/ptm_ratio, 492.5/ptm_ratio)  ,  new b2Vec2(308/ptm_ratio, 491.5/ptm_ratio)  ,  new b2Vec2(320.5/ptm_ratio, 503/ptm_ratio)  ,  new b2Vec2(302.5/ptm_ratio, 523/ptm_ratio)  ,  new b2Vec2(293.5/ptm_ratio, 509/ptm_ratio)  ] ,
                                                [   new b2Vec2(726.5/ptm_ratio, 503/ptm_ratio)  ,  new b2Vec2(797/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(710/ptm_ratio, 532.5/ptm_ratio)  ,  new b2Vec2(712.5/ptm_ratio, 509/ptm_ratio)  ] ,
                                                [   new b2Vec2(333/ptm_ratio, 484.5/ptm_ratio)  ,  new b2Vec2(352/ptm_ratio, 471.5/ptm_ratio)  ,  new b2Vec2(367/ptm_ratio, 471.5/ptm_ratio)  ,  new b2Vec2(330/ptm_ratio, 494.5/ptm_ratio)  ,  new b2Vec2(326/ptm_ratio, 493.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(522.5/ptm_ratio, 469/ptm_ratio)  ,  new b2Vec2(524.5/ptm_ratio, 448/ptm_ratio)  ,  new b2Vec2(531.5/ptm_ratio, 447/ptm_ratio)  ,  new b2Vec2(529.5/ptm_ratio, 478/ptm_ratio)  ] ,
                                                [   new b2Vec2(496/ptm_ratio, 496.5/ptm_ratio)  ,  new b2Vec2(513.5/ptm_ratio, 452/ptm_ratio)  ,  new b2Vec2(509.5/ptm_ratio, 503/ptm_ratio)  ] ,
                                                [   new b2Vec2(49.5/ptm_ratio, 172/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, 135.5/ptm_ratio)  ,  new b2Vec2(70/ptm_ratio, 135.5/ptm_ratio)  ,  new b2Vec2(76.5/ptm_ratio, 146/ptm_ratio)  ] ,
                                                [   new b2Vec2(479.5/ptm_ratio, 454/ptm_ratio)  ,  new b2Vec2(450/ptm_ratio, 432.5/ptm_ratio)  ,  new b2Vec2(462/ptm_ratio, 431.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(726.5/ptm_ratio, 136/ptm_ratio)  ,  new b2Vec2(799/ptm_ratio, 135.5/ptm_ratio)  ,  new b2Vec2(749.5/ptm_ratio, 174/ptm_ratio)  ,  new b2Vec2(725/ptm_ratio, 152.5/ptm_ratio)  ,  new b2Vec2(723.5/ptm_ratio, 144/ptm_ratio)  ] ,
                                                [   new b2Vec2(524.5/ptm_ratio, 448/ptm_ratio)  ,  new b2Vec2(512.5/ptm_ratio, 435/ptm_ratio)  ,  new b2Vec2(531.5/ptm_ratio, 447/ptm_ratio)  ] ,
                                                [   new b2Vec2(524.5/ptm_ratio, 448/ptm_ratio)  ,  new b2Vec2(513.5/ptm_ratio, 452/ptm_ratio)  ,  new b2Vec2(503.5/ptm_ratio, 454/ptm_ratio)  ,  new b2Vec2(512.5/ptm_ratio, 435/ptm_ratio)  ] ,
                                                [   new b2Vec2(799/ptm_ratio, 135.5/ptm_ratio)  ,  new b2Vec2(797/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(749.5/ptm_ratio, 342/ptm_ratio)  ,  new b2Vec2(749.5/ptm_ratio, 174/ptm_ratio)  ] ,
                                                [   new b2Vec2(50.5/ptm_ratio, 380/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, 135.5/ptm_ratio)  ,  new b2Vec2(49.5/ptm_ratio, 172/ptm_ratio)  ] ,
                                                [   new b2Vec2(424/ptm_ratio, 426.5/ptm_ratio)  ,  new b2Vec2(450/ptm_ratio, 432.5/ptm_ratio)  ,  new b2Vec2(479.5/ptm_ratio, 454/ptm_ratio)  ,  new b2Vec2(389/ptm_ratio, 434.5/ptm_ratio)  ,  new b2Vec2(400/ptm_ratio, 427.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(479/ptm_ratio, 507.5/ptm_ratio)  ,  new b2Vec2(456/ptm_ratio, 511.5/ptm_ratio)  ,  new b2Vec2(289/ptm_ratio, 532.5/ptm_ratio)  ,  new b2Vec2(302.5/ptm_ratio, 523/ptm_ratio)  ,  new b2Vec2(503.5/ptm_ratio, 454/ptm_ratio)  ,  new b2Vec2(513.5/ptm_ratio, 452/ptm_ratio)  ,  new b2Vec2(496/ptm_ratio, 496.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(797/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(743.5/ptm_ratio, 454/ptm_ratio)  ,  new b2Vec2(749.5/ptm_ratio, 342/ptm_ratio)  ] ,
                                                [   new b2Vec2(797/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(726.5/ptm_ratio, 503/ptm_ratio)  ,  new b2Vec2(743.5/ptm_ratio, 454/ptm_ratio)  ] ,
                                                [   new b2Vec2(797/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(289/ptm_ratio, 532.5/ptm_ratio)  ,  new b2Vec2(710/ptm_ratio, 532.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(55.5/ptm_ratio, 456/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(50.5/ptm_ratio, 380/ptm_ratio)  ] ,
                                                [   new b2Vec2(73.5/ptm_ratio, 504/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(55.5/ptm_ratio, 456/ptm_ratio)  ] ,
                                                [   new b2Vec2(289/ptm_ratio, 532.5/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(88.5/ptm_ratio, 532/ptm_ratio)  ] ,
                                                [   new b2Vec2(352/ptm_ratio, 461.5/ptm_ratio)  ,  new b2Vec2(336/ptm_ratio, 463.5/ptm_ratio)  ,  new b2Vec2(332/ptm_ratio, 461.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(289/ptm_ratio, 532.5/ptm_ratio)  ,  new b2Vec2(456/ptm_ratio, 511.5/ptm_ratio)  ,  new b2Vec2(458/ptm_ratio, 532.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(456/ptm_ratio, 511.5/ptm_ratio)  ,  new b2Vec2(479/ptm_ratio, 507.5/ptm_ratio)  ,  new b2Vec2(472.5/ptm_ratio, 510/ptm_ratio)  ] ,
                                                [   new b2Vec2(367/ptm_ratio, 471.5/ptm_ratio)  ,  new b2Vec2(479.5/ptm_ratio, 454/ptm_ratio)  ,  new b2Vec2(503.5/ptm_ratio, 454/ptm_ratio)  ,  new b2Vec2(302.5/ptm_ratio, 523/ptm_ratio)  ,  new b2Vec2(320.5/ptm_ratio, 503/ptm_ratio)  ,  new b2Vec2(330/ptm_ratio, 494.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(479.5/ptm_ratio, 454/ptm_ratio)  ,  new b2Vec2(367/ptm_ratio, 471.5/ptm_ratio)  ,  new b2Vec2(381/ptm_ratio, 461.5/ptm_ratio)  ]
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

                                                [   new b2Vec2(229/ptm_ratio, 185/ptm_ratio)  ,  new b2Vec2(143/ptm_ratio, 287/ptm_ratio)  ,  new b2Vec2(149/ptm_ratio, 183/ptm_ratio)  ,  new b2Vec2(188/ptm_ratio, 143/ptm_ratio)  ] ,
                                                [   new b2Vec2(143/ptm_ratio, 287/ptm_ratio)  ,  new b2Vec2(152/ptm_ratio, 300/ptm_ratio)  ,  new b2Vec2(130/ptm_ratio, 287/ptm_ratio)  ] ,
                                                [   new b2Vec2(224/ptm_ratio, 300/ptm_ratio)  ,  new b2Vec2(152/ptm_ratio, 300/ptm_ratio)  ,  new b2Vec2(238/ptm_ratio, 285/ptm_ratio)  ,  new b2Vec2(249/ptm_ratio, 285/ptm_ratio)  ] ,
                                                [   new b2Vec2(152/ptm_ratio, 300/ptm_ratio)  ,  new b2Vec2(143/ptm_ratio, 287/ptm_ratio)  ,  new b2Vec2(229/ptm_ratio, 185/ptm_ratio)  ,  new b2Vec2(239/ptm_ratio, 179/ptm_ratio)  ,  new b2Vec2(238/ptm_ratio, 285/ptm_ratio)  ] ,
                                                [   new b2Vec2(149/ptm_ratio, 183/ptm_ratio)  ,  new b2Vec2(143/ptm_ratio, 287/ptm_ratio)  ,  new b2Vec2(141/ptm_ratio, 181/ptm_ratio)  ]
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

                                                [   new b2Vec2(638/ptm_ratio, 183/ptm_ratio)  ,  new b2Vec2(564/ptm_ratio, 185/ptm_ratio)  ,  new b2Vec2(602/ptm_ratio, 142.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(554/ptm_ratio, 285/ptm_ratio)  ,  new b2Vec2(568/ptm_ratio, 300.5/ptm_ratio)  ,  new b2Vec2(542.5/ptm_ratio, 287/ptm_ratio)  ] ,
                                                [   new b2Vec2(636/ptm_ratio, 300.5/ptm_ratio)  ,  new b2Vec2(568/ptm_ratio, 300.5/ptm_ratio)  ,  new b2Vec2(650/ptm_ratio, 285/ptm_ratio)  ,  new b2Vec2(660/ptm_ratio, 285.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(568/ptm_ratio, 300.5/ptm_ratio)  ,  new b2Vec2(554/ptm_ratio, 285/ptm_ratio)  ,  new b2Vec2(564/ptm_ratio, 185/ptm_ratio)  ,  new b2Vec2(638/ptm_ratio, 183/ptm_ratio)  ,  new b2Vec2(651.5/ptm_ratio, 184/ptm_ratio)  ,  new b2Vec2(650/ptm_ratio, 285/ptm_ratio)  ] ,
                                                [   new b2Vec2(564/ptm_ratio, 185/ptm_ratio)  ,  new b2Vec2(554/ptm_ratio, 285/ptm_ratio)  ,  new b2Vec2(552.5/ptm_ratio, 181/ptm_ratio)  ]
											]

										]

									];

			dict["d8"] = [

										[
											// density, friction, restitution
                                            2, 0, 0,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(289/ptm_ratio, 28.5/ptm_ratio)  ,  new b2Vec2(298/ptm_ratio, 18.5/ptm_ratio)  ,  new b2Vec2(305/ptm_ratio, 34.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(106/ptm_ratio, 66/ptm_ratio)  ,  new b2Vec2(78/ptm_ratio, 109.5/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, 109.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(298/ptm_ratio, 18.5/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(321/ptm_ratio, 1/ptm_ratio)  ,  new b2Vec2(314.5/ptm_ratio, 14/ptm_ratio)  ] ,
                                                [   new b2Vec2(264/ptm_ratio, 46.5/ptm_ratio)  ,  new b2Vec2(156/ptm_ratio, 49/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(289/ptm_ratio, 28.5/ptm_ratio)  ,  new b2Vec2(283.5/ptm_ratio, 40/ptm_ratio)  ] ,
                                                [   new b2Vec2(1/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(156/ptm_ratio, 49/ptm_ratio)  ,  new b2Vec2(106/ptm_ratio, 66/ptm_ratio)  ] ,
                                                [   new b2Vec2(289/ptm_ratio, 28.5/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(298/ptm_ratio, 18.5/ptm_ratio)  ]
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

                                                [   new b2Vec2(230/ptm_ratio, 185/ptm_ratio)  ,  new b2Vec2(154/ptm_ratio, 300.5/ptm_ratio)  ,  new b2Vec2(144/ptm_ratio, 286/ptm_ratio)  ,  new b2Vec2(155/ptm_ratio, 182/ptm_ratio)  ,  new b2Vec2(190/ptm_ratio, 142.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(144/ptm_ratio, 286/ptm_ratio)  ,  new b2Vec2(154/ptm_ratio, 300.5/ptm_ratio)  ,  new b2Vec2(132/ptm_ratio, 287/ptm_ratio)  ] ,
                                                [   new b2Vec2(226/ptm_ratio, 300.5/ptm_ratio)  ,  new b2Vec2(154/ptm_ratio, 300.5/ptm_ratio)  ,  new b2Vec2(241/ptm_ratio, 285/ptm_ratio)  ,  new b2Vec2(250/ptm_ratio, 285.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(154/ptm_ratio, 300.5/ptm_ratio)  ,  new b2Vec2(230/ptm_ratio, 185/ptm_ratio)  ,  new b2Vec2(241.5/ptm_ratio, 184/ptm_ratio)  ,  new b2Vec2(241/ptm_ratio, 285/ptm_ratio)  ] ,
                                                [   new b2Vec2(155/ptm_ratio, 182/ptm_ratio)  ,  new b2Vec2(144/ptm_ratio, 286/ptm_ratio)  ,  new b2Vec2(142.5/ptm_ratio, 181/ptm_ratio)  ]
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

                                                [   new b2Vec2(89/ptm_ratio, 534/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(72.5/ptm_ratio, 504/ptm_ratio)  ,  new b2Vec2(88.5/ptm_ratio, 507/ptm_ratio)  ] ,
                                                [   new b2Vec2(308.5/ptm_ratio, 577/ptm_ratio)  ,  new b2Vec2(89/ptm_ratio, 534/ptm_ratio)  ,  new b2Vec2(312/ptm_ratio, 550.5/ptm_ratio)  ,  new b2Vec2(315.5/ptm_ratio, 566/ptm_ratio)  ] ,
                                                [   new b2Vec2(72.5/ptm_ratio, 504/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(62.5/ptm_ratio, 483/ptm_ratio)  ,  new b2Vec2(71.5/ptm_ratio, 492/ptm_ratio)  ] ,
                                                [   new b2Vec2(62.5/ptm_ratio, 483/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(57/ptm_ratio, 464/ptm_ratio)  ,  new b2Vec2(63/ptm_ratio, 473/ptm_ratio)  ] ,
                                                [   new b2Vec2(49.5/ptm_ratio, 172/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, 135.5/ptm_ratio)  ,  new b2Vec2(70/ptm_ratio, 135.5/ptm_ratio)  ,  new b2Vec2(76.5/ptm_ratio, 146/ptm_ratio)  ] ,
                                                [   new b2Vec2(52.5/ptm_ratio, 428/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, 135.5/ptm_ratio)  ,  new b2Vec2(49.5/ptm_ratio, 172/ptm_ratio)  ] ,
                                                [   new b2Vec2(57/ptm_ratio, 464/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(52.5/ptm_ratio, 428/ptm_ratio)  ] ,
                                                [   new b2Vec2(89/ptm_ratio, 534/ptm_ratio)  ,  new b2Vec2(308.5/ptm_ratio, 577/ptm_ratio)  ,  new b2Vec2(312.5/ptm_ratio, 597/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 599.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(89/ptm_ratio, 534/ptm_ratio)  ,  new b2Vec2(319/ptm_ratio, 532.5/ptm_ratio)  ,  new b2Vec2(312/ptm_ratio, 550.5/ptm_ratio)  ]
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

                                                [   new b2Vec2(492.5/ptm_ratio, 20/ptm_ratio)  ,  new b2Vec2(498.5/ptm_ratio, 30/ptm_ratio)  ,  new b2Vec2(487/ptm_ratio, 36.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(500.5/ptm_ratio, 517/ptm_ratio)  ,  new b2Vec2(508.5/ptm_ratio, 503/ptm_ratio)  ,  new b2Vec2(518/ptm_ratio, 528.5/ptm_ratio)  ,  new b2Vec2(506/ptm_ratio, 534/ptm_ratio)  ] ,
                                                [   new b2Vec2(518/ptm_ratio, 528.5/ptm_ratio)  ,  new b2Vec2(486.5/ptm_ratio, 565/ptm_ratio)  ,  new b2Vec2(473.5/ptm_ratio, 535/ptm_ratio)  ] ,
                                                [   new b2Vec2(519/ptm_ratio, 432.5/ptm_ratio)  ,  new b2Vec2(509.5/ptm_ratio, 459/ptm_ratio)  ,  new b2Vec2(501.5/ptm_ratio, 445/ptm_ratio)  ,  new b2Vec2(506.5/ptm_ratio, 433/ptm_ratio)  ] ,
                                                [   new b2Vec2(507.5/ptm_ratio, 467/ptm_ratio)  ,  new b2Vec2(507.5/ptm_ratio, 495/ptm_ratio)  ,  new b2Vec2(496/ptm_ratio, 489.5/ptm_ratio)  ,  new b2Vec2(495.5/ptm_ratio, 473/ptm_ratio)  ] ,
                                                [   new b2Vec2(488.5/ptm_ratio, 597/ptm_ratio)  ,  new b2Vec2(518/ptm_ratio, 528.5/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(799.5/ptm_ratio, 597/ptm_ratio)  ] ,
                                                [   new b2Vec2(534/ptm_ratio, 402.5/ptm_ratio)  ,  new b2Vec2(546/ptm_ratio, 404.5/ptm_ratio)  ,  new b2Vec2(524.5/ptm_ratio, 426/ptm_ratio)  ,  new b2Vec2(523.5/ptm_ratio, 410/ptm_ratio)  ] ,
                                                [   new b2Vec2(470/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(593/ptm_ratio, 47.5/ptm_ratio)  ,  new b2Vec2(492.5/ptm_ratio, 20/ptm_ratio)  ,  new b2Vec2(476/ptm_ratio, 14.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(589/ptm_ratio, 69.5/ptm_ratio)  ,  new b2Vec2(554/ptm_ratio, 77.5/ptm_ratio)  ,  new b2Vec2(574/ptm_ratio, 64.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(318.5/ptm_ratio, 181/ptm_ratio)  ,  new b2Vec2(301/ptm_ratio, 227/ptm_ratio)  ,  new b2Vec2(299.5/ptm_ratio, 203/ptm_ratio)  ] ,
                                                [   new b2Vec2(422/ptm_ratio, 358.5/ptm_ratio)  ,  new b2Vec2(298.5/ptm_ratio, 271/ptm_ratio)  ,  new b2Vec2(460/ptm_ratio, 365.5/ptm_ratio)  ,  new b2Vec2(440/ptm_ratio, 367.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(301/ptm_ratio, 227/ptm_ratio)  ,  new b2Vec2(318.5/ptm_ratio, 181/ptm_ratio)  ,  new b2Vec2(388/ptm_ratio, 135.5/ptm_ratio)  ,  new b2Vec2(303/ptm_ratio, 269.5/ptm_ratio)  ,  new b2Vec2(295.5/ptm_ratio, 246/ptm_ratio)  ] ,
                                                [   new b2Vec2(498.5/ptm_ratio, 30/ptm_ratio)  ,  new b2Vec2(492.5/ptm_ratio, 20/ptm_ratio)  ,  new b2Vec2(593/ptm_ratio, 47.5/ptm_ratio)  ,  new b2Vec2(525/ptm_ratio, 46.5/ptm_ratio)  ,  new b2Vec2(509/ptm_ratio, 41.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(511/ptm_ratio, 92.5/ptm_ratio)  ,  new b2Vec2(467/ptm_ratio, 107.5/ptm_ratio)  ,  new b2Vec2(487/ptm_ratio, 94.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(554/ptm_ratio, 77.5/ptm_ratio)  ,  new b2Vec2(511/ptm_ratio, 92.5/ptm_ratio)  ,  new b2Vec2(531/ptm_ratio, 79.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(374/ptm_ratio, 349.5/ptm_ratio)  ,  new b2Vec2(298.5/ptm_ratio, 271/ptm_ratio)  ,  new b2Vec2(422/ptm_ratio, 358.5/ptm_ratio)  ,  new b2Vec2(400/ptm_ratio, 360.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(486.5/ptm_ratio, 565/ptm_ratio)  ,  new b2Vec2(518/ptm_ratio, 528.5/ptm_ratio)  ,  new b2Vec2(488.5/ptm_ratio, 597/ptm_ratio)  ,  new b2Vec2(483.5/ptm_ratio, 585/ptm_ratio)  ] ,
                                                [   new b2Vec2(467/ptm_ratio, 107.5/ptm_ratio)  ,  new b2Vec2(432/ptm_ratio, 120.5/ptm_ratio)  ,  new b2Vec2(439.5/ptm_ratio, 112/ptm_ratio)  ] ,
                                                [   new b2Vec2(298.5/ptm_ratio, 271/ptm_ratio)  ,  new b2Vec2(374/ptm_ratio, 349.5/ptm_ratio)  ,  new b2Vec2(362/ptm_ratio, 350.5/ptm_ratio)  ,  new b2Vec2(319.5/ptm_ratio, 314/ptm_ratio)  ] ,
                                                [   new b2Vec2(388/ptm_ratio, 135.5/ptm_ratio)  ,  new b2Vec2(318.5/ptm_ratio, 181/ptm_ratio)  ,  new b2Vec2(320.5/ptm_ratio, 169/ptm_ratio)  ,  new b2Vec2(361/ptm_ratio, 139.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(460/ptm_ratio, 365.5/ptm_ratio)  ,  new b2Vec2(298.5/ptm_ratio, 271/ptm_ratio)  ,  new b2Vec2(510/ptm_ratio, 375.5/ptm_ratio)  ,  new b2Vec2(494/ptm_ratio, 378.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(510/ptm_ratio, 375.5/ptm_ratio)  ,  new b2Vec2(298.5/ptm_ratio, 271/ptm_ratio)  ,  new b2Vec2(303/ptm_ratio, 269.5/ptm_ratio)  ,  new b2Vec2(559/ptm_ratio, 385.5/ptm_ratio)  ,  new b2Vec2(532/ptm_ratio, 384.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(524.5/ptm_ratio, 426/ptm_ratio)  ,  new b2Vec2(546/ptm_ratio, 404.5/ptm_ratio)  ,  new b2Vec2(518/ptm_ratio, 528.5/ptm_ratio)  ,  new b2Vec2(508.5/ptm_ratio, 503/ptm_ratio)  ,  new b2Vec2(507.5/ptm_ratio, 495/ptm_ratio)  ,  new b2Vec2(507.5/ptm_ratio, 467/ptm_ratio)  ,  new b2Vec2(509.5/ptm_ratio, 459/ptm_ratio)  ,  new b2Vec2(519/ptm_ratio, 432.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(798/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(597.5/ptm_ratio, 61/ptm_ratio)  ,  new b2Vec2(593/ptm_ratio, 47.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(559/ptm_ratio, 385.5/ptm_ratio)  ,  new b2Vec2(518/ptm_ratio, 528.5/ptm_ratio)  ,  new b2Vec2(546/ptm_ratio, 404.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(589/ptm_ratio, 69.5/ptm_ratio)  ,  new b2Vec2(511/ptm_ratio, 92.5/ptm_ratio)  ,  new b2Vec2(554/ptm_ratio, 77.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(403/ptm_ratio, 124.5/ptm_ratio)  ,  new b2Vec2(404/ptm_ratio, 124.5/ptm_ratio)  ,  new b2Vec2(559/ptm_ratio, 385.5/ptm_ratio)  ,  new b2Vec2(303/ptm_ratio, 269.5/ptm_ratio)  ,  new b2Vec2(388/ptm_ratio, 135.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(798/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(559/ptm_ratio, 385.5/ptm_ratio)  ,  new b2Vec2(589/ptm_ratio, 69.5/ptm_ratio)  ,  new b2Vec2(597.5/ptm_ratio, 61/ptm_ratio)  ] ,
                                                [   new b2Vec2(589/ptm_ratio, 69.5/ptm_ratio)  ,  new b2Vec2(559/ptm_ratio, 385.5/ptm_ratio)  ,  new b2Vec2(432/ptm_ratio, 120.5/ptm_ratio)  ,  new b2Vec2(511/ptm_ratio, 92.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(559/ptm_ratio, 385.5/ptm_ratio)  ,  new b2Vec2(798/ptm_ratio, -0.5/ptm_ratio)  ,  new b2Vec2(518/ptm_ratio, 528.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(559/ptm_ratio, 385.5/ptm_ratio)  ,  new b2Vec2(404/ptm_ratio, 124.5/ptm_ratio)  ,  new b2Vec2(432/ptm_ratio, 120.5/ptm_ratio)  ]
											]

										]

									];

		}
	}
}
