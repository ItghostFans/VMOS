//
//  VMView.m
//  Pods-scrawl-ios
//
//  Created by ItghostFan on 2025/11/4.
//

#import "VMView.h"

@implementation VMView

#pragma mark - Super

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC
        self.wantsLayer = YES;
        self.userInteractionEnabled = YES;
#endif // #if TARGET_OS_IPHONE
    }
    return self;
}

#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC
- (BOOL)isFlipped {
    return YES;
}

- (void)setNeedsDisplay {
    [self setNeedsDisplay:YES];
}

- (void)setNeedsLayout {
    [self setNeedsLayout:YES];
}

- (void)layout {
    [super layout];
    [self layoutSubviews];
}

- (void)layoutSubviews {
}

- (void)setBackgroundColor:(VMColor *)backgroundColor {
    _backgroundColor = backgroundColor;
    self.layer.backgroundColor = backgroundColor.CGColor;
}

- (NSView *)hitTest:(NSPoint)point {
    if (!self.userInteractionEnabled) {
        return nil;
    }
    return [super hitTest:point];
}

- (void)mouseDown:(NSEvent *)event {
    if (!self.userInteractionEnabled) {
        return;
    }
    [super mouseDown:event];
}

#endif // #if TARGET_OS_IPHONE

#pragma mark - VMKit

- (VMImage *)snapshot {
    VMImage *snapshot = nil;
#if TARGET_OS_IPHONE
    UIGraphicsImageRenderer *render = [[UIGraphicsImageRenderer alloc] initWithSize:self.frame.size
                                                                             format:UIGraphicsImageRendererFormat.defaultFormat];
    snapshot = [render imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
        [self drawLayer:self.layer inContext:rendererContext.CGContext];
    }];
#elif TARGET_OS_MAC
    NSBitmapImageRep *imageRep = [self bitmapImageRepForCachingDisplayInRect:self.bounds];
    imageRep.size = self.bounds.size;
    [self cacheDisplayInRect:self.bounds toBitmapImageRep:imageRep];
    snapshot = [[VMImage alloc] initWithSize:imageRep.size];
    [snapshot addRepresentation:imageRep];
#endif // #if TARGET_OS_IPHONE
    return snapshot;
}

- (CGContextRef)currentContext {
#if TARGET_OS_IPHONE
    return UIGraphicsGetCurrentContext();
#elif TARGET_OS_MAC
    return NSGraphicsContext.currentContext.CGContext;
#endif // #if TARGET_OS_IPHONE
}

@end
