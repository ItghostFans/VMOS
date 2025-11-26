//
//  VMButton.m
//  Pods
//
//  Created by ItghostFan on 2025/11/23.
//

#import "VMButton.h"

#import <VMOS/VMButtonCell.h>
#import <VMOS/VMLabel.h>

@interface VMButton ()
#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC
@property (strong, nonatomic) VMButtonCell *buttonCell;
#endif // #if TARGET_OS_IPHONE

@property (weak, nonatomic) VMImageView *imageView;
@property (weak, nonatomic) VMLabel *titleLabel;

@property (strong, nonatomic) NSMutableDictionary<__kindof NSNumber *, id> *stateTitles;
@property (strong, nonatomic) NSMutableDictionary<__kindof NSNumber *, id> *stateTitleColors;
@property (strong, nonatomic) NSMutableDictionary<__kindof NSNumber *, id> *stateTitleShadowColors;
@property (strong, nonatomic) NSMutableDictionary<__kindof NSNumber *, id> *stateImages;
@property (strong, nonatomic) NSMutableDictionary<__kindof NSNumber *, id> *stateBackgroundImages;
@property (strong, nonatomic) NSMutableDictionary<__kindof NSNumber *, NSMutableArray<__kindof NSInvocation *> *> *eventActions;
@end

@implementation VMButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _stateTitles = NSMutableDictionary.new;
        _stateImages = NSMutableDictionary.new;
        _stateTitleColors = NSMutableDictionary.new;
        _stateTitleShadowColors = NSMutableDictionary.new;
        
        _eventActions = NSMutableDictionary.new;
    }
    return self;
}

- (CGRect)frameOfItemSize:(CGSize)itemSize {
    CGSize contentSize = (CGSize){
        .width = CGRectGetWidth(self.bounds) - _contentEdgeInsets.left - _contentEdgeInsets.right,
        .height = CGRectGetHeight(self.bounds) - _contentEdgeInsets.top - _contentEdgeInsets.bottom
    };
    CGRect itemFrame = CGRectZero;
    if (itemSize.width < contentSize.width) {
        itemFrame.origin.x = (contentSize.width - itemSize.width) / 2;
        itemFrame.size.width = itemSize.width;
    } else {
        itemFrame.origin.x = _contentEdgeInsets.left;
        itemFrame.size.width = contentSize.width;
    }
    if (itemSize.height < contentSize.height) {
        itemFrame.origin.y = (contentSize.height - itemSize.height) / 2;
        itemFrame.size.height = itemSize.height;
    } else {
        itemFrame.origin.y = _contentEdgeInsets.top;
        itemFrame.size.height = contentSize.height;
    }
    return itemFrame;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    VMImagePosition imagePosition = [self realyImagePosition];
    switch (imagePosition) {
        case VMImagePositionNoImage: {
            self.titleLabel.frame = [self frameOfItemSize:[self.titleLabel sizeThatFits:CGSizeZero]];
            break;
        }
        case VMImagePositionImageOnly: {
            self.imageView.frame = [self frameOfItemSize:[self imageOfState:(VMControlState)self.state].size];
            break;
        }
        case VMImagePositionImageAbove:
        case VMImagePositionImageBelow: {
            CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeZero];
            CGSize imageSize = [self imageOfState:(VMControlState)self.state].size;
            CGSize contentSize = (CGSize){
                .width = CGRectGetWidth(self.bounds) - _contentEdgeInsets.left - _contentEdgeInsets.right,
                .height = CGRectGetHeight(self.bounds) - _contentEdgeInsets.top - _contentEdgeInsets.bottom
            };
            CGFloat contentWidth = MAX(titleSize.width, imageSize.width);
            CGFloat contentHeight = titleSize.height + _itemSpacing + imageSize.height;
            CGRect contentFrame = CGRectZero;
            
            CGRect titleFrame = CGRectZero;
            CGRect imageFrame = CGRectZero;
            
            if (contentWidth < contentSize.width) {
                contentFrame.origin.x = (contentSize.width - contentWidth) / 2;
                contentFrame.size.width = contentWidth;
            } else {
                contentFrame.origin.x = _contentEdgeInsets.left;
                contentFrame.size.width = contentSize.width;
            }
            
            contentFrame.origin.y = (contentSize.height - contentHeight) / 2 + _contentEdgeInsets.top;
            contentFrame.size.height = contentHeight;
            
            titleFrame = (CGRect){
                .origin = {(contentSize.width - titleSize.width) / 2 + _contentEdgeInsets.left, imagePosition == VMImagePositionImageBelow ? contentFrame.origin.y : CGRectGetMaxY(contentFrame) - titleSize.height},
                .size = {contentFrame.size.width, titleSize.height}
            };
            
            imageFrame = (CGRect){
                .origin = {(contentSize.width - imageSize.width) / 2 + _contentEdgeInsets.left, imagePosition == VMImagePositionImageAbove ? contentFrame.origin.y : CGRectGetMaxY(contentFrame) - imageSize.height},
                .size = {imageSize.width, imageSize.height}
            };
            
            self.titleLabel.frame = titleFrame;
            self.imageView.frame = imageFrame;
            
            break;
        }
        case VMImagePositionImageLeading:
        case VMImagePositionImageTrailing: {
            CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeZero];
            CGSize imageSize = [self imageOfState:(VMControlState)self.state].size;
            CGSize contentSize = (CGSize){
                .width = CGRectGetWidth(self.bounds) - _contentEdgeInsets.left - _contentEdgeInsets.right,
                .height = CGRectGetHeight(self.bounds) - _contentEdgeInsets.top - _contentEdgeInsets.bottom
            };
            CGFloat contentWidth = titleSize.width + _itemSpacing + imageSize.width;
            CGFloat contentHeight = MAX(titleSize.height, imageSize.height);
            CGRect contentFrame = CGRectZero;
            
            CGRect titleFrame = CGRectZero;
            CGRect imageFrame = CGRectZero;
            
            if (contentWidth < contentSize.width) {
                contentFrame.origin.x = (contentSize.width - contentWidth) / 2 + _contentEdgeInsets.left;
                contentFrame.size.width = contentWidth;
            } else {
                contentFrame.origin.x = _contentEdgeInsets.left;
                contentFrame.size.width = contentSize.width;
            }
            
            contentFrame.origin.y = (contentSize.height - contentHeight) / 2 + _contentEdgeInsets.top;
            contentFrame.size.height = contentHeight;
            
            titleFrame = (CGRect){
                .origin = {imagePosition == VMImagePositionImageTrailing ? contentFrame.origin.x : CGRectGetMaxX(contentFrame) - MIN(contentSize.width, titleSize.width), (contentSize.height - titleSize.height) / 2 + _contentEdgeInsets.top},
                .size = {MIN(contentSize.width, titleSize.width), MIN(contentSize.height, titleSize.height)}
            };
            
            imageFrame = (CGRect){
                .origin = {imagePosition == VMImagePositionImageLeading ? contentFrame.origin.x : CGRectGetMaxX(contentFrame) - MIN(contentSize.width, imageSize.width), (contentSize.height - imageSize.height) / 2 + _contentEdgeInsets.top},
                .size = {MIN(contentSize.width, imageSize.width), MIN(contentSize.width, imageSize.height)}
            };
            
            self.titleLabel.frame = titleFrame;
            self.imageView.frame = imageFrame;
            
            break;
        }
        default: {
            break;
        }
    }
}

#if TARGET_OS_IPHONE

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    VMControlState state = selected ? VMControlStateSelected : ~VMControlStateSelected;
    [self updateState:state];
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    VMControlState state = enabled ? ~VMControlStateDisabled : VMControlStateDisabled;
    [self updateState:state];
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    VMControlState state = highlighted ? VMControlStateHighlighted : ~VMControlStateHighlighted;
    [self updateState:state];
}

#elif TARGET_OS_MAC

+ (Class)cellClass {
    return VMButtonCell.class;
}

- (VMButtonCell *)buttonCell {
    return (VMButtonCell *)self.cell;
}

- (BOOL)isFlipped {
    return YES;
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (_selected) {
        _state |= VMControlStateSelected;
    } else {
        _state &= ~VMControlStateNormal;
    }
    [self updateState:_state];
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if (enabled) {
        _state &= ~VMControlStateDisabled;
    } else {
        _state |= VMControlStateDisabled;
    }
    [self updateState:_state];
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted) {
        _state |= VMControlStateHighlighted;
    } else {
        _state &= ~VMControlStateHighlighted;
    }
    [self updateState:_state];
}

#endif // #if TARGET_OS_IPHONE

- (CGSize)intrinsicContentSize {
    CGSize size = CGSizeZero;
    switch ([self realyImagePosition]) {
        case VMImagePositionNoImage: {
            size = [self.titleLabel sizeThatFits:CGSizeZero];
            break;
        }
        case VMImagePositionImageOnly: {
            size = [self imageOfState:(VMControlState)self.state].size;
            break;
        }
        case VMImagePositionImageAbove:
        case VMImagePositionImageBelow: {
            size = [self imageOfState:(VMControlState)self.state].size;
            CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeZero];
            size.width = MAX(titleSize.width, size.width);
            size.height += titleSize.height + self.itemSpacing;
            break;
        }
        case VMImagePositionImageLeading:
        case VMImagePositionImageTrailing: {
            size = [self imageOfState:(VMControlState)self.state].size;
            CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeZero];
            size.height = MAX(titleSize.height, size.height);
            size.width += titleSize.width + self.itemSpacing;
            break;
        }
        default: {
            break;
        }
    }
    size.width += self.contentEdgeInsets.left + self.contentEdgeInsets.right;
    size.height += self.contentEdgeInsets.top + self.contentEdgeInsets.bottom;
    return size;
}

- (void)setContentEdgeInsets:(VMEdgeInsets)contentEdgeInsets {
    _contentEdgeInsets = contentEdgeInsets;
    [self invalidateIntrinsicContentSize];
}

- (void)setItemSpacing:(CGFloat)itemSpacing {
    _itemSpacing = itemSpacing;
    [self invalidateIntrinsicContentSize];
}

- (void)setTitle:(nullable NSString *)title forState:(VMControlState)state {
    _stateTitles[@(state)] = title;
    [self updateState:state];
}

- (void)setTitleColor:(nullable VMColor *)color forState:(VMControlState)state {
    _stateTitleColors[@(state)] = color;
    [self updateState:state];
}

- (void)setTitleShadowColor:(nullable VMColor *)color forState:(VMControlState)state {
    _stateTitleShadowColors[@(state)] = color;
    [self updateState:state];
}

- (void)setImage:(nullable VMImage *)image forState:(VMControlState)state {
    _stateImages[@(state)] = image;
    [self updateState:state];
}

- (void)setBackgroundImage:(nullable VMImage *)image forState:(VMControlState)state {
    _stateBackgroundImages[@(state)] = image;
    [self updateState:state];
}

- (void)setAttributedTitle:(nullable NSAttributedString *)title forState:(VMControlState)state {
    _stateTitles[@(state)] = title;
    [self updateState:state];
}

- (void)addTarget:(nullable id)target action:(SEL)action forControlEvents:(VMControlEvents)controlEvents {
    if (controlEvents & VMControlEventTouchDown) {
        [self addTarget:target action:action forControlEvent:VMControlEventTouchDown];
    }
    if (controlEvents & VMControlEventTouchUpInside) {
        [self addTarget:target action:action forControlEvent:VMControlEventTouchUpInside];
    }
}

- (void)removeTarget:(nullable id)target action:(nullable SEL)action forControlEvents:(VMControlEvents)controlEvents {
    
}

#pragma mark - Private

- (id)titleOfState:(VMControlState)state {
    id title = self.stateTitles[@(state)];
    if (!title) {
        title = self.stateTitles[@(VMControlStateNormal)];
    }
    return title;
}

- (VMColor *)titleColorOfState:(VMControlState)state {
    VMColor *titleColor = self.stateTitleColors[@(state)];
    if (!titleColor) {
        titleColor = self.stateTitleColors[@(VMControlStateNormal)];
    }
    return titleColor;
}

- (VMColor *)titleShadowColorOfState:(VMControlState)state {
    VMColor *titleShadowColor = self.stateTitleShadowColors[@(state)];
    if (!titleShadowColor) {
        titleShadowColor = self.stateTitleShadowColors[@(VMControlStateNormal)];
    }
    return titleShadowColor;
}

- (VMImage *)imageOfState:(VMControlState)state {
    VMImage *image = self.stateImages[@(state)];
    if (!image) {
        image = self.stateImages[@(VMControlStateNormal)];
    }
    return image;
}

- (VMImage *)backgroundImageOfState:(VMControlState)state {
    VMImage *backgroundImage = self.stateBackgroundImages[@(state)];
    if (!backgroundImage) {
        backgroundImage = self.stateBackgroundImages[@(VMControlStateNormal)];
    }
    return backgroundImage;
}

- (VMImagePosition)realyImagePosition {
    VMImage *image = [self imageOfState:(VMControlState)self.state];
    id title = [self titleOfState:(VMControlState)self.state];
    VMImagePosition imagePosition = self.imagePosition;
    if (![title length] && image) {
        imagePosition = VMImagePositionImageOnly;
    }
    if ([title length] && !image) {
        imagePosition = VMImagePositionNoImage;
    }
    return imagePosition;
}

- (NSMutableArray *)actionsOfEvent:(VMControlEvents)event {
    NSMutableArray *actions = self.eventActions[@(event)];
    if (!actions) {
        actions = NSMutableArray.new;
        self.eventActions[@(event)] = actions;
    }
    return actions;
}

- (void)addTarget:(id)target action:(SEL)action forControlEvent:(VMControlEvents)event {
    NSMethodSignature *methodSignature = [[target class] instanceMethodSignatureForSelector:action];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    invocation.selector = action;
    invocation.target = target;
    NSString *selector = [NSString stringWithCString:sel_getName(action) encoding:(NSUTF8StringEncoding)];
    NSUInteger param = 2;
    NSRange range = [selector rangeOfString:@":"];
    if (range.location != NSNotFound) {
        [invocation setArgument:(void *)&self atIndex:param++];
    }
    [[self actionsOfEvent:event] addObject:invocation];
}

#pragma mark - Events

- (void)mouseDown:(NSEvent *)event {
    NSMutableArray<__kindof NSInvocation *> *actions = [self actionsOfEvent:(VMControlEventTouchDown)];
    [actions enumerateObjectsUsingBlock:^(__kindof NSInvocation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj invokeWithTarget:self];
    }];
}

- (void)mouseUp:(NSEvent *)event {
    CGPoint point = CGPointZero;
#if TARGET_OS_IPHONE
    for (NSTouch *touch in [event touchesForView:self]) {
        point = [touch locationInView:self];
        if (CGRectContainsPoint(self.bounds, point)) {
            break;
        }
    }
#elif TARGET_OS_MAC
    point = [self convertPoint:event.locationInWindow fromView:nil];
#endif // #if TARGET_OS_IPHONE
    NSMutableArray<__kindof NSInvocation *> *actions = [self actionsOfEvent:(CGRectContainsPoint(self.bounds, point) ? VMControlEventTouchUpInside : VMControlEventTouchUpOutside)];
    [actions enumerateObjectsUsingBlock:^(__kindof NSInvocation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj invoke];
    }];
}

#pragma mark - Update

- (void)updateState:(VMControlState)state {
    id title = [self titleOfState:state];
    if ([title isKindOfClass:NSString.class]) {
        self.titleLabel.text = title;
    } else
    if ([title isKindOfClass:NSAttributedString.class]) {
        self.titleLabel.attributedText = title;
    }
    
    self.titleLabel.textColor = [self titleColorOfState:state];
    
//        self.titleLabel.shadowColor = [self titleShadowColorOfState:state];
    
    self.imageView.image = [self imageOfState:state];
    
    [self backgroundImageOfState:state];
    [self invalidateIntrinsicContentSize];
}

#pragma mark - Getter

- (VMImageView *)imageView {
    if (_imageView) {
        return _imageView;
    }
    VMImageView *imageView = [VMImageView new];
    _imageView = imageView;
    [self addSubview:_imageView];
    return imageView;
}

- (VMLabel *)titleLabel {
    if (_titleLabel) {
        return _titleLabel;
    }
    VMLabel *titleLabel = VMLabel.new;
    _titleLabel = titleLabel;
    [self addSubview:_titleLabel];
    return titleLabel;
}

@end
