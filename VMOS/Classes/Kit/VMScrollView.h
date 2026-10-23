//
//  VMScrollView.h
//  Pods
//
//  Created by ItghostFan on 2025/12/17.
//

#import <VMOS/VMKit.h>

NS_ASSUME_NONNULL_BEGIN

#if TARGET_OS_IPHONE
@interface VMScrollView : UIScrollView
#elif TARGET_OS_MAC
@interface VMScrollView : NSScrollView
#endif // #if TARGET_OS_IPHONE

@property (weak, nonatomic) VMView *view;

@end

NS_ASSUME_NONNULL_END
