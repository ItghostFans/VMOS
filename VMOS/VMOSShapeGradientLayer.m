//
//  VMOSShapeGradientLayer.m
//  Expecta
//
//  Created by ItghostFan on 2025/4/25.
//

#import "VMOSShapeGradientLayer.h"

#import <VMOS/NSObject+Runtime.h>

@interface VMOSShapeGradientLayer ()
@property (strong, nonatomic) NSMutableArray *colors;
@property (assign, nonatomic) NSInteger index;
@end

@implementation VMOSShapeGradientLayer

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self runtime_swizzleSel:@selector(addAnimation:forKey:) newSel:@selector(vmk_addAnimation:forKey:)];
    });
}

- (void)vmk_addAnimation:(CAAnimation *)anim forKey:(nullable NSString *)key {
//    NSLog(@"Key %@ Animation %@", key.description, anim.debugDescription);
    [self vmk_addAnimation:anim forKey:key];
}

- (instancetype)init {
    if (self = [super init]) {
        _colors = [NSMutableArray arrayWithObjects:VMColor.redColor, VMColor.blueColor, VMColor.yellowColor, VMColor.greenColor, nil];
    }
    return self;
}

//- (void)setFrame:(CGRect)frame {
//    NSLog(@"Check Draw Time!");
//    [super setFrame:frame];
//}
//
- (void)drawInContext:(CGContextRef)ctx {
    NSLog(@"Check Draw Time!");
    [super drawInContext:ctx];
}

- (void)renderInContext:(CGContextRef)ctx {
    NSLog(@"Check Render Time!");
    [super renderInContext:ctx];
}
//
//- (void)display {
//    NSLog(@"Check Display Time!");
//    [super display];
//}

- (instancetype)presentationLayer {
    VMOSShapeGradientLayer *presentationLayer = [super presentationLayer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:presentationLayer.bounds];
    path.lineWidth = 1.0f;
    presentationLayer.path = path.CGPath;
    NSLog(@"Check Presentation %@!", [presentationLayer debugDescription]);
    return presentationLayer;
}

- (instancetype)modelLayer {
    VMOSShapeGradientLayer *modelLayer = [super modelLayer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:modelLayer.bounds];
    path.lineWidth = 1.0f;
    modelLayer.path = path.CGPath;
    NSLog(@"Check Model %@!", [modelLayer debugDescription]);
    return modelLayer;
}

@end
