//
//  VMView+Corner.m
//  VMOS
//
//  Created by ItghostFan on 2024/12/3.
//

#import "VMView+Corner.h"
#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@implementation VMView (Corner)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#if TARGET_OS_IPHONE
        [self runtime_swizzleSel:@selector(layoutSubviews) newSel:@selector(corner_layoutSubviews)];
#elif TARGET_OS_MAC
        [self runtime_swizzleSel:@selector(layout) newSel:@selector(corner_layoutSubviews)];
#endif // #if TARGET_OS_IPHONE
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

- (VMRectCorner)corner_corners {
    const void * sel = @selector(corner_corners);
    return [objc_getAssociatedObject(self, sel) unsignedIntegerValue];
}

- (void)setCorner_corners:(VMRectCorner)corner_corners {
    const void * sel = @selector(corner_corners);
    [self corner_layer];
    objc_setAssociatedObject(self, sel, @(corner_corners), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize)corner_radius {
    const void * sel = @selector(corner_radius);
    
#if TARGET_OS_IPHONE
    CGSize corner_radius = [objc_getAssociatedObject(self, sel) CGSizeValue];
#elif TARGET_OS_MAC
    CGSize corner_radius = [objc_getAssociatedObject(self, sel) sizeValue];
#endif // #if TARGET_OS_IPHONE
    return corner_radius;
}

- (void)setCorner_radius:(CGSize)corner_radius {
    const void * sel = @selector(corner_radius);
    [self corner_layer];
    
#if TARGET_OS_IPHONE
    NSValue *radius = [NSValue valueWithCGSize:corner_radius];
#elif TARGET_OS_MAC
    NSValue *radius = [NSValue valueWithSize:corner_radius];
#endif // #if TARGET_OS_IPHONE
    
    objc_setAssociatedObject(self, sel, radius, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
        // TODO: 这里后面要补回来
//        VMBezierPath *bezierPath = VMBezierPath.bezierPath;
//        corner_layer.path = bezierPath.CGPath;
    }
}

@end
