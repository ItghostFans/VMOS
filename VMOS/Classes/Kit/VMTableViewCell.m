//
//  VMTableViewCell.m
//  Pods
//
//  Created by ItghostFan on 2025/12/9.
//

#import "VMTableViewCell.h"

@implementation VMTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#if TARGET_OS_IPHONE

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#elif TARGET_OS_MAC
#endif // #if TARGET_OS_IPHONE

@end
