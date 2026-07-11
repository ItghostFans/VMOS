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

#if TARGET_OS_IPHONE
- (UIViewController *)controller {
    UIResponder *responder = self;
    UIViewController *controller = nil;
#elif TARGET_OS_MAC
- (NSViewController *)controller {
    NSResponder *responder = self;
    NSViewController *controller = nil;
#endif // #if TARGET_OS_IPHONE
    do {
        responder = responder.nextResponder;
#if TARGET_OS_IPHONE
        if ([responder isKindOfClass:UIViewController.class]) {
            controller = (UIViewController *)responder;
#elif TARGET_OS_MAC
        if ([responder isKindOfClass:NSViewController.class]) {
            controller = (NSViewController *)responder;
#endif // #if TARGET_OS_IPHONE
            break;
        }
    } while (YES);
    return controller;
}

@end
