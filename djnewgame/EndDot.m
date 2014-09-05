//
//  EndDot.m
//  djnewgame
//
//  Created by Dan Jones on 12/9/13.
//
//

#import "EndDot.h"

@implementation EndDot

+ (CCSprite *)createDotSprite
{
    return [CCSprite spriteWithFile:@"red-dot3.png"];
}

- (CGPoint)createStartPositionFrom:(NSMutableArray *)spots makeOnTop:(BOOL)topStatus
{
    if(spots.count >= 1)
    {
        int rand = arc4random() % spots.count;
        int placeForRandDot = [[spots objectAtIndex:rand] columnNum];
        
        self.nextTileInPath = [spots objectAtIndex:rand];
        self.firstTile = YES;
        
        
        

        if(topStatus)
        {
            self.isOnTop = NO;
            self.startPosition = ccp(44 + (placeForRandDot * 58), 60);
            //self.startPosition = bottom;
            self.currentDirection = north;
        }
        else
        {
            self.isOnTop = YES;
            self.startPosition = ccp(44 + (placeForRandDot * 58), 460);
            //self.startPosition = top;
            self.currentDirection = south;
        }
        
    }
    
    return self.startPosition;\
}
@end
