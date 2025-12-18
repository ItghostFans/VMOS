//
//  VMTableViewCell.h
//  Pods
//
//  Created by ItghostFan on 2025/12/9.
//

#import <VMOS/VMKit.h>

NS_ASSUME_NONNULL_BEGIN

#if TARGET_OS_IPHONE

typedef NS_ENUM(NSInteger, VMTableViewCellStyle) {
    VMTableViewCellStyleDefault,
    VMTableViewCellStyleValue1,
    VMTableViewCellStyleValue2,
    VMTableViewCellStyleSubtitle,
};

@interface VMTableViewCell : UITableViewCell
#elif TARGET_OS_MAC

typedef NS_ENUM(NSInteger, VMTableViewCellStyle) {
    VMTableViewCellStyleDefault,
    VMTableViewCellStyleValue1,
    VMTableViewCellStyleValue2,
    VMTableViewCellStyleSubtitle,
};

@interface VMTableViewCell : NSTableCellView

@property (weak, nonatomic, readonly) NSView *contentView;

- (instancetype)initWithStyle:(VMTableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier;

#endif // #if TARGET_OS_IPHONE

@end

NS_ASSUME_NONNULL_END
