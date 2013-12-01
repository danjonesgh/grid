//
//  baseTile.m
//  djnewgame
//
//  Created by Dan Jones on 4/3/13.
//
//

#import "BaseTile.h"

@implementation BaseTile

@synthesize tileSprite = _tileSprite;
@synthesize connectionDown = _connectionDown;
@synthesize connectionLeft = _connectionLeft;
@synthesize connectionRight = _connectionRight;
@synthesize connectionUp = _connectionUp;
@synthesize currentOrientation = _currentOrientation;
@synthesize rowNum = _rowNum;
@synthesize columnNum = _columnNum;
@synthesize isBottomTile = _isBottomTile;
@synthesize isTopTile = _isTopTile;
@synthesize isLeftEdgeTile = _isLeftEdgeTile;
@synthesize isRightEdgeTile = _isRightEdgeTile;
@synthesize index = _index;

- (id)init
{
    self.connectionLeft = NO;
    self.connectionDown = NO;
    self.connectionRight = NO;
    self.connectionUp = NO;
    return self;
}


- (BOOL)isBottomTile
{
    if(self.rowNum == 0)
        return YES;
    return NO;
}

- (BOOL)isTopTile
{
    if(self.rowNum == 6)
        return YES;
    return NO;
}

- (void)setTileSprite:(CCSprite *)tileSprite
{
    if(!_tileSprite) _tileSprite = tileSprite;
}

- (CCSprite *)tileSprite
{
    if(!_tileSprite) return [CCSprite spriteWithFile:@"angle.png"];
    else return _tileSprite;
}

+ (id)createTile
{
    return [[[self class] alloc] init];
}

- (void)turn
{
   // NSLog(@"base turn");
}

- (void)printLayer
{
    NSLog(@"printlayer");
}

- (BOOL)foundMatchIn:(NSMutableArray *)array atIndex:(int)index
{
    return YES;
}

@end
