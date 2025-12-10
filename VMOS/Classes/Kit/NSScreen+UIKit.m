//
//  NSScreen+UIKit.m
//  Pods
//
//  Created by ItghostFan on 2025/12/10.
//

#import "NSScreen+UIKit.h"

#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC

@implementation NSScreen (UIKit)

- (CGRect)bounds {
    return self.frame;
}

@end

#endif // #if TARGET_OS_IPHONE
