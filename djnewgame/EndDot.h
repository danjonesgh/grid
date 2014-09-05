//
//  EndDot.h
//  djnewgame
//
//  Created by Dan Jones on 12/9/13.
//
//

#import "Dot.h"

@interface EndDot : Dot


- (CGPoint)createStartPositionFrom:(NSMutableArray *)spots makeOnTop:(BOOL)topStatus;

+ (CCSprite *)createDotSprite;

@end
