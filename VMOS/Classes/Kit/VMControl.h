//
//  VMControl.h
//  Pods
//
//  Created by ItghostFan on 2025/11/24.
//
#import <QuartzCore/QuartzCore.h>

#import <VMOS/VMGeometry.h>
#import <VMOS/VMKit.h>
#import <VMOS/VMControl.h>

NS_ASSUME_NONNULL_BEGIN

#if TARGET_OS_IPHONE
@interface VMControl : UIControl
#elif TARGET_OS_MAC
@interface VMControl : NSControl

@end

NS_ASSUME_NONNULL_END

#endif // #if TARGET_OS_IPHONE
