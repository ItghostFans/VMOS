//
//  VMOSResizableLayer.h
//  VMOS
//
//  Created by ItghostFan on 2025/4/26.
//

#import <QuartzCore/QuartzCore.h>

#import <VMOS/VMGeometry.h>

NS_ASSUME_NONNULL_BEGIN

@interface VMOSResizableLayer : CALayer

@property (assign, nonatomic) VMEdgeInsets resizeInsets;

- (void)addCorner:(VMRectCorner)corner controlPoint:(CGPoint)controlPoint;

@end

NS_ASSUME_NONNULL_END
