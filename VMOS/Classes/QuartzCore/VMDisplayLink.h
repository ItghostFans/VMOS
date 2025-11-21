//
//  VMDisplayLink.h
//  Pods-scrawl-ios
//
//  Created by ItghostFan on 2025/11/14.
//

#if TARGET_OS_IPHONE
#import <QuartzCore/QuartzCore.h>
#elif TARGET_OS_MAC
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#endif // #if TARGET_OS_IPHONE

NS_ASSUME_NONNULL_BEGIN

#if TARGET_OS_IPHONE
typedef CADisplayLink VMDisplayLink;
#elif TARGET_OS_MAC
@interface VMDisplayLink : NSObject

// CADisplayLink

@property (assign, nonatomic) CAFrameRateRange preferredFrameRateRange;

+ (VMDisplayLink *)displayLinkWithTarget:(id)target selector:(SEL)selector;
- (void)addToRunLoop:(NSRunLoop *)runloop forMode:(NSRunLoopMode)mode;
- (void)removeFromRunLoop:(NSRunLoop *)runloop forMode:(NSRunLoopMode)mode;

@end

#endif // #if TARGET_OS_IPHONE

NS_ASSUME_NONNULL_END
