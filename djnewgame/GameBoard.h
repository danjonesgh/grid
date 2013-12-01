//
//  GameBoard.h
//  djnewgame
//
//  Created by Dan Jones on 4/30/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameBoard : CCNode {
    
}

@property (nonatomic, readonly) NSMutableArray *availableSpotsForDots;
@property (nonatomic, retain) NSMutableArray *dotsOnBoard;

- (NSMutableArray *)initializeBoardWithLayer:(CCLayerColor *)layer;
+ (id)createBoard;


@end
