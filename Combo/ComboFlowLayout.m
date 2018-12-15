//
//  ComboFlowLayout.m
//  Combo
//
//  Created by Craig Maynard on 3/16/16.
//  Copyright © 2016 Craig Maynard. All rights reserved.
//

#import "ComboFlowLayout.h"

@implementation ComboFlowLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    [attributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *obj, NSUInteger idx, BOOL *stop) {
        //obj.transform = CGAffineTransformMakeScale(0.75, 0.75);
        obj.transform = CGAffineTransformIdentity;
        // NSLog(@"new transform for element %d: %@", idx, NSStringFromCGAffineTransform (obj.transform));
    }];
    
    return attributes;
}

#if 0
- (void)prepareLayout
{
    [super prepareLayout];
    
    if let collectionView = self.collectionView {
        var newItemSize = itemSize
        
        // Always use an item count of at least 1
        let itemsPerRow = CGFloat(max(numberOfItemsPerRow, 1))
        
        // Calculate the sum of the spacing between cells
        let totalSpacing = minimumInteritemSpacing * (itemsPerRow - 1.0)
        
        // Calculate how wide items should be
        newItemSize.width = (collectionView.bounds.size.width - totalSpacing) / itemsPerRow
        
        // Use the aspect ratio of the current item size to determine how tall the items should be
        if itemSize.height > 0 {
            let itemAspectRatio = itemSize.width / itemSize.height
            newItemSize.height = newItemSize.width / itemAspectRatio
        }
        
        // Set the new item size
        itemSize = newItemSize
    }
}
#endif

@end

