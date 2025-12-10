//
//  NSValue+UIKit.m
//  Pods
//
//  Created by ItghostFan on 2025/12/10.
//

#import "NSValue+UIKit.h"

@implementation NSValue (UIKit)

#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC

- (CGPoint)CGPointValue {
    return self.pointValue;
}

- (CGSize)CGSizeValue {
    return self.sizeValue;
}

- (CGRect)CGRectValue {
    return self.rectValue;
}

- (VMEdgeInsets)UIEdgeInsetsValue {
    return self.edgeInsetsValue;
}

+ (NSValue *)valueWithCGPoint:(CGPoint)point {
    return [self valueWithPoint:point];
}

+ (NSValue *)valueWithCGSize:(CGSize)size {
    return [self valueWithSize:size];
}

+ (NSValue *)valueWithCGRect:(CGRect)rect {
    return [self valueWithRect:rect];
}

+ (NSValue *)valueWithUIEdgeInsets:(VMEdgeInsets)insets {
    return [self valueWithEdgeInsets:insets];
}

#endif // #if TARGET_OS_IPHONE

@end
