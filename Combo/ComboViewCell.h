//
//  ComboViewCell.h
//  Combo
//
//  Created by Craig H Maynard on 12/8/13.
//  Copyright (c) 2016 Craig H Maynard. All rights reserved.
//

@interface ComboViewCell : UICollectionViewCell

@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, assign) NSUInteger rank;
@property (nonatomic, nonnull, strong) NSString *color;
@property (nonatomic, nonnull, strong) NSString *shading;
@property (nonatomic, nonnull, strong) NSString *shape;
@property (nonatomic, nonnull, strong) UIColor *fillColor;

@end
