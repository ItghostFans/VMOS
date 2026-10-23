//
//  VMView.h
//  Pods-scrawl-ios
//
//  Created by ItghostFan on 2025/11/4.
//

#import <QuartzCore/QuartzCore.h>

#import <VMOS/VMGeometry.h>
#import "VMOS/VMKit.h"
#if TARGET_OS_IPHONE
#import <VMOS/UIView+Cross.h>
#elif TARGET_OS_MAC
#import <VMOS/NSView+UIKit.h>
#import <VMOS/NSView+Cross.h>
#endif // #if TARGET_OS_IPHONE

NS_ASSUME_NONNULL_BEGIN

#if TARGET_OS_IPHONE
@interface VMView : UIView
#elif TARGET_OS_MAC
@interface VMView : NSView
#endif // #if TARGET_OS_IPHONE

@end

NS_ASSUME_NONNULL_END
