//
//  NSBundle+Cross.m
//  Pods
//
//  Created by ItghostFan on 2025/12/17.
//

#import "NSBundle+Cross.h"

@implementation NSBundle (Cross)

+ (NSMutableArray<__kindof NSBundle *> *)allBizBundles {
    NSBundle *mainBundle = NSBundle.mainBundle;
    NSMutableArray *allBizBundles = [NSMutableArray arrayWithObject:mainBundle];
    for (NSBundle *framework in NSBundle.allFrameworks) {
        if ([framework.bundlePath hasPrefix:mainBundle.bundlePath]) {
            [allBizBundles addObject:framework];
        }
    }
    return allBizBundles;
}

@end
