//
//  ComboDeck.h
//  Combo
//
//  Created by Craig H Maynard on 11/24/13.
//  Copyright (c) 2016 Craig H Maynard. All rights reserved.
//

@class ComboCard;

@interface ComboDeck : NSObject

@property (nonatomic, strong) NSArray *cardDeck;

- (void)addCard:(ComboCard *)card atTop:(BOOL)atTop;
- (void)addCard:(ComboCard *)card;

- (ComboCard *)drawRandomCard;
- (NSUInteger)cardCount;
- (ComboCard *)cardAtIndex:(NSUInteger)index;

@end
