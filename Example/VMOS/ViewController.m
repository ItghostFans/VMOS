//
//  ViewController.m
//  VMOS
//
//  Created by ItghostFans on 12/03/2024.
//  Copyright (c) 2024 ItghostFans. All rights reserved.
//

#import "ViewController.h"

#import <VMOS/UIView+Corner.h>
#import <VMOS/UIView+Gradient.h>

@interface ViewController ()

@property (weak, nonatomic) UIView *cornerView;
@property (weak, nonatomic) UIView *gradientView;

@property (weak, nonatomic) CADisplayLink *animateDisplayLink;

@property (weak, nonatomic) UIControl *control;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = 60.0f;
    CGFloat height = 60.0f;
    CGFloat spacing = 5.0f;
    NSInteger column = 4;
    UIView *cornerView;
    for (NSInteger index = 0; index < 1; ++index) {
        NSInteger rowIndex = index / column;
        NSInteger columnIndex = index % column;
        cornerView = [[UIView alloc] initWithFrame:CGRectMake((spacing + width) * columnIndex + spacing, 60.0f + (rowIndex * (height + spacing)), width, height)];
        cornerView.backgroundColor = UIColor.grayColor;
        cornerView.corner_radius = CGSizeMake(20.0f, 50.0f);
//        cornerView.corner_corners = UIRectCornerTopLeft | UIRectCornerBottomRight;
        cornerView.corner_corners = UIRectCornerAllCorners;
        [self.view addSubview:cornerView];
        UIView *gradientView = cornerView;
    //    UIView *gradientView = [[UIView alloc] initWithFrame:CGRectMake(10.0f, 160.0f, 100.0f, 100.0f)];
        gradientView.gradient_layer.locations = @[@0.0f, 
//                                                  @0.1f,
                                                  @1.0f];
        gradientView.gradient_layer.colors = @[
            (__bridge id)UIColor.greenColor.CGColor,
            (__bridge id)UIColor.redColor.CGColor,
//            (__bridge id)UIColor.greenColor.CGColor,
        ];
        _gradientView = gradientView;
        [self setStartEndPoint];
//        gradientView.gradient_angle = 45.0 * index * (M_PI / 180.0f);
        [self.view addSubview:gradientView];
    }
    
    CADisplayLink *animateDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(onAnimateDisplayLink:)];
    if (@available(iOS 15.0, *)) {
        animateDisplayLink.preferredFrameRateRange = CAFrameRateRangeMake(30.0f, 30.0f, 30.0f);
    } else {
        animateDisplayLink.preferredFramesPerSecond = 30.0f;
    }
    [animateDisplayLink addToRunLoop:NSRunLoop.mainRunLoop forMode:NSRunLoopCommonModes];
    
    UIControl *control = [[UIControl alloc] initWithFrame:CGRectMake(100.0f, 100.0f, 50.0f, 50.0f)];
    _control = control;
    _control.backgroundColor = UIColor.redColor;
    [self.view addSubview:control];
    [control addTarget:self action:@selector(onClick:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)setStartEndPoint {
    switch (3) {
        case 1: {// 左三角
            self.gradientView.gradient_layer.startPoint = CGPointMake(0.0f, 1.0f);
            self.gradientView.gradient_layer.endPoint = CGPointMake(1.0f, 0.0f);
            break;
        }
        case 2: {// 上三角
            self.gradientView.gradient_layer.startPoint = CGPointMake(0.0f, 0.0f);
            self.gradientView.gradient_layer.endPoint = CGPointMake(1.0f, 1.0f);
            break;
        }
        case 3: {// 右三角
            self.gradientView.gradient_layer.startPoint = CGPointMake(1.0f, 0.0f);
            self.gradientView.gradient_layer.endPoint = CGPointMake(0.0f, 1.0f);
            break;
        }
        case 4: {// 下三角
            self.gradientView.gradient_layer.startPoint = CGPointMake(1.0f, 1.0f);
            self.gradientView.gradient_layer.endPoint = CGPointMake(0.0f, 0.0f);
            break;
        }
    }
}

#pragma mark - Animation

#define LOOP

- (void)onAnimateDisplayLink:(CADisplayLink *)displayLink {
    CGFloat angle = 2 * M_PI / 180.0f;
#ifdef LOOP
    if (angle >= 2 * M_PI) {
        angle = 0.0f;
    }
#else
    [self setStartEndPoint];
    angle += self.gradientView.gradient_angle;
#endif // #ifdef LOOP
    
    self.gradientView.gradient_angle = angle;
#ifndef LOOP
    // 一轮停止
    if (angle >= M_PI_2) {
        [displayLink invalidate];
    }
#endif // #ifndef LOOP
}

#pragma mark - Actions

- (void)onClick:(UIControl *)control {
    
}

@end
