//
//  VMView+Corner.h
//  VMOS
//
//  Created by ItghostFan on 2024/12/3.
//

#import <VMOS/VMView.h>

NS_ASSUME_NONNULL_BEGIN

@interface VMView (Corner)

@property (weak, nonatomic, readonly) CAShapeLayer *corner_layer;

@property (assign, nonatomic) VMRectCorner corner_corners;
@property (assign, nonatomic) CGSize corner_radius;

@end

NS_ASSUME_NONNULL_END
