//
//  VMCollectionReusableView.m
//  Pods
//
//  Created by ItghostFan on 2025/12/3.
//

#import "VMCollectionReusableView.h"

@implementation VMCollectionReusableView

#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC
- (BOOL)isFlipped {
    return YES;
}
#endif // #if TARGET_OS_IPHONE

@end
