//
//  NSCollectionView+UIKit.m
//  Pods
//
//  Created by ItghostFan on 2025/12/10.
//

#import "NSCollectionView+UIKit.h"

#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC

@implementation NSCollectionView (UIKit)

- (void)setPagingEnabled:(BOOL)pagingEnabled {
}

- (BOOL)pagingEnabled {
    return NO;
}

- (void)setContentInset:(VMEdgeInsets)contentInset {
}

- (VMEdgeInsets)contentInset {
    return VMEdgeInsetsZero;
}

- (nullable __kindof NSCollectionView *)cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return (NSCollectionView *)[self itemAtIndexPath:indexPath];
}

@end

#endif // #if TARGET_OS_IPHONE
