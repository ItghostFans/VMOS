//
//  NSScreen+UIKit.m
//  Pods
//
//  Created by ItghostFan on 2025/12/10.
//

#import "NSScreen+UIKit.h"

#if TARGET_OS_IPHONE
#elif TARGET_OS_OSX

@implementation NSScreen (UIKit)

- (CGRect)bounds {
    return self.frame;
}

- (CGFloat)scale {
    return self.backingScaleFactor;
}

@end

#endif // #if TARGET_OS_IPHONE
