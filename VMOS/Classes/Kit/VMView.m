//
//  VMView.m
//  Pods-scrawl-ios
//
//  Created by ItghostFan on 2025/11/4.
//

#import "VMView.h"

@implementation VMView
#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC
- (BOOL)isFlipped {
    return YES;
}
#endif // #if TARGET_OS_IPHONE

@end
