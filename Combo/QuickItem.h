//
//  QuickItem.h
//  Combo
//
//  Created by Craig Maynard on 3/13/16.
//  Copyright © 2016 Craig Maynard. All rights reserved.
//

#import <Foundation/Foundation.h>

@import QuickLook;

@interface QuickItem : NSObject <QLPreviewItem>

@property (readwrite, nonnull, nonatomic) NSURL *baseURL;
@property (readonly, nonnull, nonatomic) NSURL * previewItemURL;
@property (readonly, nonnull, nonatomic) NSString *previewItemTitle;

@end
