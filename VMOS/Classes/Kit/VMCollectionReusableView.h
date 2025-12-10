//
//  VMCollectionReusableView.h
//  Pods
//
//  Created by ItghostFan on 2025/12/3.
//

#import <VMOS/VMKit.h>

NS_ASSUME_NONNULL_BEGIN

#if TARGET_OS_IPHONE
@interface VMCollectionReusableView : UICollectionReusableView
#elif TARGET_OS_MAC
@interface VMCollectionReusableView : NSView
#endif // #if TARGET_OS_IPHONE

@end

NS_ASSUME_NONNULL_END
