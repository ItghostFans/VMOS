//
//  NSScreen+UIKit.h
//  Pods
//
//  Created by ItghostFan on 2025/12/10.
//

#import <VMOS/VMKit.h>

#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC

NS_ASSUME_NONNULL_BEGIN

@interface NSScreen (UIKit)

@property (assign, nonatomic, readonly) CGRect bounds;

@end

NS_ASSUME_NONNULL_END

#endif // #if TARGET_OS_IPHONE
