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
    NSNumber *corners = objc_getAssociatedObject(self, sel);
    return corners.unsignedIntegerValue;
}

- (void)setCorner_corners:(UIRectCorner)corner_corners {
    const void * sel = @selector(corner_corners);
    objc_setAssociatedObject(self, sel, @(corner_corners), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize)corner_radius {
    const void * sel = @selector(corner_radius);
    NSValue *cornerRadius = objc_getAssociatedObject(self, sel);
    return cornerRadius.CGSizeValue;
}

- (void)setCorner_radius:(CGSize)corner_radius {
    const void * sel = @selector(corner_radius);
    objc_setAssociatedObject(self, sel, [NSValue valueWithCGSize:corner_radius], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)corner_layoutSubviews {
    [self corner_layoutSubviews];
    const void * sel = @selector(corner_layer);
    CAShapeLayer *corner_layer = objc_getAssociatedObject(self, sel);
    if (corner_layer) {
        corner_layer.frame = self.bounds;
        corner_layer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:self.corner_corners cornerRadii:self.corner_radius].CGPath;
    }
}

@end
