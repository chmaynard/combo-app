//
//  Deck.h
//  Combo
//
//  Created by Craig Maynard on 11/16/13.
//  Copyright © 2016 Craig Maynard. All rights reserved.
//

@class Card;

@interface Deck : NSObject

@property (nonatomic, strong) NSArray *cardDeck;

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;
- (NSUInteger)cardCount;
- (Card *)cardAtIndex:(NSUInteger)index;

@end
