//
//  VMViewController+AppKit.h
//  Pods
//
//  Created by ItghostFan on 2026/7/19.
//

#import <VMOS/VMViewController.h>

#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC

NS_ASSUME_NONNULL_BEGIN

@interface VMViewController (AppKit)

- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidLayoutSubviews;

@end

NS_ASSUME_NONNULL_END

#endif // #if TARGET_OS_IPHONE
