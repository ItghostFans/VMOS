//
//  VMScrollView.m
//  Pods
//
//  Created by ItghostFan on 2025/12/17.
//

#import "VMScrollView.h"

@implementation VMScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
        self.hasVerticalScroller = YES;
        self.verticalScrollElasticity = NSScrollElasticityAutomatic;
        self.horizontalScrollElasticity = NSScrollElasticityAutomatic;
        self.autoresizesSubviews = YES;
        self.scrollsDynamically = YES;
        self.usesPredominantAxisScrolling = NO;
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
//    self.documentView.frame = self.bounds;
}

@end
