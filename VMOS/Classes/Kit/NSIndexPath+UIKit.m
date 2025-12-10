//
//  NSIndexPath+UIKit.m
//  Pods
//
//  Created by ItghostFan on 2025/12/8.
//

#import "NSIndexPath+UIKit.h"

#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC
#import <AppKit/AppKit.h>
#endif // #if TARGET_OS_IPHONE

#if TARGET_OS_IPHONE

#elif TARGET_OS_MAC

@implementation NSIndexPath (UIKit)

+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section {
    return [self indexPathForItem:row inSection:section];
}

- (NSInteger)row {
    return self.item;
}

@end

#endif // #if TARGET_OS_IPHONE
