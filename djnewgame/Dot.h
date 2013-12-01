//
//  Dot.h
//  djnewgame
//
//  Created by Dan Jones on 4/18/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BaseTile.h"
#import "GameBoard.h"

@interface Dot : CCNode {
    
}

enum movementDirection { north, south, east, west};


@property (nonatomic) movementDirection currentDirection;
@property (nonatomic) movementDirection directionChange;
@property (nonatomic, retain) CCSprite *dotSprite;

@property (nonatomic) CGPoint startPosition;
@property (nonatomic) CGPoint endPosition;


@property (nonatomic) BOOL canMoveOverTile; // yes
@property (nonatomic, retain) NSMutableArray *gameTiles; 
@property (nonatomic, retain) BaseTile *nextTileInPath; // yes
@property (nonatomic, retain) BaseTile *currentTileMovingOver;
@property (nonatomic, retain) BaseTile *previousTileMovedOver;


//@property (nonatomic) int moveByX, moveByY;
@property (nonatomic) CGPoint endPoint;
@property (nonatomic) BOOL oneEndPoint;
@property (nonatomic) BOOL firstTile;


+ (CCSprite *)createDotSprite;
+ (id)createDot;
- (CGPoint)createStartPositionFrom:(NSMutableArray *)spots;
- (void)moveOverTile;
- (void)findNextTileInPath;


@end
