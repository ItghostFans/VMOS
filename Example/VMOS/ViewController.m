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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *cornerView = [[UIView alloc] initWithFrame:CGRectMake(10.0f, 60.0f, 100.0f, 100.0f)];
    cornerView.backgroundColor = UIColor.grayColor;
//    cornerView.corner_radius = CGSizeMake(20.0f, 50.0f);
//    cornerView.corner_corners = UIRectCornerTopLeft | UIRectCornerBottomRight;
    [self.view addSubview:cornerView];
    UIView *gradientView = cornerView;
//    UIView *gradientView = [[UIView alloc] initWithFrame:CGRectMake(10.0f, 160.0f, 100.0f, 100.0f)];
    gradientView.gradient_layer.locations = @[@0.0f, @1.0f];
//    // 水平居中
//    gradientView.gradient_layer.startPoint = CGPointMake(0.0f, 0.5f);
//    gradientView.gradient_layer.endPoint = CGPointMake(1.0f, 0.5f);
    // 垂直居中
    gradientView.gradient_layer.startPoint = CGPointMake(0.5f, 0.0f);
    gradientView.gradient_layer.endPoint = CGPointMake(0.5f, 1.0f);
    gradientView.gradient_layer.colors = @[
        (__bridge id)UIColor.redColor.CGColor,
        (__bridge id)UIColor.greenColor.CGColor,
    ];
    gradientView.gradient_angle = 15.0f * (M_PI / 180.0f);
    [self.view addSubview:gradientView];
}

@end
