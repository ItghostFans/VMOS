//
//  VMColor+CSS.m
//  Pods
//
//  Created by ItghostFan on 2026/4/12.
//

#import "VMColor+CSS.h"

#if TARGET_OS_IPHONE
@implementation UIColor (CSS)
#elif TARGET_OS_MAC
@implementation NSColor (CSS)
#endif // #if TARGET_OS_IPHONE

+ (instancetype)colorWithAlphaHex:(uint32_t)alphaHex {
    CGFloat alpha = (CGFloat)(alphaHex & 0x000000FF) / 255.0f;
    CGFloat blue = (CGFloat)((alphaHex & 0x0000FF00) >> 8) / 255.0f;
    CGFloat green = (CGFloat)((alphaHex & 0x00FF0000) >> 16) / 255.0f;
    CGFloat red = (CGFloat)((alphaHex & 0xFF000000) >> 24) / 255.0f;
    return [self colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (instancetype)colorWithHex:(uint32_t)hex {
    CGFloat blue = (CGFloat)((hex & 0x0000FF)) / 255.0f;
    CGFloat green = (CGFloat)((hex & 0x00FF00) >> 8) / 255.0f;
    CGFloat red = (CGFloat)((hex & 0xFF0000) >> 16) / 255.0f;
    return [self colorWithRed:red green:green blue:blue alpha:1.0f];
}

+ (instancetype)colorWithAlphaHexText:(NSString *)alphaHexText {
    NSAssert([alphaHexText hasPrefix:@"#"], @"Check!");
    alphaHexText = [alphaHexText substringFromIndex:1];
    NSScanner *scanner = [[NSScanner alloc] initWithString:alphaHexText];
    uint32_t alphaHex = 0;
    BOOL result = [scanner scanHexInt:&alphaHex];
    NSAssert(result, @"Check!");
    return [self colorWithAlphaHex:alphaHex];
}

+ (instancetype)colorWithHexText:(NSString *)hexText {
    NSAssert([hexText hasPrefix:@"#"], @"Check!");
    hexText = [hexText substringFromIndex:1];
    NSScanner *scanner = [[NSScanner alloc] initWithString:hexText];
    uint32_t hex = 0;
    BOOL result = [scanner scanHexInt:&hex];
    NSAssert(result, @"Check!");
    return [self colorWithHex:hex];
}

- (NSString *)alphaHexText {
    CGFloat alpha = 0.0f;
    CGFloat blue = 0.0f;
    CGFloat green = 0.0f;
    CGFloat red = 0.0f;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    return [NSString stringWithFormat:@"#%02X%02X%02X%02X",
     (uint8_t)(red * 255.0f),
     (uint8_t)(green * 255.0f),
     (uint8_t)(blue * 255.0f),
     (uint8_t)(alpha * 255.0f)];
}

@end
