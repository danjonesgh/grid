//
//  tile.m
//  djnewgame
//
//  Created by Dan Jones on 3/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "TileCross.h"



@implementation TileCross

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
    
    self.connectionUp = YES;
    self.connectionRight = YES;
    self.connectionDown = YES;
    self.connectionLeft = YES;
    if(!_tileSprite) return [CCSprite spriteWithFile:@"cross.png"];
    else return _tileSprite;
}

+ (id)createTile
{
    return [[[self class] alloc] init];
}

- (void)turn
{
    self.connectionUp = YES;
    self.connectionRight = YES;
    self.connectionDown = YES;
    self.connectionLeft = YES;
  //  NSLog(@"cross turn");
}


- (BOOL)foundMatchIn:(NSMutableArray *)array atIndex:(int)index
{
    BOOL found = NO;
    BaseTile *tile1;
    BaseTile *tile2;
    BaseTile *tile3;
    BaseTile *tile4;
    
    switch (self.currentOrientation)
    {
        case up:
        case down:
        case right:
        case left:
            tile1 = [array objectAtIndex:index+5];
            tile2 = [array objectAtIndex:index-5];
            tile3 = [array objectAtIndex:index+1];
            tile4 = [array objectAtIndex:index-1];
            if(tile1.connectionDown && tile2.connectionUp && tile3.connectionLeft && tile4.connectionRight)
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






