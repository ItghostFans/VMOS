//
//  VMScrollView.m
//  Pods
//
//  Created by ItghostFan on 2025/12/17.
//

#import "VMScrollView.h"
#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC

@implementation VMScrollView

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

@end

#endif // #if TARGET_OS_IPHONE
