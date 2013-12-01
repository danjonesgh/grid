//
//  HelloWorldLayer.h
//  djnewgame
//
//  Created by Dan Jones on 3/2/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "Dot.h"
#import "BaseTile.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayerColor
{
    bool rotating;
    CCSprite *testClickBlock;
    b2Body *bodyNew;
    b2MouseJoint *mouseJoint;
	b2World* world;
	GLESDebugDraw *m_debugDraw;
    
    NSMutableArray *allGameTiles;
    NSMutableArray *availableDotSpots;
    Dot *greenDot;
}

@property (nonatomic, retain) BaseTile *startTile;
@property (nonatomic, retain) BaseTile *endTile;
//@property til startTouch;
//@property CGPoint endTouch;
//@property (nonatomic, retain)NSMutableArray *allGameTiles;
// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
// adds a new sprite at a given coordinate
-(void) addNewSpriteWithCoords:(CGPoint)p;

//- (void)setUpTiles;

@end



