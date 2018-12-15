//
//  ComboCard.swift
//  Combo
//
//  Created by Craig Maynard on 11/29/17.
//  Copyright © 2017 Craig Maynard. All rights reserved.
//

import UIKit

//@property (nonatomic, getter = isNew) BOOL new;
//@property (nonatomic, getter = isChosen) BOOL chosen;
//@property (nonatomic, getter = isMatched) BOOL matched;
//@property (nonatomic) BOOL canMatch;
//
//- (id)initWithDictionary:(NSDictionary *)dictionary;
//+ (BOOL)match:(NSArray *)cards;
//
//@property (nonatomic, assign) NSUInteger rank;
//@property (strong, nonatomic) NSString *shape;
//@property (strong, nonatomic) NSString *color;
//@property (strong, nonatomic) NSString *shading;
//
//+ (NSUInteger) maxRank;
//+ (NSArray *)validShapes;
//+ (NSArray *)validColors;
//+ (NSArray *)validShadings;

class _ComboCard: NSObject, ComboCardProtocol {
    var rank : Int?
    var color, shading, shape : String?
}

protocol ComboCardProtocol {
    var rank : Int? { get set }
    var color : String? { get set }
    var shading : String? { get set }
    var shape : String? { get set }
}
