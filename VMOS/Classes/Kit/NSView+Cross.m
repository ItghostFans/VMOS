//
//  NSView+Cross.m
//  Pods
//
//  Created by ItghostFan on 2025/11/25.
//

#import "NSView+Cross.h"

#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC

@implementation NSView (Cross)

- (VMImage *)snapshot {
    VMImage *snapshot = nil;
    NSBitmapImageRep *imageRep = [self bitmapImageRepForCachingDisplayInRect:self.bounds];
    imageRep.size = self.bounds.size;
    [self cacheDisplayInRect:self.bounds toBitmapImageRep:imageRep];
    snapshot = [[VMImage alloc] initWithSize:imageRep.size];
    [snapshot addRepresentation:imageRep];
    return snapshot;
}

- (CGContextRef)currentContext {
    return NSGraphicsContext.currentContext.CGContext;
}

@end
#endif // #if TARGET_OS_IPHONE
