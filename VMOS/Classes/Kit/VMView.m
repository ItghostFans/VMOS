//
//  VMView.m
//  Pods-scrawl-ios
//
//  Created by ItghostFan on 2025/11/4.
//

#import "VMView.h"

@implementation VMView
#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC
- (BOOL)isFlipped {
    return YES;
}
#endif // #if TARGET_OS_IPHONE

#if TARGET_OS_IPHONE
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
#elif TARGET_OS_MAC
- (NSView *)hitTest:(NSPoint)point
#endif // #if TARGET_OS_IPHONE
{
#if TARGET_OS_IPHONE
    UIView *hitView = [super hitTest:point withEvent:event];
#elif TARGET_OS_MAC
    NSView *hitView = [super hitTest:point];
#endif // #if TARGET_OS_IPHONE
    return hitView;
}

@end
