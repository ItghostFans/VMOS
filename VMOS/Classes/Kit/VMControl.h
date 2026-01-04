//
//  VMControl.h
//  Pods
//
//  Created by ItghostFan on 2025/11/24.
//

#import <VMOS/VMKit.h>

NS_ASSUME_NONNULL_BEGIN

#if TARGET_OS_IPHONE
@interface VMControl : UIControl
#elif TARGET_OS_MAC
@interface VMControl : NSControl
#endif // #if TARGET_OS_IPHONE

@end

NS_ASSUME_NONNULL_END
