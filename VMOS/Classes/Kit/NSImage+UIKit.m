//
//  NSImage+UIKit.m
//  Pods
//
//  Created by ItghostFan on 2025/11/26.
//

#import "NSImage+UIKit.h"

#if TARGET_OS_IPHONE

#elif TARGET_OS_MAC

@implementation NSImage (UIKit)

+ (nullable instancetype)systemImageNamed:(NSString *)name {
    return [NSImage imageWithSystemSymbolName:name accessibilityDescription:nil];
}

- (VMImage *)resizableImageWithCapInsets:(VMEdgeInsets)capInsets
                            resizingMode:(VMImageResizingMode)resizingMode {
    self.capInsets = capInsets;
    self.resizingMode = resizingMode;
    return self;
}

- (nullable VMImage *)imageByApplyingSymbolConfiguration:(VMImageSymbolConfiguration *)configuration {
    return [self imageWithSymbolConfiguration:configuration];
}

@end

#endif // #if TARGET_OS_IPHONE
