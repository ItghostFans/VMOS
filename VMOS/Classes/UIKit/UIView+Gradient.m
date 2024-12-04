//
//  UIView+Gradient.m
//  VMOS
//
//  Created by ItghostFan on 2024/12/3.
//

#import "UIView+Gradient.h"
#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@interface UIView ()
@property (assign, nonatomic) CGPoint gradient_startPoint;
@property (assign, nonatomic) CGPoint gradient_endPoint;
@end

@implementation UIView (Gradient)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self runtime_swizzleSel:@selector(layoutSubviews) newSel:@selector(gradient_layoutSubviews)];
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
    [self setNeedsLayout];
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
    objc_setAssociatedObject(self, sel, [NSValue valueWithCGPoint:gradient_startPoint], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGPoint)gradient_endPoint {
    const void * sel = @selector(gradient_endPoint);
    return [objc_getAssociatedObject(self, sel) CGPointValue];
}

- (void)setGradient_endPoint:(CGPoint)gradient_endPoint {
    const void * sel = @selector(gradient_endPoint);
    objc_setAssociatedObject(self, sel, [NSValue valueWithCGPoint:gradient_endPoint], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)gradient_layoutSubviews {
    [self gradient_layoutSubviews];
    const void * sel = @selector(gradient_layer);
    CAGradientLayer *gradient_layer = objc_getAssociatedObject(self, sel);
    if (gradient_layer) {
        CGFloat gradient_angle = self.gradient_angle;
        if (0.0f < gradient_angle && gradient_angle < (45.0f * M_PI / 180.0f)) {
            const CGFloat width = CGRectGetWidth(self.bounds);
            const CGFloat height = CGRectGetHeight(self.bounds);
            const CGPoint center = CGPointMake(width / 2, height / 2);
            
            if (self.gradient_startPoint.y == 0.0f && self.gradient_endPoint.y == 1.0f) {
                if (self.gradient_startPoint.x == 0.5f && self.gradient_endPoint.x == 0.5f) {
                    CGFloat x = center.x - tanf(gradient_angle) * center.y;
                    CGFloat startX = (width - x) / width;
                    CGFloat endX = (x) / width;
                    gradient_layer.startPoint = CGPointMake(startX, 0.0f);
                    gradient_layer.endPoint = CGPointMake(endX, 1.0f);
                } else {
                    CGFloat angle = atanf(center.x / center.y);
                    CGFloat x = center.x - tanf(angle - gradient_angle) * center.y;
                    CGFloat startX = (x) / width;
                    CGFloat endX = (width - x) / width;
                    gradient_layer.startPoint = CGPointMake(startX, 0.0f);
                    gradient_layer.endPoint = CGPointMake(endX, 1.0f);
                }
            } else
            if (self.gradient_startPoint.x == 0.0f && self.gradient_endPoint.x == 1.0f) {
                if (self.gradient_startPoint.y == 0.5f && self.gradient_endPoint.y == 0.5f) {
                    CGFloat y = center.y - tanf(gradient_angle) * center.x;
                    CGFloat startY = (y) / height;
                    CGFloat endY = (height - y) / height;
                    gradient_layer.startPoint = CGPointMake(0.0f, startY);
                    gradient_layer.endPoint = CGPointMake(1.0f, endY);
                } else {
                    CGFloat angle = atanf(center.y / center.x);
                    CGFloat y = center.y - tanf(angle - gradient_angle) * center.x;
                    CGFloat startY = (height - y) / height;
                    CGFloat endY = (y) / height;
                    gradient_layer.startPoint = CGPointMake(0.0f, startY);
                    gradient_layer.endPoint = CGPointMake(1.0f, endY);
                }
            }
        }
        gradient_layer.frame = self.bounds;
    }
}

@end
