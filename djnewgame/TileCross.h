//
//  tile.h
//  djnewgame
//
//  Created by Dan Jones on 3/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BaseTile.h"


@interface TileCross : BaseTile

@property (nonatomic, retain) CCSprite *tileSprite;

+ (id)createTile;
- (void)turn;


@end







