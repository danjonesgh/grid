//
//  tileAngle.m
//  djnewgame
//
//  Created by Dan Jones on 4/3/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "TileAngle.h"
#import "TileStraight.h"
#import "TileCross.h"



@implementation TileAngle



@synthesize tileSprite = _tileSprite;
@synthesize currentOrientation = _currentOrientation;
@synthesize connectionUp = _connectionUp;
@synthesize connectionRight = _connectionRight;
@synthesize connectionDown = _connectionDown;
@synthesize connectionLeft = _connectionLeft;
@synthesize rowNum = _rowNum;

- (void)setTileSprite:(CCSprite *)tileSprite
{
    if(!_tileSprite) _tileSprite = tileSprite;
}

- (CCSprite *)tileSprite
{
    CCSprite *tile = [CCSprite spriteWithFile:@"angle.png"];
    switch (self.currentOrientation) {
        case up:
            tile.rotation = 0;
            self.connectionUp = YES;
            self.connectionRight = YES;
            self.connectionDown = NO;
            self.connectionLeft = NO;
            break;
        case right:
            tile.rotation = 90;
            self.connectionUp = NO;
            self.connectionRight = YES;
            self.connectionDown = YES;
            self.connectionLeft = NO;
            break;
        case down:
            tile.rotation = 180;
            self.connectionUp = NO;
            self.connectionRight = NO;
            self.connectionDown = NO;
            self.connectionLeft = NO;
            break;
        case left:
            tile.rotation = 270;
            self.connectionUp = YES;
            self.connectionRight = NO;
            self.connectionDown = NO;
            self.connectionLeft = YES;
            break;
            
        default:
            break;
    }

    if(!_tileSprite) return tile;
    else return _tileSprite;
}


+ (id)createTile
{
    return [[[self class] alloc] init];
}

- (void)turn
{
   // NSLog(@"row num angle %d", self.rowNum);
    switch (self.currentOrientation) {
        case up:
            self.currentOrientation = right;
            self.connectionUp = YES;
            self.connectionRight = YES;
            self.connectionDown = NO;
            self.connectionLeft = NO;
            break;
        case right:
            self.currentOrientation = down;
            self.connectionUp = NO;
            self.connectionRight = YES;
            self.connectionDown = YES;
            self.connectionLeft = NO;
            break;
        case down:
            self.currentOrientation = left;
            self.connectionUp = NO;
            self.connectionRight = NO;
            self.connectionDown = NO;
            self.connectionLeft = NO;
            break;
        case left:
            self.currentOrientation = up;
            self.connectionUp = YES;
            self.connectionRight = NO;
            self.connectionDown = NO;
            self.connectionLeft = YES;
            break;
            
        default:
            break;
    }
    
  //  NSLog(@"angle turn %u", self.currentOrientation);
}

- (BOOL)foundMatchIn:(NSMutableArray *)array atIndex:(int)index
{
    BOOL found = NO;
    BaseTile *tile1;
    BaseTile *tile2;
    
    switch (self.currentOrientation)
    {
        case up:
            tile1 = [array objectAtIndex:index+5];
            tile2 = [array objectAtIndex:index+1];
            if(tile1.connectionDown && tile2.connectionLeft)
                found = YES;
            break;
        case right:
            tile1 = [array objectAtIndex:index+1];
            tile2 = [array objectAtIndex:index-5];
            if(tile1.connectionLeft && tile2.connectionUp)
                found = YES;
            break;
        case down:
            tile1 = [array objectAtIndex:index-5];
            tile2 = [array objectAtIndex:index-1];
            if(tile1.connectionUp && tile2.connectionRight)
                found = YES;
            break;
        case left:
            tile1 = [array objectAtIndex:index+5];
            tile2 = [array objectAtIndex:index-1];
            if(tile1.connectionDown && tile2.connectionRight)
                found = YES;
            break;
            
        default:
            break;
    }
    return found;
}

- (void)printLayer
{
    NSLog(@"in angle %@", [[CCDirector sharedDirector] runningScene].children);
}

- (void)dealloc
{
    [super dealloc];
}

@end
