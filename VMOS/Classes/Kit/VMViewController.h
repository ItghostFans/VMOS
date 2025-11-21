//
//  VMViewController.h
//  Pods
//
//  Created by ItghostFan on 2025/11/21.
//

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#elif TARGET_OS_MAC
#import <AppKit/AppKit.h>
#endif // #if TARGET_OS_IPHONE

NS_ASSUME_NONNULL_BEGIN

#if TARGET_OS_IPHONE
@interface VMViewController : UIViewController
#elif TARGET_OS_MAC
@interface VMViewController : NSViewController
#endif // #if TARGET_OS_IPHONE

@end

NS_ASSUME_NONNULL_END
