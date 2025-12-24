//
//  VMIgnoredActionView.m
//  Pods
//
//  Created by ItghostFan on 2025/11/26.
//

#import "VMIgnoredActionView.h"

@interface VMIgnoredActionView ()
@property (assign, nonatomic) BOOL hasHit;
@end

@implementation VMIgnoredActionView

#if TARGET_OS_IPHONE
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//#elif TARGET_OS_MAC
//- (NSView *)hitTest:(NSPoint)point
#endif // #if TARGET_OS_IPHONE
#if TARGET_OS_IPHONE
{
    if (self.hasHit) {
        return nil;
    }
    self.hasHit = YES;
#endif // #if TARGET_OS_IPHONE
#if TARGET_OS_IPHONE
    if ([self pointInside:point withEvent:event])
//#elif TARGET_OS_MAC
//    point = [self convertPoint:point fromView:self];
//    if (CGRectContainsPoint(self.bounds, point))
#endif // #if TARGET_OS_IPHONE
#if TARGET_OS_IPHONE
    {
        id hitView = nil;
        for (id view in self.subviews.reverseObjectEnumerator) {
#endif // #if TARGET_OS_IPHONE
#if TARGET_OS_IPHONE
            CGPoint subviewPoint = [view convertPoint:point fromView:self];
            hitView = [view hitTest:subviewPoint withEvent:event];
//#elif TARGET_OS_MAC
//            CGPoint subviewPoint = point;
//            hitView = [view hitTest:subviewPoint];
#endif // #if TARGET_OS_IPHONE
#if TARGET_OS_IPHONE
            if (hitView) {
                self.hasHit = NO;
                return hitView;
            }
        }
        
    }
    self.hasHit = NO;
    return nil;
}
#endif // #if TARGET_OS_IPHONE

@end
