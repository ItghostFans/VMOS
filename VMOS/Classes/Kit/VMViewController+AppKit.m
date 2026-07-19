//
//  VMViewController+AppKit.m
//  Pods
//
//  Created by ItghostFan on 2026/7/19.
//

#import "VMViewController+AppKit.h"

#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC

@implementation VMViewController (AppKit)

- (void)viewWillAppear {
    [super viewWillAppear];
    [self viewWillAppear:NO];
}

- (void)viewWillAppear:(BOOL)animated {
}

- (void)viewDidLayout {
    [super viewDidLayout];
    [self viewDidLayoutSubviews];
}

- (void)viewDidLayoutSubviews {
}

@end

#endif // #if TARGET_OS_IPHONE
