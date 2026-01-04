//
//  NSView+UIKit.m
//  Pods
//
//  Created by ItghostFan on 2025/11/25.
//

#import "NSView+UIKit.h"

#import <VMOS/NSObject+Runtime.h>

#import <objc/runtime.h>
#if TARGET_OS_IPHONE

#elif TARGET_OS_MAC

@implementation NSView (UIKit)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self runtime_swizzleSel:@selector(initWithFrame:) newSel:@selector(initWithFrame_uikit:) cls:self];
        [self runtime_swizzleSel:@selector(layout) newSel:@selector(uikit_layout) cls:self];
        [self runtime_swizzleSel:@selector(hitTest:) newSel:@selector(uikit_hitTest:) cls:self];
//        [self runtime_swizzleSel:@selector(mouseDown:) newSel:@selector(uikit_mouseDown:) cls:self];
    });
}

#pragma mark - Swizzle

- (instancetype)initWithFrame_uikit:(CGRect)frame {
    if (self = [self initWithFrame_uikit:frame]) {
        self.wantsLayer = YES;
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)uikit_layout {
    [self uikit_layout];
    [self layoutSubviews];
}

- (NSView *)uikit_hitTest:(NSPoint)point {
    if (self.userInteractionEnabled) {
        return [self uikit_hitTest:point];
    }
    return nil;
}

- (void)uikit_mouseDown:(NSEvent *)event {
    if (!self.userInteractionEnabled) {
        return;
    }
    [self uikit_mouseDown:event];
}

#pragma mark - Public

- (void)setNeedsDisplay {
    [self setNeedsDisplay:YES];
}

- (void)setNeedsLayout {
    [self setNeedsLayout:YES];
}

- (void)layoutSubviews {
}

- (void)layoutIfNeeded {
    [self layoutSubtreeIfNeeded];
}

- (void)insertSubview:(NSView *)view atIndex:(NSInteger)index {
    NSView *subview = nil;
    if (index < self.subviews.count) {
        subview = [self.subviews objectAtIndex:index];
    }
    [self addSubview:view positioned:(NSWindowBelow) relativeTo:subview];
}

- (void)setBackgroundColor:(VMColor *)backgroundColor {
    self.layer.backgroundColor = backgroundColor.CGColor;
}

- (VMColor *)backgroundColor {
    CGColorRef backgroundColor = self.layer.backgroundColor;
    if (!backgroundColor) {
        return nil;
    }
    return [VMColor colorWithCGColor:self.layer.backgroundColor];
}

- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled {
    objc_setAssociatedObject(self, @selector(userInteractionEnabled), @(userInteractionEnabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)userInteractionEnabled {
    NSNumber *userInteractionEnabled = objc_getAssociatedObject(self, @selector(userInteractionEnabled));
    if (!userInteractionEnabled) {
        return YES;
    }
    return userInteractionEnabled.boolValue;
}

@end

#endif // #if TARGET_OS_IPHONE
