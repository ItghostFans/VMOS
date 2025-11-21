//
//  VMDisplayLink.m
//  Pods-scrawl-ios
//
//  Created by ItghostFan on 2025/11/14.
//

#import "VMDisplayLink.h"

#import <VMOS/VMWeakifyProxy.h>

#if TARGET_OS_IPHONE

#elif TARGET_OS_MAC

static CVReturn displayLinkCallback(CVDisplayLinkRef displayLink,
                                    const CVTimeStamp *inNow,
                                    const CVTimeStamp *inOutputTime,
                                    CVOptionFlags flagsIn,
                                    CVOptionFlags *flagsOut,
                                    void *displayLinkContext);

@interface VMDisplayLink ()
@property (weak, nonatomic) id target;
@property (assign, nonatomic) SEL selector;

@property (nonatomic, assign) CVDisplayLinkRef displayLink;
@property (nonatomic, assign) CVTimeStamp outputTime;
@property (nonatomic, copy) NSRunLoopMode runloopMode;
@end

@implementation VMDisplayLink

- (void)dealloc {
    if (_displayLink) {
        CVDisplayLinkStop(_displayLink);
        CVDisplayLinkRelease(_displayLink);
        _displayLink = NULL;
    }
}

- (instancetype)initWithTarget:(id)target selector:(SEL)selector {
    if (self = [super init]) {
        _target = target;
        _selector = selector;
        VMWeakifyProxy *weakifyProxy = [[VMWeakifyProxy alloc] initWithTarget:self];
        CVDisplayLinkCreateWithActiveCGDisplays(&_displayLink);
        CVDisplayLinkSetOutputCallback(_displayLink, displayLinkCallback, (__bridge_retained void *)weakifyProxy);
    }
    return self;
}

+ (instancetype)displayLinkWithTarget:(id)target selector:(SEL)selector {
    VMDisplayLink *displayLink = [[VMDisplayLink alloc] initWithTarget:target selector:selector];
    return displayLink;
}

- (void)addToRunLoop:(NSRunLoop *)runloop forMode:(NSRunLoopMode)mode {
    self.runloopMode = mode;
    CVDisplayLinkStart(_displayLink);
}

- (void)removeFromRunLoop:(NSRunLoop *)runloop forMode:(NSRunLoopMode)mode {
    self.runloopMode = nil;
}

- (void)invalidate {
    CVDisplayLinkStop(self.displayLink);
}

#pragma mark - Private

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability"
- (void)onDisplayLink:(id)displayLink {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [_target performSelector:_selector withObject:self];
#pragma clang diagnostic pop
}
#pragma clang diagnostic pop

@end

static CVReturn displayLinkCallback(CVDisplayLinkRef displayLink,
                                    const CVTimeStamp *inNow,
                                    const CVTimeStamp *inOutputTime,
                                    CVOptionFlags flagsIn,
                                    CVOptionFlags *flagsOut,
                                    void *displayLinkContext) {
    VMWeakifyProxy *weakProxy = (__bridge VMWeakifyProxy *)displayLinkContext;
    VMDisplayLink *object = weakProxy.target;
    if (!object) {
        return kCVReturnSuccess;
    }
    NSString *runloopMode = object.runloopMode;
    if (![runloopMode isEqualToString:NSRunLoopCommonModes] &&
        ![runloopMode isEqualToString:NSRunLoop.mainRunLoop.currentMode]) {
        return kCVReturnSuccess;
    }
    CVTimeStamp outputTime = inOutputTime ? *inOutputTime : *inNow;
    void (^onDisplayLink)(VMDisplayLink *displayLink) = ^(VMDisplayLink *displayLink) {
        NSTimeInterval detal = ((NSTimeInterval)outputTime.videoTime / outputTime.videoTimeScale) - ((NSTimeInterval)displayLink.outputTime.videoTime / displayLink.outputTime.videoTimeScale);
        if (isnan(detal) || detal >= (1.0f / displayLink.preferredFrameRateRange.preferred)) {
            displayLink.outputTime = outputTime;
            [displayLink onDisplayLink:displayLink];
            NSLog(@"DisplayLink %@", @((NSTimeInterval)outputTime.videoTime / outputTime.videoTimeScale));
        }
    };
    if (NSThread.isMainThread) {
        onDisplayLink(object);
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            onDisplayLink(object);
        });
    }
    return kCVReturnSuccess;
}
#endif // #if TARGET_OS_IPHONE
