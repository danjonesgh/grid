//
//  baseTile.h
//  djnewgame
//
//  Created by Dan Jones on 4/3/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BaseTile : CCNode

typedef enum {up, right, down, left} tileOrientation;



@property (nonatomic) tileOrientation currentOrientation;

@property (nonatomic, retain) CCSprite *tileSprite;
@property (nonatomic) BOOL connectionUp;
@property (nonatomic) BOOL connectionRight;
@property (nonatomic) BOOL connectionDown;
@property (nonatomic) BOOL connectionLeft;

@property (nonatomic) BOOL isBottomTile;
@property (nonatomic) BOOL isTopTile;
@property (nonatomic) BOOL isRightEdgeTile;
@property (nonatomic) BOOL isLeftEdgeTile;


@property (nonatomic) int rowNum;
@property (nonatomic) int columnNum;
@property (nonatomic) int index;


+ (id)createTile;
- (void)turn;
- (void)printLayer;
- (BOOL)foundMatchIn:(NSMutableArray *)array atIndex:(int)index;



@end
