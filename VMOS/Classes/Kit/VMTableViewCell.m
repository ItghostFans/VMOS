//
//  VMTableViewCell.m
//  Pods
//
//  Created by ItghostFan on 2025/12/9.
//

#import "VMTableViewCell.h"

@implementation VMTableViewCell

#if TARGET_OS_IPHONE

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#elif TARGET_OS_MAC

- (NSView *)contentView {
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        self = [self initWithStyle:(VMTableViewCellStyleDefault) reuseIdentifier:@""];
    }
    return self;
}

- (instancetype)initWithStyle:(VMTableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    return self;
}

#endif // #if TARGET_OS_IPHONE

@end
