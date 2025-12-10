//
//  NSCollectionViewLayoutAttributes+UIKit.m
//  Pods
//
//  Created by ItghostFan on 2025/12/10.
//

#import "NSCollectionViewLayoutAttributes+UIKit.h"

@implementation NSCollectionViewLayoutAttributes (UIKit)

#if TARGET_OS_IPHONE

#elif TARGET_OS_MAC

+ (instancetype)layoutAttributesForCellWithIndexPath:(NSIndexPath *)indexPath {
    return [self layoutAttributesForItemWithIndexPath:indexPath];
}

#endif // #if TARGET_OS_IPHONE

@end
