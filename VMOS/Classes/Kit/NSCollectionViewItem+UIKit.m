//
//  NSCollectionViewItem+UIKit.m
//  Pods
//
//  Created by ItghostFan on 2025/12/2.
//

#import "NSCollectionViewItem+UIKit.h"

#if TARGET_OS_IPHONE

#elif TARGET_OS_MAC

@implementation NSCollectionViewItem (UIKit)

- (NSView *)contentView {
    return self.view;
}

@end

#endif // #if TARGET_OS_IPHONE
