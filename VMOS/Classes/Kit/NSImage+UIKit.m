//
//  NSImage+UIKit.m
//  Pods
//
//  Created by ItghostFan on 2025/11/26.
//

#import "NSImage+UIKit.h"

#if TARGET_OS_IPHONE

#elif TARGET_OS_MAC

@implementation NSImage (UIKit)

+ (nullable instancetype)systemImageNamed:(NSString *)name {
    return [NSImage imageWithSystemSymbolName:@"square.and.arrow.up.circle" accessibilityDescription:nil];
}

@end

#endif // #if TARGET_OS_IPHONE
