//
//  VMControl.m
//  Pods
//
//  Created by ItghostFan on 2025/11/24.
//

#import <VMOS/VMControl.h>

@implementation VMControl

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (NSView *)hitTest:(NSPoint)point {
    if (!self.userInteractionEnabled) {
        return nil;
    }
    id view = [super hitTest:point];
    if (view) {
        NSLog(@"");
    }
    return view;
}

@end
