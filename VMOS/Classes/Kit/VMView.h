//
//  VMView.h
//  Pods-scrawl-ios
//
//  Created by ItghostFan on 2025/11/4.
//

#import <QuartzCore/QuartzCore.h>

#import <VMOS/VMGeometry.h>
#import "VMOS/VMKit.h"

NS_ASSUME_NONNULL_BEGIN

#if TARGET_OS_IPHONE
@interface VMView : UIView
#elif TARGET_OS_MAC
@interface VMView : NSView

// iOS
@property (strong, nonatomic) VMColor *backgroundColor;
@property (assign, nonatomic) BOOL userInteractionEnabled;

- (void)setNeedsDisplay;
- (void)setNeedsLayout;
- (void)layoutSubviews;

#endif // #if TARGET_OS_IPHONE

- (VMImage *)snapshot;
- (CGContextRef)currentContext;

@end

NS_ASSUME_NONNULL_END
