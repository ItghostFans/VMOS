//
//  NSView+Cross.h
//  Pods
//
//  Created by ItghostFan on 2025/11/25.
//

#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC

#import <VMOS/VMKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSView (Cross)
              
- (VMImage *)snapshot;
- (CGContextRef)currentContext;

@end

NS_ASSUME_NONNULL_END

#endif // #if TARGET_OS_IPHONE
