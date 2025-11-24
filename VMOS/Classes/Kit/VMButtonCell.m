//
//  VMButtonCell.m
//  Pods
//
//  Created by ItghostFan on 2025/11/23.
//

#import "VMButtonCell.h"

#import <VMOS/VMLabel.h>

@interface VMButtonCell ()
@property (weak, nonatomic) NSImageView *imageView;
@property (weak, nonatomic) VMLabel *titleLabel;
@end

@implementation VMButtonCell

- (void)setControlView:(NSView *)controlView {
    [super setControlView:controlView];
}

- (void)setImage:(NSImage *)image {
    [super setImage:image];
    self.imageView.image = image;
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    self.titleLabel.text = title;
}

- (void)setAttributedTitle:(NSAttributedString *)attributedTitle {
    [super setAttributedTitle:attributedTitle];
    self.titleLabel.attributedText = attributedTitle;
}

- (NSRect)drawingRectForBounds:(NSRect)rect {
    CGFloat imageLine = MAX(self.image.size.width, self.image.size.height);
    CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeZero];
    return CGRectMake(0.0f, 0.0f, imageLine + titleSize.width, MAX(imageLine, titleSize.height));
}

- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    if (self.image) {
        NSRect imageRect = [self imageRectForBounds:cellFrame];
        self.imageView.frame = imageRect;
    }
    if (self.title) {
        NSRect titleRect = [self titleRectForBounds:cellFrame];
        self.titleLabel.frame = titleRect;
    }
//    [super drawInteriorWithFrame:cellFrame inView:controlView];
}

#pragma mark - Getter

- (NSImageView *)imageView {
    if (_imageView) {
        return _imageView;
    }
    NSImageView *imageView = NSImageView.new;
    _imageView = imageView;
    _imageView.image = self.image;
    [self.controlView addSubview:_imageView];
    return imageView;
}

- (VMLabel *)titleLabel {
    if (_titleLabel) {
        return _titleLabel;
    }
    VMLabel *titleLabel = VMLabel.new;
    _titleLabel = titleLabel;
    if (self.attributedTitle) {
        _titleLabel.attributedText = self.attributedTitle;
    } else
    if (self.title) {
        _titleLabel.text = self.title;
    }
    [self.controlView addSubview:_titleLabel];
    return titleLabel;
}

@end
