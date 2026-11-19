//
//  VMScrollView.m
//  Pods
//
//  Created by ItghostFan on 2025/12/17.
//

#import "VMScrollView.h"

@implementation VMScrollView

- (void)setView:(VMView *)view {
#if TARGET_OS_IPHONE
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    [self addSubview:view];
#elif TARGET_OS_MAC
    self.documentView = view;
#endif // #if TARGET_OS_IPHONE
}

- (VMView *)view {
#if TARGET_OS_IPHONE
    return self.subviews.firstObject;
#elif TARGET_OS_MAC
    return self.documentView;
#endif // #if TARGET_OS_IPHONE
}

#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
        self.hasVerticalScroller = NO;
        self.verticalScrollElasticity = NSScrollElasticityAutomatic;
        self.horizontalScrollElasticity = NSScrollElasticityAutomatic;
        self.autoresizesSubviews = NO;
        self.scrollsDynamically = NO;
        self.usesPredominantAxisScrolling = NO;
        self.drawsBackground = NO;
        self.backgroundColor = [VMColor clearColor];
    }
    return self;
}

//- (void)setDocumentView:(__kindof NSView *)documentView {
//    [super setDocumentView:documentView];
////    documentView.frame = self.bounds;
////    self.hasVerticalScroller = YES;
////    self.verticalScrollElasticity = NSScrollElasticityAutomatic;
////    self.horizontalScrollElasticity = NSScrollElasticityAutomatic;
////    self.autoresizesSubviews = YES;
////    self.scrollsDynamically = YES;
////    self.usesPredominantAxisScrolling = NO;
//}

- (void)layout {
    [super layout];
    // 这里是为了保持跟UITableView一致的交互逻辑。
    if ([self.documentView isKindOfClass:VMTableView.class]) {
        VMTableView *tableView = (VMTableView *)self.documentView;
        if (tableView.tableColumns.count < 2) {
            CGRect documentFrame = tableView.frame;
            documentFrame.size.width = CGRectGetWidth(self.bounds);
            tableView.frame = documentFrame;
        }
    }
}

- (void)scrollWheel:(NSEvent *)event {
    [super scrollWheel:event];
    
    if (self.horizontalScrollElasticity == NSScrollElasticityNone &&
        self.verticalScrollElasticity == NSScrollElasticityNone) {
        NSClipView *clipView = self.contentView;
        NSView *documentView = self.documentView;
        if (!documentView) {
            return;
        }
        
        NSRect bounds = clipView.bounds;
        CGFloat maxX = MAX(0, documentView.frame.size.width - bounds.size.width);
        CGFloat maxY = MAX(0, documentView.frame.size.height - bounds.size.height);
        
        CGFloat x = MAX(0, MIN(bounds.origin.x, maxX));
        CGFloat y = MAX(0, MIN(bounds.origin.y, maxY));
        
        if (x != bounds.origin.x || y != bounds.origin.y) {
            [clipView setBoundsOrigin:NSMakePoint(x, y)];
            [self reflectScrolledClipView:clipView];
        }
    }
}

#endif // #if TARGET_OS_IPHONE

@end
