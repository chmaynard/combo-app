//
//  ComboDeck.m
//  Combo
//
//  Created by Craig H Maynard on 11/24/13.
//  Copyright © 2016 Craig H Maynard. All rights reserved.
//

#import "ComboDeck.h"
#import "ComboCard.h"

@interface ComboDeck ()
@property (nonatomic, strong) NSMutableArray *cards;
@end

@implementation ComboDeck

- (instancetype)init
{
    self = [super init];

    if (self) {

        NSMutableArray *cardDictArray = [NSMutableArray array];
        for (int rank = 1; rank <= [ComboCard maxRank]; rank++) {
            for (NSString* shape in [ComboCard validShapes]) {
                for (NSString* color in [ComboCard validColors]) {
                    for (NSString* shading in [ComboCard validShadings]) {
                        NSDictionary *dict = @{ @"rank":[NSNumber numberWithInteger:rank], @"shape":shape, @"color":color, @"shading":shading };
                        [self addCard:[[ComboCard alloc] initWithDictionary:dict]];
                        [cardDictArray addObject:dict];
                    }
                }
            }
        }

        [[NSUserDefaults standardUserDefaults] setObject:cardDictArray forKey:@"ComboDeck"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    return self;
}

- (ComboCard *)cardAtIndex:(NSUInteger)index
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

- (void)addCard:(ComboCard *)card atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    }
    else {
        [self.cards addObject:card];
    }
}

- (void)addCard:(ComboCard *)card
{
    [self addCard:card atTop:NO];
}

- (ComboCard *)drawRandomCard
{
    ComboCard *randomCard = nil;

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
