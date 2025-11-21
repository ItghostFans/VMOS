//
//  VMView+Gradient.m
//  VMOS
//
//  Created by ItghostFan on 2024/12/3.
//

#import "VMView+Gradient.h"
#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@interface VMView ()
@property (assign, nonatomic) CGPoint gradient_startPoint;
@property (assign, nonatomic) CGPoint gradient_endPoint;
@end

@implementation VMView (Gradient)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#if TARGET_OS_IPHONE
        [self runtime_swizzleSel:@selector(layoutSubviews) newSel:@selector(gradient_layoutSubviews)];
#elif TARGET_OS_MAC
        [self runtime_swizzleSel:@selector(layout) newSel:@selector(gradient_layoutSubviews)];
#endif // #if TARGET_OS_IPHONE
    });
}

- (CAGradientLayer *)gradient_layer {
    const void * sel = @selector(gradient_layer);
    CAGradientLayer *gradientLayer = objc_getAssociatedObject(self, sel);
    if (!gradientLayer) {
        gradientLayer = CAGradientLayer.layer;
        objc_setAssociatedObject(self, sel, gradientLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self.layer insertSublayer:gradientLayer atIndex:0];
    }
    return gradientLayer;
}

- (void)setGradient_angle:(CGFloat)gradient_angle {
    {
        const void * sel = @selector(gradient_layer);
        CAGradientLayer *gradientLayer = objc_getAssociatedObject(self, sel);
        if (ceil(gradientLayer.startPoint.x + gradientLayer.endPoint.x) < 1.0f ||
            ceil(gradientLayer.startPoint.y + gradientLayer.endPoint.y) < 1.0f) {
            NSAssert(NO, @"The gradient_layer startPoint & endPoint Should Cross Center!");
            return;
        }
        self.gradient_startPoint = gradientLayer.startPoint;
        self.gradient_endPoint = gradientLayer.endPoint;
    }
    const void * sel = @selector(gradient_angle);
    objc_setAssociatedObject(self, sel, @(gradient_angle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
#if TARGET_OS_IPHONE
    [self setNeedsLayout];
#elif TARGET_OS_MAC
    [self setNeedsLayout:YES];
#endif // #if TARGET_OS_IPHONE
    
}

- (CGFloat)gradient_angle {
    const void * sel = @selector(gradient_angle);
    return [objc_getAssociatedObject(self, sel) doubleValue];
}

- (CGPoint)gradient_startPoint {
    const void * sel = @selector(gradient_startPoint);
    return [objc_getAssociatedObject(self, sel) CGPointValue];
}

- (void)setGradient_startPoint:(CGPoint)gradient_startPoint {
    const void * sel = @selector(gradient_startPoint);
#if TARGET_OS_IPHONE
    NSValue *startPoint = [NSValue valueWithCGPoint:gradient_startPoint];
#elif TARGET_OS_MAC
    NSValue *startPoint = [NSValue valueWithPoint:gradient_startPoint];
#endif // #if TARGET_OS_IPHONE
    objc_setAssociatedObject(self, sel, startPoint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGPoint)gradient_endPoint {
    const void * sel = @selector(gradient_endPoint);
    return [objc_getAssociatedObject(self, sel) CGPointValue];
}

- (void)setGradient_endPoint:(CGPoint)gradient_endPoint {
    const void * sel = @selector(gradient_endPoint);
#if TARGET_OS_IPHONE
    NSValue *endPoint = [NSValue valueWithCGPoint:gradient_endPoint];
#elif TARGET_OS_MAC
    NSValue *endPoint = [NSValue valueWithPoint:gradient_endPoint];
#endif // #if TARGET_OS_IPHONE
    objc_setAssociatedObject(self, sel, endPoint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)gradient_layoutSubviews {
    [self gradient_layoutSubviews];
    const void * sel = @selector(gradient_layer);
    CAGradientLayer *gradient_layer = objc_getAssociatedObject(self, sel);
    if (gradient_layer) {
        [CATransaction begin];
        gradient_layer.frame = self.bounds;
        [CATransaction setDisableActions:NO];
        CGFloat gradient_angle = self.gradient_angle;
        if (0.0f < gradient_angle && gradient_angle < 2 * M_PI) {
            const CGFloat width = CGRectGetWidth(self.bounds);
            const CGFloat height = CGRectGetHeight(self.bounds);
            const CGPoint center = CGPointMake(width / 2, height / 2);
                
            CGFloat vRad_2 = atanf(center.x / center.y);        // 上下三角半弧度
            CGFloat hRad_2 = atanf(center.y / center.x);        // 左右三角半弧度
            CGFloat originRad = 0.0f;                           // 原始设置的弧度
            if (self.gradient_startPoint.y == 0.0f && self.gradient_endPoint.y == 1.0f) {
                // 下三角
                CGFloat a = 0.0f;
                if (self.gradient_startPoint.x < 0.5f) {
                    a = center.x - self.gradient_startPoint.x * width;
                    originRad = hRad_2 + vRad_2 - atanf(a / center.y);
                } else {
                    a = self.gradient_startPoint.x * width - center.x;
                    originRad = hRad_2 + vRad_2 + atanf(a / center.y);
                }
            } else
            if (self.gradient_startPoint.y == 1.0f && self.gradient_endPoint.y == 0.0f) {
                // 下三角
                CGFloat a = 0.0f;
                if (self.gradient_startPoint.x < 0.5f) {
                    a = center.x - self.gradient_startPoint.x * width;
                    originRad = M_PI_2 + M_PI + atanf(a / center.y);
                } else {
                    a = self.gradient_startPoint.x * width - center.x;
                    originRad = M_PI_2 + M_PI - atanf(a / center.y);
                }
            } else
            if ((self.gradient_startPoint.x == 0.0f && self.gradient_endPoint.x == 1.0f)
                ) {
                // 左三角
                CGFloat a = 0.0f;
                if (self.gradient_startPoint.y < 0.5f) {
                    a = center.y - self.gradient_startPoint.y * height;
                    originRad = atanf(a / center.x);
                } else {
                    a = self.gradient_startPoint.y * height - center.y;
                    originRad = 2 * M_PI - atanf(a / center.x);
                }
            } else
            if (self.gradient_startPoint.x == 1.0f && self.gradient_endPoint.x == 0.0f) {
                // 右三角
                CGFloat a = 0.0f;
                if (self.gradient_startPoint.y < 0.5f) {
                    a = center.y - self.gradient_startPoint.y * height;
                    originRad = M_PI - atanf(a / center.x);
                } else {
                    a = self.gradient_startPoint.y * height - center.y;
                    originRad = M_PI + atanf(a / center.x);
                }
            }
            
            CGFloat rad = originRad + gradient_angle;
            if (rad > 2 * M_PI) {
                rad -= 2 * M_PI;
            }
#ifdef DEBUG
            NSLog(@"Rad: %f", rad);
#endif // #ifdef DEBUG
            
            if (hRad_2 < rad && rad < hRad_2 + (vRad_2 * 2)) {
                // 上三角
                CGFloat x = 0.0f;
                if (rad < M_PI_2) {
                    x = center.x - tanf(M_PI_2 - rad) * center.y;
                } else {
                    x = center.x + tanf(rad - M_PI_2) * center.y;
                }
                gradient_layer.startPoint = CGPointMake(floor(x) / width, 0.0f);
                gradient_layer.endPoint = CGPointMake((width - floor(x)) / width, 1.0f);
                if (gradient_layer.endPoint.x == 0.0f) {
                    NSLog(@"");
                }
            } else
            if (hRad_2 + (vRad_2 * 2) <= rad && rad <= hRad_2 + M_PI) {
                // 右三角
                CGFloat y = 0.0f;
                if (rad < M_PI) {
                    y = center.y - tanf(M_PI - rad) * center.x;
                } else {
                    y = center.y + tanf(rad - M_PI) * center.x;
                }
                gradient_layer.startPoint = CGPointMake(1.0f, ceil(y) / height);
                gradient_layer.endPoint = CGPointMake(0.0f, (height - ceil(y)) / height);
                if (gradient_layer.endPoint.y == 0.0f) {
                    NSLog(@"");
                }
            } else
            if (hRad_2 + M_PI < rad && rad < hRad_2 + (vRad_2 * 2) + M_PI) {
                // 下三角
                CGFloat x = 0.0f;
                if (rad > M_PI + M_PI_2) {
                    x = center.x - tanf(rad - (M_PI + M_PI_2)) * center.y;
                } else {
                    x = center.x + tanf((M_PI + M_PI_2) - rad) * center.y;
                }
                gradient_layer.startPoint = CGPointMake(floor(x) / width, 1.0f);
                gradient_layer.endPoint = CGPointMake((width - floor(x)) / width, 0.0f);
                if (gradient_layer.endPoint.x == 1.0f) {
                    NSLog(@"");
                }
            } else {
                // 左三角
                CGFloat y = 0.0f;
                if (rad <= hRad_2) {
                    y = center.y - tanf(rad) * center.x;
                } else
                if (rad >= 2 * M_PI - hRad_2){
                    y = center.y + tanf(2 * M_PI - rad) * center.x;
                }
                gradient_layer.startPoint = CGPointMake(0.0f, ceil(y) / height);
                gradient_layer.endPoint = CGPointMake(1.0f, (height - ceil(y)) / height);
                if (gradient_layer.endPoint.y == 1.0f) {
                    NSLog(@"");
                }
            }
            [CATransaction commit];
        }
    }
}

@end
