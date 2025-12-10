//
//  NSCollectionViewLayoutAttributes+UIKit.m
//  Pods
//
//  Created by ItghostFan on 2025/12/10.
//

#import "NSCollectionViewLayoutAttributes+UIKit.h"

#if TARGET_OS_IPHONE

#elif TARGET_OS_MAC

@implementation NSCollectionViewLayoutAttributes (UIKit)

+ (instancetype)layoutAttributesForCellWithIndexPath:(NSIndexPath *)indexPath {
    return [self layoutAttributesForItemWithIndexPath:indexPath];
}

@end

#endif // #if TARGET_OS_IPHONE
