//
//  Dot.m
//  djnewgame
//
//  Created by Dan Jones on 4/18/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Dot.h"
#import "GameBoard.h"
#import "TileAngle.h"
#import "TileCross.h"
#import "TileStraight.h"


#define TILE_HALF_SIZE 25

@implementation Dot

@synthesize dotSprite = _dotSprite;
@synthesize currentDirection = _currentDirection;
@synthesize canMoveOverTile = _canMoveOverTile;

@synthesize startPosition = _startPosition;
@synthesize endPosition = _endPosition;

@synthesize gameTiles = _gameTiles;
@synthesize currentTileMovingOver = _currentTileMovingOver;
@synthesize nextTileInPath = _nextTileInPath;
@synthesize previousTileMovedOver = _previousTileMovedOver;

@synthesize oneEndPoint = _oneEndPoint;
@synthesize directionChange;
@synthesize firstTile;
@synthesize endPoint;
@synthesize startingPoint;
@synthesize isOnTop;


+ (CCSprite *)createDotSprite
{
    return [CCSprite spriteWithFile:@"greendot-alpha.png"];
}

+ (id)createDot
{
    return [[[[self class] alloc] init] autorelease];
}



- (CGPoint)endPointOne
{
    CGPoint point;
    point = ccp(self.currentTileMovingOver.position.x, self.currentTileMovingOver.position.y);
    return point;
}

- (void)setNextTileInPath:(BaseTile *)nextTileInPath
{
    _nextTileInPath = nextTileInPath;
}


- (void)findNextTileInPath
{
    if(self.currentDirection == north)
    {
        if(self.currentTileMovingOver.index + 5 <= 34)
            self.nextTileInPath = [self.gameTiles objectAtIndex:(self.currentTileMovingOver.index + 5)];
    }
    else if(self.currentDirection == south)
    {
        if(self.currentTileMovingOver.index - 5 >= 0)
            self.nextTileInPath = [self.gameTiles objectAtIndex:(self.currentTileMovingOver.index - 5)];
    }
    else if(self.currentDirection == west)
    {
        if(self.currentTileMovingOver.columnNum != 0)
            self.nextTileInPath = [self.gameTiles objectAtIndex:(self.currentTileMovingOver.index - 1)];
    }
    else if(self.currentDirection == east)
    {
        if(self.currentTileMovingOver.columnNum != 4)
            self.nextTileInPath = [self.gameTiles objectAtIndex:(self.currentTileMovingOver.index + 1)];
    }
    
   // NSLog(@"next tile %@, %d", self.nextTileInPath, self.nextTileInPath.index);
}

- (BOOL)canMoveOverTile
{
    //NSLog(@"can move over tile current direction NSEW %u", self.currentDirection + 1);
    switch (self.currentDirection)
    {
        case north:
            if(self.nextTileInPath.connectionDown)
            {
                if([self.nextTileInPath isKindOfClass:[TileAngle class]])
                {
                    self.oneEndPoint = NO;
                    //  _
                    // |
                    if(self.nextTileInPath.connectionRight)
                    {
                        self.endPoint = ccp(self.nextTileInPath.position.x + TILE_HALF_SIZE, self.nextTileInPath.position.y);
                        self.directionChange = east;
                    }
                    //  _
                    //   |
                    else if(self.nextTileInPath.connectionLeft)
                    {
                        self.endPoint = ccp(self.nextTileInPath.position.x - TILE_HALF_SIZE, self.nextTileInPath.position.y);
                        self.directionChange = west;
                    }
                }
                else
                {
                    self.oneEndPoint = YES;
                    self.endPoint = ccp(self.nextTileInPath.position.x, self.nextTileInPath.position.y + TILE_HALF_SIZE);
                }
                return YES;
            }
            else
            {
                return NO;
            }
            break;
        case south:
            if(self.nextTileInPath.connectionUp)
            {
                if([self.nextTileInPath isKindOfClass:[TileAngle class]])
                {
                    self.oneEndPoint = NO;
                    //  |_
                    
                    if(self.nextTileInPath.connectionRight)
                    {
                        self.endPoint = ccp(self.nextTileInPath.position.x + TILE_HALF_SIZE, self.nextTileInPath.position.y);
                        self.directionChange = east;
                    }
                    
                    //  _|
                    else if(self.nextTileInPath.connectionLeft)
                    {
                        self.endPoint = ccp(self.nextTileInPath.position.x - TILE_HALF_SIZE, self.nextTileInPath.position.y);
                        self.directionChange = west;
                    }
                }
                else
                {
                    self.oneEndPoint = YES;
                    self.endPoint = ccp(self.nextTileInPath.position.x, self.nextTileInPath.position.y - TILE_HALF_SIZE);
                }
                return YES;
            }
            else
            {
                return NO;
            }
            break;
        case east:
            if(self.nextTileInPath.connectionLeft)
            {
                if([self.nextTileInPath isKindOfClass:[TileAngle class]])
                {
                    self.oneEndPoint = NO;
                    // _|
                    if(self.nextTileInPath.connectionUp)
                    {
                        self.endPoint = ccp(self.nextTileInPath.position.x, self.nextTileInPath.position.y + TILE_HALF_SIZE);
                        self.directionChange = north;
                    }
                    //  _
                    //   |
                    else if(self.nextTileInPath.connectionDown)
                    {
                        self.endPoint = ccp(self.nextTileInPath.position.x, self.nextTileInPath.position.y - TILE_HALF_SIZE);
                        self.directionChange = south;
                    }
                }
                else
                {
                    self.oneEndPoint = YES;
                    self.endPoint = ccp(self.nextTileInPath.position.x + TILE_HALF_SIZE, self.nextTileInPath.position.y);
                }
            
                return YES;
            }
            else
            {
                return NO;
            }
            break;
        case west:
            if(self.nextTileInPath.connectionRight)
            {
                if([self.nextTileInPath isKindOfClass:[TileAngle class]])
                {
                    self.oneEndPoint = NO;
                    // |_
                    if(self.nextTileInPath.connectionUp)
                    {
                        self.endPoint = ccp(self.nextTileInPath.position.x, self.nextTileInPath.position.y + TILE_HALF_SIZE);
                        self.directionChange = north;
                    }
                    //   _
                    //  |
                    else if(self.nextTileInPath.connectionDown)
                    {
                        self.endPoint = ccp(self.nextTileInPath.position.x, self.nextTileInPath.position.y - TILE_HALF_SIZE);
                        self.directionChange = south;
                    }
                }
                else
                {
                    self.oneEndPoint = YES;
                    self.endPoint = ccp(self.nextTileInPath.position.x - TILE_HALF_SIZE, self.nextTileInPath.position.y);
                }
                return YES;
            }
            else
            {
                return NO;
            }
            break;
        default:
            break;
    }
    return NO;
}




- (void)moveOverTile
{
    //CGPoint end;
    CGPoint centerPoint;
   // bool oneEndPoint = false;
    
    self.currentTileMovingOver = self.nextTileInPath;
/*
    if([self.currentTileMovingOver isKindOfClass:[TileCross class]])
        NSLog(@"cross tile");
    else if([self.currentTileMovingOver isKindOfClass:[TileAngle class]])
        NSLog(@"angle tile");
    else if([self.currentTileMovingOver isKindOfClass:[TileStraight class]])
        NSLog(@"straight tile");
    
    NSLog(@"point x %f and y %f", self.endPoint.x, self.endPoint.y);
    NSLog(@"current tile row %d column %d", self.currentTileMovingOver.rowNum + 1, self.currentTileMovingOver.columnNum + 1);
    NSLog(@"current direction NSEW %u", self.currentDirection + 1);

    NSLog(@"---------------------------------------------------------");
    */
    self.firstTile = NO;
    
    // if one move by is 0, then traveling straight
    //if(self.moveByY == 0 || self.moveByX == 0)
    if(self.oneEndPoint)
    {
        id callback = [CCCallFunc actionWithTarget:self selector:@selector(checkNextMovement)];
        id movement = [CCMoveTo actionWithDuration:2 position:self.endPoint];
   
        id sequence = [CCSequence actions:movement, callback, nil];
        [self runAction:sequence];
        [self.dotSprite runAction:sequence];
        
    }
    else
    {
        centerPoint = ccp(self.currentTileMovingOver.position.x, self.currentTileMovingOver.position.y);
        id callback = [CCCallFunc actionWithTarget:self selector:@selector(checkNextMovement)];
        
        id moveToCenter = [CCMoveTo actionWithDuration:1 position:centerPoint];
        id moveToEnd = [CCMoveTo actionWithDuration:1 position:self.endPoint];
        self.currentDirection = self.directionChange;
        id sequence = [CCSequence actions: moveToCenter, moveToEnd, callback, nil];
        
        [self runAction:sequence];
        [self.dotSprite runAction:sequence];
        
    }
    
}

- (void)checkNextMovement
{
   // NSLog(@"****");
   // NSLog(@"check move");
   // NSLog(@"*******");
    self.previousTileMovedOver = self.currentTileMovingOver;
    [self findNextTileInPath];
    
    if([self canMoveOverTile])
        [self moveOverTile];
    
}


// spots - available tiles that are facing down if bottom row
// or facing up if in top row
- (CGPoint)createStartPositionFrom:(NSMutableArray *)spots
{
    if(spots.count >= 1)
    {
        int rand = arc4random() % spots.count;
        int placeForRandDot = [[spots objectAtIndex:rand] columnNum];
        
        self.nextTileInPath = [spots objectAtIndex:rand];
        self.firstTile = YES;
        
   
        
        
        if([[spots objectAtIndex:rand] isTopTile])
        {
            self.isOnTop = YES;
            self.startPosition = ccp(44 + (placeForRandDot * 58), 460);
            //self.startPosition = top;
            self.currentDirection = south;
        }
        if([[spots objectAtIndex:rand] isBottomTile])
        {
            self.isOnTop = NO;
            self.startPosition = ccp(44 + (placeForRandDot * 58), 60);
            //self.startPosition = bottom;
            self.currentDirection = north;
        }
        
    }
    return self.startPosition;
}


- (void)dealloc
{
    _dotSprite = nil;
    [_dotSprite release];
    
    _nextTileInPath = nil;
    [_nextTileInPath release];
    
    _currentTileMovingOver = nil;
    [_currentTileMovingOver release];
    
    _previousTileMovedOver = nil;
    [_previousTileMovedOver release];
    
    [super dealloc];
}

@end
