//
//  VMStackView.m
//  Pods
//
//  Created by ItghostFan on 2025/12/31.
//

#import "VMStackView.h"

@implementation VMStackView

#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC

- (VMLayoutConstraintAxis)axis {
    return (VMLayoutConstraintAxis)self.orientation;
}

- (void)setAxis:(VMLayoutConstraintAxis)axis {
    self.orientation = (NSUserInterfaceLayoutOrientation)axis;
}

#endif // #if TARGET_OS_IPHONE

@end
