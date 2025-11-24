//
//  VMButton.m
//  Pods
//
//  Created by ItghostFan on 2025/11/23.
//

#import "VMButton.h"

#import <VMOS/VMButtonCell.h>
#import <VMOS/VMLabel.h>

@interface VMButton ()
@property (strong, nonatomic) VMButtonCell *buttonCell;
@end

@implementation VMButton

#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC
+ (Class)cellClass {
    return VMButtonCell.class;
}

- (VMButtonCell *)buttonCell {
    return (VMButtonCell *)self.cell;
}

- (CGSize)intrinsicContentSize {
    CGFloat imageLine = MAX(self.image.size.width, self.image.size.height);
    CGSize titleSize = [self.buttonCell.titleLabel sizeThatFits:CGSizeZero];
    return CGSizeMake(imageLine + titleSize.width, MAX(imageLine, titleSize.height));
}

#endif // #if TARGET_OS_IPHONE

@end
