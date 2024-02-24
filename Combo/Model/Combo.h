//
//  Combo.h
//  Combo
//
//  Created by Craig H Maynard on 11/16/13.
//  Copyright (c) 2016 Craig H Maynard. All rights reserved.
//

@class ComboCard, ComboDeck;

@protocol ComboProtocol <NSObject>
- (void) gameDidFinish;
@end

@interface Combo : NSObject

@property (nonatomic, weak) id<ComboProtocol>delegate;

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count usingCardDeck:(ComboDeck *)deck;

- (BOOL)chooseCardAtIndex:(NSUInteger)index;
- (ComboCard *)cardAtIndex:(NSUInteger)index;

- (CGFloat)gameProgress;

@end
