//
//  Combo.m
//  Combo
//
//  Created by Craig H Maynard on 11/16/13.
//  Copyright (c) 2016 Craig H Maynard. All rights reserved.
//

#import "Combo.h"
#import "ComboCard.h"
#import "Deck.h"

@interface Combo ()

@property (nonatomic, strong) Deck *deck;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, strong) NSMutableArray *cardsInPlay;
@property (nonatomic, strong) NSMutableArray *chosenCards;
@property (nonatomic, readwrite) NSUInteger cardCount;
@property (nonatomic, readwrite) CGFloat cardsToMatch;

@end

@implementation Combo

- (instancetype)initWithCardCount:(NSUInteger)count usingCardDeck:(Deck *)deck
{
    self = [super init];

    if (self) {
        _cardCount = count;
        _deck = deck;

        [self dealCards];
        self.cardsToMatch = [self.cards count];
    }

    return self;
}

- (void)dealCards
{
    do {
        if (![self.cards count]) {
            return;
        }
        for (int i = 0; i < self.cardCount; i++) {
            Card *card = [self.cards firstObject];
            if (card) {
                self.cardsInPlay[i] = card;
                [self.cards removeObjectAtIndex:0];
            }
        }
    } while (![self containsSet]);
}

- (void)replaceCards
{
    do {
        if (![self.cards count]) {
            return;
        }
        for (int i = 0; i < self.cardCount; i++) {
            ComboCard *card = self.cardsInPlay[i];
            if (card.isNew || card.isMatched) {
                ComboCard *newCard = [self.cards firstObject];
                if (newCard) {
                    newCard.new = YES;
                    self.cardsInPlay[i] = newCard;
                    [self.cards removeObjectAtIndex:0];
                }
            }
        }
    } while (![self containsSet]);

    return;
}

- (CGFloat)gameProgress
{
    CGFloat cardsRemaining = [self.cards count];
    CGFloat progress = (self.cardsToMatch - cardsRemaining) / self.cardsToMatch;
    return progress;
}

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];

        NSUInteger count = [self.deck cardCount];

        for (int i = 0; i < count; i++) {
            Card *card = [self.deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }
        }
    }

    return _cards;
}

- (NSMutableArray *)cardsInPlay
{
    if (!_cardsInPlay) {
        _cardsInPlay = [[NSMutableArray alloc] init];
    }
    return _cardsInPlay;
}

- (NSMutableArray *)chosenCards
{
    if (!_chosenCards) {
        _chosenCards = [[NSMutableArray alloc] init];
    }
    return _chosenCards;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return self.cardsInPlay[index];
}

- (BOOL)chooseCardAtIndex:(NSUInteger)index
{
    ComboCard *card = [self cardAtIndex:index];

    BOOL success = YES;

    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            [self.chosenCards removeObject:card];
        }
        else {
            card.chosen = YES;
            [self.chosenCards addObject:card];
            if ([self.chosenCards count] == 3) {

                // check for match
                success = [ComboCard match:self.chosenCards];
                if (success) {
                    for (ComboCard *chosenCard in self.chosenCards) {
                        chosenCard.matched = YES;
                    }
                    [self replaceCards];
                    if (![self containsSet]) {
                        // game over, man
                        [self.delegate gameDidFinish];
                    }
                }

                for (ComboCard *chosenCard in self.chosenCards) {
                    chosenCard.chosen = NO;
                }

                [self.chosenCards removeAllObjects];
            }
        }
    }
    return success;
}

- (BOOL)containsSet
{
    for (ComboCard *card in self.cardsInPlay) { card.canMatch = NO; }
    for (int i = 0; i < self.cardCount; i++) {
        for (int j = i + 1; j < self.cardCount; j++) {
            for (int k = j + 1; k < self.cardCount; k++) {
                ComboCard *card1 = self.cardsInPlay[i];
                ComboCard *card2 = self.cardsInPlay[j];
                ComboCard *card3 = self.cardsInPlay[k];
                if (card1.isMatched || card2.isMatched || card3.isMatched) continue;
                BOOL matched = [ComboCard match:@[card1, card2, card3]];
                if (matched) {
                    card1.canMatch = YES;
                    card2.canMatch = YES;
                    card3.canMatch = YES;
                    return YES;
                }
            }
        }
    }

    return NO;
}

@end
