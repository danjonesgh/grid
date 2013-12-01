//
//  tileAngle.h
//  djnewgame
//
//  Created by Dan Jones on 4/3/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BaseTile.h"

@interface TileAngle : BaseTile

@property (nonatomic, retain) CCSprite *tileSprite;


+ (id)createTile;
- (void)turn;

@end
