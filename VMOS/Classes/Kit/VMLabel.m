//
//  VMLabel.m
//  Pods
//
//  Created by ItghostFan on 2025/11/23.
//

#import "VMLabel.h"

@interface VMLabel () <NSSecureCoding>

@property (strong, nonatomic) NSTextContainer *textContainer;
@property (strong, nonatomic) NSLayoutManager *layoutManager;
@property (strong, nonatomic) NSTextStorage *textStorage;
@property (strong, nonatomic) NSMutableParagraphStyle *paragraphStyle;

@end

@implementation VMLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self load];
    }
    return self;
}

#pragma mark - UILabel

- (void)setAttributedText:(NSAttributedString *)attributedText {
    self.textStorage = [[NSTextStorage alloc] initWithAttributedString:attributedText];
    [self.textStorage addLayoutManager:_layoutManager];
    self.textAlignment = _paragraphStyle.alignment;
    [self setNeedsDisplay];
}

- (NSAttributedString *)attributedText {
    return self.textStorage.copy;
}

- (void)setText:(NSString *)text {
    NSMutableDictionary *attributes = NSMutableDictionary.new;
    attributes[NSFontAttributeName] = self.font;
    self.textStorage = [[NSTextStorage alloc] initWithString:text attributes:attributes];
    [self.textStorage addLayoutManager:_layoutManager];
    self.textAlignment = _paragraphStyle.alignment;
    [self setNeedsDisplay];
}

- (NSString *)text {
    return self.textStorage.string;
}

- (void)setTextColor:(VMColor *)textColor {
    _textColor = textColor;
    if (self.textStorage.length) {
        [self.textStorage enumerateAttributesInRange:NSMakeRange(0, self.textStorage.length)
                                             options:(NSAttributedStringEnumerationOptions)0
                                          usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
            if (!attrs[NSForegroundColorAttributeName]) {
                NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:attrs];
                attributes[NSForegroundColorAttributeName] = textColor;
                [self.textStorage setAttributes:attributes range:range];
            }
        }];
    }
    [self setNeedsDisplay];
}

- (void)setFont:(VMFont *)font {
    _font = font;
    if (self.textStorage.length) {
        [self.textStorage enumerateAttributesInRange:NSMakeRange(0, self.textStorage.length)
                                             options:(NSAttributedStringEnumerationOptions)0
                                          usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
            if (!attrs[NSFontAttributeName]) {
                NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:attrs];
                attributes[NSFontAttributeName] = font;
                [self.textStorage setAttributes:attributes range:range];
            }
        }];
    }
    [self setNeedsDisplay];
}

- (void)setNumberOfLines:(NSInteger)numberOfLines {
    _textContainer.maximumNumberOfLines = numberOfLines;
#if TARGET_OS_IPHONE
    if (numberOfLines == 1) {
        [self setContentHuggingPriority:(UILayoutPriorityDefaultHigh) forAxis:(UILayoutConstraintAxisVertical)];
        [self setContentCompressionResistancePriority:(UILayoutPriorityDefaultLow) forAxis:(UILayoutConstraintAxisVertical)];
    } else {
        [self setContentHuggingPriority:(UILayoutPriorityDefaultLow) forAxis:(UILayoutConstraintAxisVertical)];
        [self setContentCompressionResistancePriority:(UILayoutPriorityDefaultHigh) forAxis:(UILayoutConstraintAxisVertical)];
    }
#elif TARGET_OS_MAC
    if (numberOfLines == 1) {
        [self setContentHuggingPriority:(NSLayoutPriorityDefaultHigh) forOrientation:(NSLayoutConstraintOrientationVertical)];
        [self setContentCompressionResistancePriority:(NSLayoutPriorityDefaultLow) forOrientation:(NSLayoutConstraintOrientationVertical)];
    } else {
        [self setContentHuggingPriority:(NSLayoutPriorityDefaultLow) forOrientation:(NSLayoutConstraintOrientationVertical)];
        [self setContentCompressionResistancePriority:(NSLayoutPriorityDefaultHigh) forOrientation:(NSLayoutConstraintOrientationVertical)];
    }
#endif // #if TARGET_OS_IPHONE
    [self setNeedsLayout];
}

- (NSInteger)numberOfLines {
    return _textContainer.maximumNumberOfLines;
}

- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode {
    _textContainer.lineBreakMode = lineBreakMode;
    [self setNeedsLayout];
}

- (NSLineBreakMode)lineBreakMode {
    return _textContainer.lineBreakMode;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _paragraphStyle.alignment = textAlignment;
    if (self.textStorage.length) {
        [self.textStorage enumerateAttributesInRange:NSMakeRange(0, self.textStorage.length)
                                             options:(NSAttributedStringEnumerationOptions)0
                                          usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
            if (!attrs[NSParagraphStyleAttributeName]) {
                NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:attrs];
                attributes[NSParagraphStyleAttributeName] = self.paragraphStyle;
                [self.textStorage setAttributes:attributes range:range];
            }
        }];
    }
    [self setNeedsLayout];
}

- (NSTextAlignment)textAlignment {
    return _paragraphStyle.alignment;
}

#pragma mark - Super

- (CGSize)intrinsicContentSize {
    CGRect textRect = [_layoutManager boundingRectForGlyphRange:NSMakeRange(0, _layoutManager.numberOfGlyphs) inTextContainer:_textContainer];
    return CGSizeMake(ceil(textRect.size.width), ceil(textRect.size.height));
}

- (CGSize)sizeThatFits:(CGSize)size {
    _textContainer.size = size;
    CGRect textRect = [_layoutManager boundingRectForGlyphRange:NSMakeRange(0, _layoutManager.numberOfGlyphs) inTextContainer:_textContainer];
    _textContainer.size = self.bounds.size;
    return CGSizeMake(ceil(textRect.size.width), ceil(textRect.size.height));
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!CGSizeEqualToSize(_textContainer.size, self.bounds.size)) {
        _textContainer.size = self.bounds.size;
        [self invalidateIntrinsicContentSize];
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    rect = self.bounds;
    if (_layoutManager.numberOfGlyphs) {
        CGRect textRect = [_layoutManager boundingRectForGlyphRange:NSMakeRange(0, _layoutManager.numberOfGlyphs) inTextContainer:_textContainer];
        CGPoint drawPoint = CGPointMake(0.0f, (CGRectGetHeight(rect) - CGRectGetHeight(textRect)) / 2);
        [_layoutManager drawGlyphsForGlyphRange:NSMakeRange(0, _layoutManager.numberOfGlyphs) atPoint:drawPoint];
    }
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
    if (self.attributedText) {
        [coder encodeObject:self.attributedText forKey:NSStringFromSelector(@selector(attributedText))];
    }
    if (self.text) {
        [coder encodeObject:self.text forKey:NSStringFromSelector(@selector(text))];
    }
    if (self.textColor) {
        [coder encodeObject:self.textColor forKey:NSStringFromSelector(@selector(textColor))];
    }
    if (self.font) {
        [coder encodeObject:self.font forKey:NSStringFromSelector(@selector(font))];
    }
    [coder encodeInteger:self.numberOfLines forKey:NSStringFromSelector(@selector(numberOfLines))];
    [coder encodeInteger:self.lineBreakMode forKey:NSStringFromSelector(@selector(lineBreakMode))];
    [coder encodeInteger:self.textAlignment forKey:NSStringFromSelector(@selector(textAlignment))];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self load];
        NSAttributedString *attributedText = [coder decodeObjectForKey:NSStringFromSelector(@selector(attributedText))];
        if (attributedText) {
            self.attributedText = attributedText;
        }
        NSString *text = [coder decodeObjectForKey:NSStringFromSelector(@selector(text))];
        if (text) {
            self.text = text;
        }
        VMColor *textColor = [coder decodeObjectForKey:NSStringFromSelector(@selector(textColor))];
        if (textColor) {
            self.textColor = textColor;
        }
        VMFont *font = [coder decodeObjectForKey:NSStringFromSelector(@selector(font))];
        if (font) {
            self.font = font;
        }
        self.numberOfLines = [coder decodeIntegerForKey:NSStringFromSelector(@selector(numberOfLines))];
        self.lineBreakMode = [coder decodeIntegerForKey:NSStringFromSelector(@selector(lineBreakMode))];
        self.textAlignment = [coder decodeIntegerForKey:NSStringFromSelector(@selector(textAlignment))];
    }
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

#pragma mark - VMKLabel

- (NSAttributedString *)attributedTextAtPoint:(CGPoint)point {
    NSUInteger characterIndex = [self indexAtPoint:point];
    __block NSAttributedString *attributedText = nil;
    if (characterIndex != NSNotFound && characterIndex < _textStorage.length) {
        [_textStorage enumerateAttributesInRange:NSMakeRange(0, _textStorage.length) options:(NSAttributedStringEnumerationOptions)0 usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
            if (NSLocationInRange(characterIndex, range)) {
                attributedText = [self.textStorage attributedSubstringFromRange:range];
                *stop = YES;
            }
        }];
    }
    return attributedText;
}


- (NSAttributedString *)attributedCharacterAtPoint:(CGPoint)point {
    NSUInteger characterIndex = [self indexAtPoint:point];
    if (characterIndex != NSNotFound && characterIndex < _textStorage.length) {
        return [_textStorage attributedSubstringFromRange:NSMakeRange(characterIndex, 1)];
    }
    return nil;
}

#pragma mark - Private

- (void)load {
    _layoutManager = NSLayoutManager.new;
    _textContainer = [[NSTextContainer alloc] initWithSize:self.bounds.size];
    _textContainer.lineFragmentPadding = 0.0f;
    _paragraphStyle = NSMutableParagraphStyle.new;
    [_layoutManager addTextContainer:_textContainer];
    
#if TARGET_OS_IPHONE
    self.font = NSTextFieldLabel.appearance.font;
    self.textColor = UILabel.appearance.textColor;
    self.numberOfLines = UILabel.appearance.numberOfLines;
    self.lineBreakMode  = UILabel.appearance.lineBreakMode;
    
    switch ([UIView userInterfaceLayoutDirectionForSemanticContentAttribute:UIView.appearance.semanticContentAttribute]) {
        case UIUserInterfaceLayoutDirectionLeftToRight: {
            self.textAlignment = NSTextAlignmentNatural;
            _paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
            break;
        }
        case UIUserInterfaceLayoutDirectionRightToLeft: {
            self.textAlignment = NSTextAlignmentNatural;
            _paragraphStyle.baseWritingDirection = NSWritingDirectionRightToLeft;
            break;
        }
        default: {
            break;
        }
    }
#elif TARGET_OS_MAC
    self.font = [VMFont systemFontOfSize:[VMFont systemFontSize]];
    self.textColor = [VMColor controlTextColor];
    self.numberOfLines = 1;
    self.lineBreakMode = NSLineBreakByTruncatingTail;
    switch (self.userInterfaceLayoutDirection) {
        case NSUserInterfaceLayoutDirectionLeftToRight: {
            self.textAlignment = NSTextAlignmentNatural;
            _paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
            break;
        }
        case NSUserInterfaceLayoutDirectionRightToLeft: {
            self.textAlignment = NSTextAlignmentNatural;
            _paragraphStyle.baseWritingDirection = NSWritingDirectionRightToLeft;
            break;
        }
        default: {
            break;
        }
    }
#endif // #if TARGET_OS_IPHONE
    self.backgroundColor = [VMColor clearColor];
    self.userInteractionEnabled = YES;
}

- (NSUInteger)indexAtPoint:(CGPoint)point {
    if (!_textStorage.length) {
        return NSNotFound;
    }
    CGRect textRect = [_layoutManager boundingRectForGlyphRange:NSMakeRange(0, _layoutManager.numberOfGlyphs) inTextContainer:_textContainer];
    point.y -= CGRectGetMidY(self.bounds) - CGRectGetMidY(textRect);
    if (!CGRectContainsPoint(textRect, point)) {
        return NSNotFound;
    }
    CGFloat distance = 0.0f;
    NSUInteger characterIndex = [_layoutManager characterIndexForPoint:point inTextContainer:_textContainer fractionOfDistanceBetweenInsertionPoints:&distance];
    return characterIndex;
}

@end
