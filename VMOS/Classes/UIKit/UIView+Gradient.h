//
//  UIView+Gradient.h
//  VMOS
//
//  Created by ItghostFan on 2024/12/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Gradient)

@property (weak, nonatomic, readonly) CAGradientLayer *gradient_layer;
/// 正常是8个点做渐变。
/// TopCenter
/// LeftCenter
/// BottomCenter
/// RightCenter
/// TopLeft
/// TopRight
/// BottomRight
/// BottomLeft
/// 增加这个在以Center为圆心的偏转角，方便大部分场景使用。
@property (assign, nonatomic) CGFloat gradient_angle;      // 区间（0, 45)度，为什么这个区间，自行脑补说明。
@end

NS_ASSUME_NONNULL_END
