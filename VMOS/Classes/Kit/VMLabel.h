//
//  VMLabel.h
//  Pods
//
//  Created by ItghostFan on 2025/11/23.
//

#import <VMOS/VMView.h>

NS_ASSUME_NONNULL_BEGIN

@interface VMLabel : VMView

@property (strong, nonatomic) NSAttributedString *attributedText;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) VMColor *textColor;
@property (strong, nonatomic) VMFont *font;
@property (assign, nonatomic) NSInteger numberOfLines;
@property (assign, nonatomic) NSLineBreakMode lineBreakMode;
@property (assign, nonatomic) NSTextAlignment textAlignment;

- (CGSize)sizeThatFits:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
