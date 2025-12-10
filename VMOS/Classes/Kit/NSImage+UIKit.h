//
//  NSImage+UIKit.h
//  Pods
//
//  Created by ItghostFan on 2025/11/26.
//

#import <VMOS/VMKit.h>

#if TARGET_OS_IPHONE

#elif TARGET_OS_MAC

NS_ASSUME_NONNULL_BEGIN

@interface NSImage (UIKit)

+ (nullable instancetype)systemImageNamed:(NSString *)name;

@end

NS_ASSUME_NONNULL_END

#endif // #if TARGET_OS_IPHONE
