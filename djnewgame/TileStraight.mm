//
//  tileStraight.m
//  djnewgame
//
//  Created by Dan Jones on 4/3/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "TileStraight.h"

#define TILE_HALF_SIZE 25

@implementation TileStraight

@synthesize tileSprite = _tileSprite;
@synthesize connectionDown = _connectionDown;
@synthesize connectionLeft = _connectionLeft;
@synthesize connectionRight = _connectionRight;
@synthesize connectionUp = _connectionUp;


- (void)setTileSprite:(CCSprite *)tileSprite
{
    if(!_tileSprite) _tileSprite = tileSprite;
}

- (CCSprite *)tileSprite
{
    CCSprite *tile = [CCSprite spriteWithFile:@"straight.png"];
    switch (self.currentOrientation) {
        case up:
            tile.rotation = 0;
            self.connectionUp = YES;
            self.connectionRight = NO;
            self.connectionDown = YES;
            self.connectionLeft = NO;
            break;
        case right:
            tile.rotation = 90;
            self.connectionUp = NO;
            self.connectionRight = YES;
            self.connectionDown = NO;
            self.connectionLeft = YES;
            break;
        case down:
            tile.rotation = 0;
            self.connectionUp = YES;
            self.connectionRight = NO;
            self.connectionDown = YES;
            self.connectionLeft = NO;
            break;
        case left:
            tile.rotation = 90;
            self.connectionUp = NO;
            self.connectionRight = YES;
            self.connectionDown = NO;
            self.connectionLeft = YES;
            break;
            
        default:
            break;
    }
    
    if(!_tileSprite) { return tile; }
    else return _tileSprite;
}

+ (id)createTile
{
    return [[[self class] alloc] init];
}

- (void)turn
{
    switch (self.currentOrientation) {
        case up:
            self.currentOrientation = right;
            self.connectionUp = NO;
            self.connectionRight = YES;
            self.connectionDown = NO;
            self.connectionLeft = YES;
            break;
        case right:
            self.currentOrientation = down;
            self.connectionUp = YES;
            self.connectionRight = NO;
            self.connectionDown = YES;
            self.connectionLeft = NO;
            break;
        case down:
            self.currentOrientation = left;
            self.connectionUp = NO;
            self.connectionRight = YES;
            self.connectionDown = NO;
            self.connectionLeft = YES;
            break;
        case left:
            self.currentOrientation = up;
            self.connectionUp = YES;
            self.connectionRight = NO;
            self.connectionDown = YES;
            self.connectionLeft = NO;
            break;
            
        default:
            break;
    }

 //   NSLog(@"straight turn");
}


- (BOOL)foundMatchIn:(NSMutableArray *)array atIndex:(int)index
{
    BOOL found = NO;
    BaseTile *tile1;
    BaseTile *tile2;
    
    switch (self.currentOrientation)
    {
        case up:
        case down:
            tile1 = [array objectAtIndex:index+5];
            tile2 = [array objectAtIndex:index-5];
            if(tile1.connectionDown && tile2.connectionUp)
                found = YES;
            break;
        case right:
        case left:
            tile1 = [array objectAtIndex:index+1];
            tile2 = [array objectAtIndex:index-1];
            if(tile1.connectionLeft && tile2.connectionRight)
                 found = YES;
            break;
            
        default:
            break;
    }
    return found;
}

- (void)dealloc
{
    [super dealloc];
}

@end
