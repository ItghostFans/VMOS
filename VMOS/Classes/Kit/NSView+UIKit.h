//
//  NSView+UIKit.h
//  Pods
//
//  Created by ItghostFan on 2025/11/25.
//

#import <VMOS/VMKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSView (UIKit)

@property (strong, nonatomic) VMColor *backgroundColor;
@property (assign, nonatomic) BOOL userInteractionEnabled;

- (void)setNeedsDisplay;
- (void)setNeedsLayout;
- (void)layoutSubviews;

@end

NS_ASSUME_NONNULL_END
