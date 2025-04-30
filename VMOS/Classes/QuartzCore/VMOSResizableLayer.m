//
//  VMOSResizableLayer.m
//  VMOS
//
//  Created by ItghostFan on 2025/4/26.
//

#import "VMOSResizableLayer.h"

@interface VMOSResizableLayer ()
@property (weak, nonatomic, nullable) CAShapeLayer *topLeftLayer;
@property (weak, nonatomic, nullable) CAShapeLayer *topLayer;
@property (weak, nonatomic, nullable) CAShapeLayer *topRightLayer;
@property (weak, nonatomic, nullable) CAShapeLayer *leftLayer;
@property (weak, nonatomic, nullable) CAShapeLayer *midLayer;
@property (weak, nonatomic, nullable) CAShapeLayer *rightLayer;
@property (weak, nonatomic, nullable) CAShapeLayer *bottomLeftLayer;
@property (weak, nonatomic, nullable) CAShapeLayer *bottomLayer;
@property (weak, nonatomic, nullable) CAShapeLayer *bottomRightLayer;

@property (strong, nonatomic, nonnull) NSMutableDictionary<__kindof NSNumber *, __kindof  NSValue *> *cornerControlPoints;
@end

@implementation VMOSResizableLayer

- (instancetype)init {
    if (self = [super init]) {
        _cornerControlPoints = [NSMutableDictionary dictionaryWithCapacity:4];
    }
    return self;
}

- (void)setResizeInsets:(UIEdgeInsets)resizeInsets {
    _resizeInsets = resizeInsets;
    
#ifdef DEBUG
    self.topLeftLayer.backgroundColor = UIColor.redColor.CGColor;        // 1.0, 0.0, 0.0 RGB
    self.topLayer.backgroundColor = UIColor.greenColor.CGColor;      // 0.0, 1.0, 0.0 RGB
    self.topRightLayer.backgroundColor = UIColor.blueColor.CGColor;       // 0.0, 0.0, 1.0 RGB
    self.leftLayer.backgroundColor = UIColor.cyanColor.CGColor;       // 0.0, 1.0, 1.0 RGB
    self.midLayer.backgroundColor = UIColor.yellowColor.CGColor;     // 1.0, 1.0, 0.0 RGB
    self.rightLayer.backgroundColor = UIColor.magentaColor.CGColor;    // 1.0, 0.0, 1.0 RGB
    self.bottomLeftLayer.backgroundColor = UIColor.orangeColor.CGColor;     // 1.0, 0.5, 0.0 RGB
    self.bottomLayer.backgroundColor = UIColor.purpleColor.CGColor;     // 0.5, 0.0, 0.5 RGB
    self.bottomRightLayer.backgroundColor = UIColor.brownColor.CGColor;      // 0.6, 0.4, 0.2 RGB
#endif // #ifdef DEBUG
    
    [self updateCorners];
}

- (void)addCorner:(UIRectCorner)corner controlPoint:(CGPoint)controlPoint {
    _cornerControlPoints[@(corner)] = [NSValue valueWithCGPoint:controlPoint];
}

#pragma mark - Super

- (void)layoutSublayers {
    [super layoutSublayers];
    
    CGFloat midHight = CGRectGetHeight(self.bounds) - _resizeInsets.top - _resizeInsets.bottom;
    CGFloat midWidth = CGRectGetWidth(self.bounds) - _resizeInsets.left - _resizeInsets.right;
    CGFloat rightX = CGRectGetWidth(self.bounds) - _resizeInsets.right;
    CGFloat bottomY = CGRectGetHeight(self.bounds) - _resizeInsets.bottom;
    
    self.topLeftLayer.frame = CGRectMake(0.0f, 0.0f, _resizeInsets.left, _resizeInsets.top);
    self.topLayer.frame = CGRectMake(_resizeInsets.left, 0.0f, midWidth, _resizeInsets.top);
    self.topRightLayer.frame = CGRectMake(rightX, 0.0f, _resizeInsets.right, _resizeInsets.top);
    
    self.leftLayer.frame = CGRectMake(0.0f, _resizeInsets.top, _resizeInsets.left, midHight);
    self.midLayer.frame = CGRectMake(_resizeInsets.left, _resizeInsets.top, midWidth, midHight);
    self.rightLayer.frame = CGRectMake(rightX, _resizeInsets.top, _resizeInsets.right, midHight);
    
    self.bottomLeftLayer.frame = CGRectMake(0.0f, bottomY, _resizeInsets.left, _resizeInsets.bottom);
    self.bottomLayer.frame = CGRectMake(_resizeInsets.left, bottomY, midWidth, _resizeInsets.bottom);
    self.bottomRightLayer.frame = CGRectMake(rightX, bottomY, _resizeInsets.right, _resizeInsets.bottom);
}

#pragma mark - Private

- (CAShapeLayer *)createLayer {
    CAShapeLayer *layer = CAShapeLayer.new;
    [self addSublayer:layer];
    return layer;
}

- (void)updateCorners {
    [_cornerControlPoints enumerateKeysAndObjectsUsingBlock:^(__kindof NSNumber * _Nonnull key, __kindof NSValue * _Nonnull obj, BOOL * _Nonnull stop) {
        UIRectCorner corner = [key unsignedIntegerValue];
        CGPoint controlPoint = obj.CGPointValue;
        switch (corner) {
            case UIRectCornerTopLeft: {
                UIBezierPath *path = UIBezierPath.new;
                [path moveToPoint:CGPointMake(0.0f, _resizeInsets.top)];
                [path addQuadCurveToPoint:CGPointMake(_resizeInsets.left, 0.0f) controlPoint:controlPoint];
                path.lineWidth = 1.0f;
                self.topLeftLayer.path = path.CGPath;
                self.topLeftLayer.strokeColor = UIColor.whiteColor.CGColor;
                self.topLeftLayer.fillColor = UIColor.clearColor.CGColor;
                break;
            }
            default:
                break;
        }
    }];
}

#pragma mark - Getter

- (CAShapeLayer *)topLeftLayer {
    if (!_topLeftLayer) {
        _topLeftLayer = [self createLayer];
    }
    return _topLeftLayer;
}

- (CAShapeLayer *)topLayer {
    if (!_topLayer) {
        _topLayer = [self createLayer];
    }
    return _topLayer;
}

- (CAShapeLayer *)topRightLayer {
    if (!_topRightLayer) {
        _topRightLayer = [self createLayer];
    }
    return _topRightLayer;
}

- (CAShapeLayer *)leftLayer {
    if (!_leftLayer) {
        _leftLayer = [self createLayer];
    }
    return _leftLayer;
}

- (CAShapeLayer *)midLayer {
    if (!_midLayer) {
        _midLayer = [self createLayer];
    }
    return _midLayer;
}

- (CAShapeLayer *)rightLayer {
    if (!_rightLayer) {
        _rightLayer = [self createLayer];
    }
    return _rightLayer;
}

- (CAShapeLayer *)bottomLeftLayer {
    if (!_bottomLeftLayer) {
        _bottomLeftLayer = [self createLayer];
    }
    return _bottomLeftLayer;
}

- (CAShapeLayer *)bottomLayer {
    if (!_bottomLayer) {
        _bottomLayer = [self createLayer];
    }
    return _bottomLayer;
}

- (CAShapeLayer *)bottomRightLayer {
    if (!_bottomRightLayer) {
        _bottomRightLayer = [self createLayer];
    }
    return _bottomRightLayer;
}

@end
