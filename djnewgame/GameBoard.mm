//
//  GameBoard.m
//  djnewgame
//
//  Created by Dan Jones on 4/30/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameBoard.h"
#import "BaseTile.h"
#import "TileCross.h"
#import "TileAngle.h"
#import "TileStraight.h"

#define NUM_ROWS 7
#define NUM_COLUMNS 5

#define BOTTOM_ROW 0
#define TOP_ROW 6

@interface GameBoard()

@property (nonatomic, retain) NSMutableArray *allGameTiles;
@property (nonatomic, retain) NSMutableArray *availableSpots;

@end

@implementation GameBoard

@synthesize allGameTiles = _allGameTiles;
@synthesize availableSpotsForDots = _availableSpotsForDots;
@synthesize availableSpots = _availableSpots;
@synthesize dotsOnBoard = _dotsOnBoard;

- (NSMutableArray *)allGameTiles
{
    if(_allGameTiles == nil) _allGameTiles = [[NSMutableArray alloc] init];
    return _allGameTiles;
}
/*
- (NSMutableArray *)availableSpots
{
    if(_availableSpots == nil) _availableSpots = [[NSMutableArray alloc] init];
    return _availableSpots;
}

- (void)setAvailableSpots:(NSMutableArray *)availableSpots
{
    _availableSpots = availableSpots;
}
*/

- (void)setAvailableSpots:(NSMutableArray *)available
{
    _availableSpots = available;
}

- (NSMutableArray *)availableSpots
{
    if(!_availableSpots) _availableSpots = [[NSMutableArray alloc] init];
    return _availableSpots;
}

- (NSMutableArray *)availableSpotsForDots
{
    if(!_availableSpotsForDots) _availableSpotsForDots = [[NSMutableArray alloc] init];
    for(BaseTile *tile in self.allGameTiles)
    {
        if(tile.rowNum == TOP_ROW && tile.connectionUp)
        {
            tile.isTopTile = YES;
            [self.availableSpots addObject:tile];
        }
        if(tile.rowNum == BOTTOM_ROW && tile.connectionDown)
        {
            tile.isBottomTile = YES;
            [self.availableSpots addObject:tile];
        }
    }
    return self.availableSpots;
}

- (BOOL)isCornerTileWithRow:(int)row andColumn:(int)column
{
    if(row == 0 || row == NUM_ROWS - 1)
    {
        if(column == 0 || column == NUM_COLUMNS - 1)
        {
            return TRUE;
        }
    }
    return FALSE;
}

- (NSMutableArray *)initializeBoardWithLayer:(CCLayerColor *)layer
{
    BaseTile *tileObj;
    CCSprite *tileSprite;
    int index = 0;
    
    for(int j = 0; j < NUM_ROWS; j++)
    {
        for(int i = 0; i < NUM_COLUMNS; i++)
        {
            //tileOrientation _orientation;
            int rand = 0;
            //if( (i == NUM_COLUMNS - 1  && (j == 0 || j == NUM_ROWS))
            //   || (i == 0 && (j == 0 || j == NUM_ROWS)))
            if([self isCornerTileWithRow:j andColumn:i])
            {
                rand = 1;
            }
            else
            {
                rand = arc4random() % 3;
            }
            
            if(rand == 2)
                tileObj = [TileCross createTile];
            else if(rand == 1)
                tileObj = [TileAngle createTile];
            else
                tileObj = [TileStraight createTile];
            
            tileObj.currentOrientation = left;
            tileSprite = tileObj.tileSprite;
            
            // starting pos - 44x, 85y
            // each tile 50 wide, 8 gap in between horizontally
            // 5 gap vertically
            tileSprite.position = ccp(44 + (i * 58), 85 + (j * 55));
            tileObj.position = ccp(44 + (i * 58), 85 + (j * 55));
            tileObj.tileSprite = tileSprite;
            tileObj.rowNum = j;
            tileObj.columnNum = i;
            tileObj.index = index;
            
            index++;
            [layer addChild:tileSprite];
            
            [self.allGameTiles addObject:tileObj];
        }
    }
    return self.allGameTiles;
}

+ (id)createBoard
{
    return [[[[self class] alloc] init] autorelease];
}

- (void)dealloc
{
    _allGameTiles = nil;
    [_allGameTiles release];
    
    _dotsOnBoard = nil;
    [_dotsOnBoard release];
    
    _availableSpots = nil;
    [_availableSpots release];
    [super dealloc];
}

@end
