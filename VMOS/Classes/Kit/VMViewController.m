//
//  VMViewController.m
//  Pods
//
//  Created by ItghostFan on 2025/11/21.
//

#import "VMViewController.h"

@interface VMViewController ()

@end

@implementation VMViewController

- (CGFloat)titleBarHeight {
#if TARGET_OS_IPHONE
    return 0.0f;
#elif TARGET_OS_MAC
    NSWindow *window = self.view.window;
    if (window.styleMask & NSWindowStyleMaskFullSizeContentView) {
        NSButton *closeButton = [window standardWindowButton:NSWindowCloseButton];
        if (closeButton) {
            return CGRectGetHeight(closeButton.superview.frame);
        }
    }
    CGRect contentFrame = [window contentRectForFrameRect:window.frame];
    return CGRectGetHeight(window.frame) - CGRectGetHeight(contentFrame);
#endif // #if TARGET_OS_IPHONE
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
