//
//  VMTableViewCell.h
//  Pods
//
//  Created by ItghostFan on 2025/12/9.
//

#import <VMOS/VMKit.h>

NS_ASSUME_NONNULL_BEGIN

#if TARGET_OS_IPHONE
@interface VMTableViewCell : UITableViewCell
#elif TARGET_OS_MAC
@interface VMTableViewCell : NSTableCellView
#endif // #if TARGET_OS_IPHONE

@end

NS_ASSUME_NONNULL_END
