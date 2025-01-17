//
//  Deck.m
//  Combo
//
//  Created by Craig Maynard on 11/16/13.
//  Copyright © 2016 Craig Maynard. All rights reserved.
//

#import "Deck.h"
#import "Card.h"

@interface Deck ()
@property (nonatomic, strong) NSMutableArray *cards;
@end

@implementation Deck

- (Card *)cardAtIndex:(NSUInteger)index
{
    return self.cards[index];
}

- (NSUInteger)cardCount
{
    return [self.cards count];
}

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }

    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    }
    else {
        [self.cards addObject:card];
    }
}

- (void)addCard:(Card *)card
{
    [self addCard:card atTop:NO];
}

- (Card *)drawRandomCard
{
    Card *randomCard = nil;

    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }

    return randomCard;
}

- (NSArray *)cardDeck
{
    NSMutableArray *array = [NSMutableArray array];

    for (id card in self.cards) {
        NSUInteger index = [self.cards indexOfObject:card];
        array[index] = [card dictionary];
    }

    return array;
}

- (void)setCardDeck:(NSArray *)cardDeck
{
    
}

@end
