//
//  UIView+Cross.h
//  Pods
//
//  Created by ItghostFan on 2025/11/25.
//

#if TARGET_OS_IPHONE
#import <VMOS/VMKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Cross)
              
- (VMImage *)snapshot;
- (CGContextRef)currentContext;

@end

NS_ASSUME_NONNULL_END

#elif TARGET_OS_MAC

#endif // #if TARGET_OS_IPHONE
