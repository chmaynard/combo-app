//
//  ComboCard.h
//  Combo
//
//  Created by Craig H Maynard on 11/24/13.
//  Copyright © 2016 Craig H Maynard. All rights reserved.
//

@interface ComboCard : NSObject

@property (nonatomic, getter = isNew) BOOL new;
@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;
@property (nonatomic) BOOL canMatch;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (BOOL)match:(NSArray *)cards;

@property (nonatomic, assign) NSUInteger rank;
@property (strong, nonatomic) NSString *shape;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *shading;

+ (NSUInteger) maxRank;
+ (NSArray *)validShapes;
+ (NSArray *)validColors;
+ (NSArray *)validShadings;

@end
