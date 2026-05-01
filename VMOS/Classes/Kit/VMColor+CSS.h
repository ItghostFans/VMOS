//
//  VMColor+CSS.h
//  Pods
//
//  Created by ItghostFan on 2026/4/12.
//

#import <VMOS/VMKit.h>

NS_ASSUME_NONNULL_BEGIN

#if TARGET_OS_IPHONE
@interface UIColor (CSS)
#elif TARGET_OS_MAC
@interface NSColor (CSS)
#endif // #if TARGET_OS_IPHONE

/// 从16进制的整型初始化颜色。
/// - Parameter alphaHex: 0xRRGGBBAA。
+ (instancetype)colorWithAlphaHex:(uint32_t)alphaHex;

/// 从16进制的整型初始化颜色。
/// - Parameter hex: 0xRRGGBB。
+ (instancetype)colorWithHex:(uint32_t)hex;

/// 从16进制的文本初始化颜色。
/// - Parameter alphaHexText: #RRGGBBAA。
+ (instancetype)colorWithAlphaHexText:(NSString *)alphaHexText;

/// 从16进制的文本初始化颜色。
/// - Parameter hexText: #RRGGBB。
+ (instancetype)colorWithHexText:(NSString *)hexText;

/// 转换成#RRGGBBAA。
- (NSString *)alphaHexText;

@end

#define VM_COLOR_ALPHA_HEX(alphaHex)            [VMColor colorWithAlphaHex:alphaHex]
#define VM_COLOR_HEX(hex)                       [VMColor colorWithHex:hex]
#define VM_COLOR_ALPHA_HEX_TEXT(alphaHexText)   [VMColor colorWithAlphaHexText:alphaHexText]
#define VM_COLOR_HEX_TEXT(hexText)              [VMColor colorWithHexText:hexText]

NS_ASSUME_NONNULL_END
