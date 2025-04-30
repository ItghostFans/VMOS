//
//  VMOSResizableLayer.h
//  VMOS
//
//  Created by ItghostFan on 2025/4/26.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface VMOSResizableLayer : CALayer

@property (assign, nonatomic) UIEdgeInsets resizeInsets;

- (void)addCorner:(UIRectCorner)corner controlPoint:(CGPoint)controlPoint;

@end

NS_ASSUME_NONNULL_END
