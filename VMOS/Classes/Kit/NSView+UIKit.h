//
//  NSView+UIKit.h
//  Pods
//
//  Created by ItghostFan on 2025/11/25.
//

#import <VMOS/VMKit.h>

#if TARGET_OS_IPHONE

#elif TARGET_OS_MAC

NS_ASSUME_NONNULL_BEGIN

@interface NSView (UIKit)

@property (strong, nonatomic) VMColor *backgroundColor;
@property (assign, nonatomic) BOOL userInteractionEnabled;

- (void)setNeedsDisplay;
- (void)setNeedsLayout;
- (void)layoutSubviews;
- (void)layoutIfNeeded;

- (void)insertSubview:(NSView *)view atIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END

#endif // #if TARGET_OS_IPHONE
