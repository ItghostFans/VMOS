//
//  UIView+Cross.m
//  Pods
//
//  Created by ItghostFan on 2025/11/25.
//

#import "UIView+Cross.h"

#if TARGET_OS_IPHONE
@implementation UIView (Cross)

- (VMImage *)snapshot {
    VMImage *snapshot = nil;
    UIGraphicsImageRenderer *render = [[UIGraphicsImageRenderer alloc] initWithSize:self.frame.size
                                                                             format:UIGraphicsImageRendererFormat.defaultFormat];
    snapshot = [render imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
        [self drawLayer:self.layer inContext:rendererContext.CGContext];
    }];
    return snapshot;
}

- (CGContextRef)currentContext {
    return UIGraphicsGetCurrentContext();
}

@end
#elif TARGET_OS_MAC
#endif // #if TARGET_OS_IPHONE
