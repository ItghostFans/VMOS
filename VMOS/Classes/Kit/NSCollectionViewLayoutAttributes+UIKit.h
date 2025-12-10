//
//  NSCollectionViewLayoutAttributes+UIKit.h
//  Pods
//
//  Created by ItghostFan on 2025/12/10.
//

#import <VMOS/VMKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSCollectionViewLayoutAttributes (UIKit)

#if TARGET_OS_IPHONE

#elif TARGET_OS_MAC

+ (instancetype)layoutAttributesForCellWithIndexPath:(NSIndexPath *)indexPath;

#endif // #if TARGET_OS_IPHONE

@end

NS_ASSUME_NONNULL_END
