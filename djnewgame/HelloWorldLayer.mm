//
//  HelloWorldLayer.mm
//  djnewgame
//
//  Created by Dan Jones on 3/2/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "TileCross.h"
#import "TileAngle.h"
#import "TileStraight.h"
#import "BaseTile.h"
#import "Dot.h"
#import "GameBoard.h"

//Pixel to metres ratio. Box2D uses metres as the unit for measurement.
//This ratio defines how many pixels correspond to 1 Box2D "metre"
//Box2D is optimized for objects of 1x1 metre therefore it makes sense
//to define the ratio so that your most common object type is 1x1 metre.
#define PTM_RATIO 32

#define NUM_ROWS 7
#define NUM_COLUMNS 5


// enums that will be used as tags
enum {
	kTagTileMap = 1,
	kTagBatchNode = 1,
	kTagAnimation1 = 1,
};

@interface HelloWorldLayer()

//@property (retain, nonatomic) NSMutableArray *allGameTiles;

@end


// HelloWorldLayer implementation
@implementation HelloWorldLayer

//@synthesize allGameTiles = _allGameTiles;
@synthesize startTile = _startTile;
@synthesize endTile = _endTile;

- (HelloWorldLayer *)mainLayer
{
    return self;
}

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
   
    
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super initWithColor:ccc4(255, 255, 255, 255)])) {
		
        [self addChild:[CCLayerColor layerWithColor:ccc4(0, 0, 255, 255)]];
		// enable touches
		self.isTouchEnabled = YES;
		
		// enable accelerometer
		self.isAccelerometerEnabled = YES;
		
		CGSize screenSize = [CCDirector sharedDirector].winSize;
		CCLOG(@"Screen width %0.2f screen height %0.2f",screenSize.width,screenSize.height);
		
		// Define the gravity vector.
		b2Vec2 gravity;
		//gravity.Set(0.0f, -10.0f);
		gravity.Set(0.0f, 0.0f);
        
		// Do we want to let bodies sleep?
		// This will speed up the physics simulation
		bool doSleep = true;
		
		// Construct a world object, which will hold and simulate the rigid bodies.
		world = new b2World(gravity, doSleep);
		
		world->SetContinuousPhysics(true);
		
		// Debug Draw functions
		m_debugDraw = new GLESDebugDraw( PTM_RATIO );
		world->SetDebugDraw(m_debugDraw);
		
		uint32 flags = 0;
		flags += b2DebugDraw::e_shapeBit;
//		flags += b2DebugDraw::e_jointBit;
//		flags += b2DebugDraw::e_aabbBit;
//		flags += b2DebugDraw::e_pairBit;
//		flags += b2DebugDraw::e_centerOfMassBit;
		m_debugDraw->SetFlags(flags);		
		
		
		// Define the ground body.
		b2BodyDef groundBodyDef;
		groundBodyDef.position.Set(0, 0); // bottom-left corner
		
		// Call the body factory which allocates memory for the ground body
		// from a pool and creates the ground box shape (also from a pool).
		// The body is also added to the world.
		b2Body* groundBody = world->CreateBody(&groundBodyDef);
		
		// Define the ground box shape.
		b2PolygonShape groundBox;		
		
		// bottom
		groundBox.SetAsEdge(b2Vec2(0,0), b2Vec2(screenSize.width/PTM_RATIO,0));
		groundBody->CreateFixture(&groundBox,0);
		
		// top
		groundBox.SetAsEdge(b2Vec2(0,screenSize.height/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO,screenSize.height/PTM_RATIO));
		groundBody->CreateFixture(&groundBox,0);
		
		// left
		groundBox.SetAsEdge(b2Vec2(0,screenSize.height/PTM_RATIO), b2Vec2(0,0));
		groundBody->CreateFixture(&groundBox,0);
		
		// right
		groundBox.SetAsEdge(b2Vec2(screenSize.width/PTM_RATIO,screenSize.height/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO,0));
		groundBody->CreateFixture(&groundBox,0);
		
        
        
        // dan start
        
		rotating = false;
        
        allGameTiles = [[NSMutableArray alloc] init];
        availableDotSpots = [[NSMutableArray alloc] init];
        _startTile = [[BaseTile alloc] init];
        _endTile = [[BaseTile alloc] init];
        
        GameBoard *board = [GameBoard createBoard];
        allGameTiles = [board initializeBoardWithLayer:self];
        availableDotSpots = [board availableSpotsForDots];
        
        greenDot = [Dot createDot];
        //CCSprite *greenSprite = [greenDot createDotSprite];
        greenDot.dotSprite = [Dot createDotSprite];
        greenDot.dotSprite.position = [greenDot createStartPositionFrom:availableDotSpots];
        greenDot.gameTiles = allGameTiles;
        
        [self addChild:greenDot.dotSprite];
        if(greenDot.canMoveOverTile)
        {
            [greenDot moveOverTile];
            // green dot move over tile
        }
        
        // dan end
        
        
        [self schedule: @selector(tick:)];
	}
	return self;
}



-(void) draw
{
	// Default GL states: GL_TEXTURE_2D, GL_VERTEX_ARRAY, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	// Needed states:  GL_VERTEX_ARRAY, 
	// Unneeded states: GL_TEXTURE_2D, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	glDisable(GL_TEXTURE_2D);
	glDisableClientState(GL_COLOR_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	
	world->DrawDebugData();
	
    
    glEnable(GL_LINE_SMOOTH);
    glColor4ub(255, 0, 255, 255);
    glLineWidth(2);
   // CGPoint vertices2[] = { ccp(79,299), ccp(134,299), ccp(134,229), ccp(79,229) };
   // GLESDebugDraw *draw = new GLESDebugDraw();
    //b2Vec2 *vec = new b2Vec2(55,55);
   // draw->DrawPolygon(vec, 4, b2Color(23, 222, 14));
   // drawPoly(vertices2, 4, YES);
    
    
	// restore default GL states
	glEnable(GL_TEXTURE_2D);
	glEnableClientState(GL_COLOR_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);

}

-(void) addNewSpriteWithCoords:(CGPoint)p
{
	CCLOG(@"Add sprite %0.2f x %02.f",p.x,p.y);
	CCSpriteBatchNode *batch = (CCSpriteBatchNode*) [self getChildByTag:kTagBatchNode];
	
	//We have a 64x64 sprite sheet with 4 different 32x32 images.  The following code is
	//just randomly picking one of the images
	int idx = (CCRANDOM_0_1() > .5 ? 0:1);
	int idy = (CCRANDOM_0_1() > .5 ? 0:1);
	CCSprite *sprite = [CCSprite spriteWithBatchNode:batch rect:CGRectMake(32 * idx,32 * idy,32,32)];
	[batch addChild:sprite];
	
	sprite.position = ccp( p.x, p.y);
	
	// Define the dynamic body.
	//Set up a 1m squared box in the physics world
	b2BodyDef bodyDef;
	bodyDef.type = b2_dynamicBody;

	bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
	bodyDef.userData = sprite;
	b2Body *body = world->CreateBody(&bodyDef);
	
	// Define another box shape for our dynamic body.
	b2PolygonShape dynamicBox;
	dynamicBox.SetAsBox(.5f, .5f);//These are mid points for our 1m box
	
	// Define the dynamic body fixture.
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &dynamicBox;	
	fixtureDef.density = 1.0f;
	fixtureDef.friction = 0.3f;
	body->CreateFixture(&fixtureDef);
}



-(void) tick: (ccTime) dt
{
	//It is recommended that a fixed time step is used with Box2D for stability
	//of the simulation, however, we are using a variable time step here.
	//You need to make an informed choice, the following URL is useful
	//http://gafferongames.com/game-physics/fix-your-timestep/
	
	int32 velocityIterations = 8;
	int32 positionIterations = 1;
	
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
	world->Step(dt, velocityIterations, positionIterations);

	
	//Iterate over the bodies in the physics world
	for (b2Body* b = world->GetBodyList(); b; b = b->GetNext())
	{
		if (b->GetUserData() != NULL) {
			//Synchronize the AtlasSprites position and rotation with the corresponding body
			CCSprite *myActor = (CCSprite*)b->GetUserData();
			myActor.position = CGPointMake( b->GetPosition().x * PTM_RATIO, b->GetPosition().y * PTM_RATIO);
			myActor.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
		}	
	}
    
    //NSLog(@"in updated");
    //[greenDot printSomething];
    //if(!greenDot.isMovingOverATile)
    //{
        //if(greenDot.canMoveOverTile)
        //    [greenDot moveOverTile];
    //}
}


- (void) resetBool
{
    rotating = false;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];

    for(BaseTile *tile in allGameTiles)
    {
        double time = 0.4;
        id delay = [CCDelayTime actionWithDuration: time];
        id callbackAction = [CCCallFunc actionWithTarget: self selector: @selector(resetBool)];
        id sequence = [CCSequence actions: delay, callbackAction, nil];
       
        if(CGRectContainsPoint(tile.tileSprite.boundingBox, location))
        {
            if(!rotating)
            {
                self.startTile = tile;
                [tile.tileSprite runAction:[CCRotateBy actionWithDuration:0.4 angle:90]];
                [tile turn];
                [self runAction:sequence];
                rotating = true;
              //  NSLog(@" touch began %@ in location %f %f", tile, location.x, location.y);
            }
        }
    }
    
    //if(greenDot.canMoveOverTile)
    //    [greenDot moveOverTile];
    
}




- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    //CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    CGSize windowSize = [CCDirector sharedDirector].winSize;
    b2Vec2 dragTouchLocation;
    // NSLog(@"win %f %f", windowSize.width, location.x);
   // NSLog(@"moved %f %f", location.x, location.y);
    if(location.x < (windowSize.width - 32) && location.x > 32)
    {
        dragTouchLocation = b2Vec2(location.x/PTM_RATIO, location.y/PTM_RATIO);
    }

    //   CGPoint boundPoint = [self boundLayerPos:ccp(dragTouchLocation.x, dragTouchLocation.y)];
    //   mouseJoint->SetTarget(b2Vec2(boundPoint.x, boundPoint.y));
   // mouseJoint->SetTarget(dragTouchLocation);
}




- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];

    for(BaseTile *tile in allGameTiles)
    {
        if(CGRectContainsPoint(tile.tileSprite.boundingBox, location))
        {
            self.endTile = tile;
        }
    }
    if(self.endTile == self.startTile)
    {
       // NSLog(@"sameeeeeeeeeeee");
    }
    else
    {
     //   NSLog(@"differenttttttttt");
        [self swapTileLocation];
    }
}

- (void)swapTileLocation
{
   // NSLog(@"swappppppppp");
    CGPoint startPos = self.startTile.position;
    CGPoint spriteStartPos = self.startTile.tileSprite.position;
    //[CCMoveTo a]
   // [ccm]
    self.startTile.position = self.endTile.position;
    self.startTile.tileSprite.position = self.endTile.tileSprite.position;
    self.endTile.position = startPos;
    self.endTile.tileSprite.position = spriteStartPos;
}

- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{	
	static float prevX=0, prevY=0;
	
	//#define kFilterFactor 0.05f
#define kFilterFactor 1.0f	// don't use filter. the code is here just as an example
	
	float accelX = (float) acceleration.x * kFilterFactor + (1- kFilterFactor)*prevX;
	float accelY = (float) acceleration.y * kFilterFactor + (1- kFilterFactor)*prevY;
	
	prevX = accelX;
	prevY = accelY;
	
	// accelerometer values are in "Portrait" mode. Change them to Landscape left
	// multiply the gravity by 10
	b2Vec2 gravity( -accelY * 10, accelX * 10);
	
	world->SetGravity( gravity );
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	delete world;
	world = NULL;
	allGameTiles = nil;
    availableDotSpots = nil;
    [allGameTiles release];
    [availableDotSpots release];
	delete m_debugDraw;
    
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
