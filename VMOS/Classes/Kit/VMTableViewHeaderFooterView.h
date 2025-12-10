//
//  VMTableViewHeaderFooterView.h
//  Pods
//
//  Created by ItghostFan on 2025/12/9.
//

#import <VMOS/VMKit.h>

NS_ASSUME_NONNULL_BEGIN

#if TARGET_OS_IPHONE
@interface VMTableViewHeaderFooterView : UITableViewHeaderFooterView
#elif TARGET_OS_MAC
@interface VMTableViewHeaderFooterView : NSTableHeaderView
#endif // #if TARGET_OS_IPHONE

@end

NS_ASSUME_NONNULL_END
