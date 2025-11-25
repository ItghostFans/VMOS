//
//  VMButton.h
//  Pods
//
//  Created by ItghostFan on 2025/11/23.
//

#import <VMOS/VMKit.h>
#import <VMOS/VMControl.h>

NS_ASSUME_NONNULL_BEGIN

@class VMLabel;

@interface VMButton : VMControl

@property (assign, nonatomic) VMImagePosition imagePosition;

@property (assign, nonatomic) VMEdgeInsets contentEdgeInsets;
@property (assign, nonatomic) CGFloat itemSpacing;

#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC
@property(assign, nonatomic, readonly) VMControlState state;
@property(assign, nonatomic, getter=isSelected) BOOL selected;
#endif // #if TARGET_OS_IPHONE

@property (weak, nonatomic, readonly) VMImageView *imageView;
@property (weak, nonatomic, readonly) VMLabel *titleLabel;

- (void)setTitle:(nullable NSString *)title forState:(VMControlState)state;
- (void)setTitleColor:(nullable VMColor *)color forState:(VMControlState)state;
- (void)setTitleShadowColor:(nullable VMColor *)color forState:(VMControlState)state;
- (void)setImage:(nullable VMImage *)image forState:(VMControlState)state;
- (void)setBackgroundImage:(nullable VMImage *)image forState:(VMControlState)state;
- (void)setAttributedTitle:(nullable NSAttributedString *)title forState:(VMControlState)state;

- (void)addTarget:(nullable id)target action:(SEL)action forControlEvents:(VMControlEvents)controlEvents;
- (void)removeTarget:(nullable id)target action:(nullable SEL)action forControlEvents:(VMControlEvents)controlEvents;

@end

NS_ASSUME_NONNULL_END
