//
//  UIView+Corner.m
//  VMOS
//
//  Created by ItghostFan on 2024/12/3.
//

#import "UIView+Corner.h"
#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@implementation UIView (Corner)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self runtime_swizzleSel:@selector(layoutSubviews) newSel:@selector(corner_layoutSubviews)];
    });
}

- (CAShapeLayer *)corner_layer {
    const void * sel = @selector(corner_layer);
    CAShapeLayer *shapeLayer = objc_getAssociatedObject(self, sel);
    if (!shapeLayer) {
        shapeLayer = CAShapeLayer.new;
        objc_setAssociatedObject(self, sel, shapeLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.layer.mask = shapeLayer;
    }
    return shapeLayer;
}

- (UIRectCorner)corner_corners {
    const void * sel = @selector(corner_corners);
    return [objc_getAssociatedObject(self, sel) unsignedIntegerValue];
}

- (void)setCorner_corners:(UIRectCorner)corner_corners {
    const void * sel = @selector(corner_corners);
    [self corner_layer];
    objc_setAssociatedObject(self, sel, @(corner_corners), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize)corner_radius {
    const void * sel = @selector(corner_radius);
    return [objc_getAssociatedObject(self, sel) CGSizeValue];
}

- (void)setCorner_radius:(CGSize)corner_radius {
    const void * sel = @selector(corner_radius);
    [self corner_layer];
    objc_setAssociatedObject(self, sel, [NSValue valueWithCGSize:corner_radius], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)corner_layoutSubviews {
    [self corner_layoutSubviews];
    const void * sel = @selector(corner_layer);
    CAShapeLayer *corner_layer = objc_getAssociatedObject(self, sel);
    if (corner_layer) {
        if (CGRectEqualToRect(self.bounds, corner_layer.frame)) {
            return; // 已经设置了这个了，不必要再处理。
        }
        corner_layer.frame = self.bounds;
        corner_layer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:self.corner_corners cornerRadii:self.corner_radius].CGPath;
    }
}

@end
