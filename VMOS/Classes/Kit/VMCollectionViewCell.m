//
//  VMCollectionViewCell.m
//  Pods
//
//  Created by ItghostFan on 2025/12/10.
//

#import "VMCollectionViewCell.h"

@implementation VMCollectionViewCell

#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC

- (instancetype)initWithNibName:(NSNibName)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self = [self initWithFrame:CGRectZero];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return self;
}

#endif // #if TARGET_OS_IPHONE

@end
