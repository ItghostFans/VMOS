//
//  NSValue+UIKit.h
//  Pods
//
//  Created by ItghostFan on 2025/12/10.
//

#import <VMOS/VMKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSValue (UIKit)

#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC

@property (assign, nonatomic, readonly) CGPoint CGPointValue;
@property (assign, nonatomic, readonly) CGSize CGSizeValue;
@property (assign, nonatomic, readonly) CGRect CGRectValue;
@property (assign, nonatomic, readonly) VMEdgeInsets UIEdgeInsetsValue;

+ (NSValue *)valueWithCGPoint:(CGPoint)point;
+ (NSValue *)valueWithCGSize:(CGSize)size;
+ (NSValue *)valueWithCGRect:(CGRect)rect;
+ (NSValue *)valueWithUIEdgeInsets:(VMEdgeInsets)insets;

#endif // #if TARGET_OS_IPHONE

@end

NS_ASSUME_NONNULL_END
