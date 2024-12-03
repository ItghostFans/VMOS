//
//  UIView+Gradient.m
//  VMOS
//
//  Created by ItghostFan on 2024/12/3.
//

#import "UIView+Gradient.h"
#import "NSObject+Runtime.h"
#import <objc/runtime.h>

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

- (void)gradient_layoutSubviews {
    [self gradient_layoutSubviews];
    self.gradient_layer.frame = self.bounds;
}

@end
