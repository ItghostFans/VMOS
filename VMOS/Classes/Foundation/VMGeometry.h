//
//  VMGeometry.h
//  Pods
//
//  Created by ItghostFan on 2025/11/5.
//

#if TARGET_OS_IPHONE
#import <UIKit/UIGeometry.h>
#elif TARGET_OS_MAC
#import <Foundation/NSGeometry.h>
#endif // #if TARGET_OS_IPHONE

#ifndef VMGeometry_h
#define VMGeometry_h

#if TARGET_OS_IPHONE

typedef NS_OPTIONS(NSUInteger, VMRectCorner) {
    VMRectCornerTopLeft     = UIRectCornerTopLeft,
    VMRectCornerTopRight    = UIRectCornerTopRight,
    VMRectCornerBottomLeft  = UIRectCornerBottomLeft,
    VMRectCornerBottomRight = UIRectCornerBottomRight,
    VMRectCornerAllCorners  = UIRectCornerAllCorners,
};

typedef UIEdgeInsets VMEdgeInsets;
#define VMEdgeInsetsMake UIEdgeInsetsMake
#define VMEdgeInsetsZero UIEdgeInsetsZero
#define VMEdgeInsetsEqualToEdgeInsets UIEdgeInsetsEqualToEdgeInsets
#elif TARGET_OS_MAC

typedef NS_OPTIONS(NSUInteger, VMRectCorner) {
    VMRectCornerTopLeft     = 1 << 0,
    VMRectCornerTopRight    = 1 << 1,
    VMRectCornerBottomLeft  = 1 << 2,
    VMRectCornerBottomRight = 1 << 3,
    VMRectCornerAllCorners  = ~0UL,
};

typedef NSEdgeInsets VMEdgeInsets;
#define VMEdgeInsetsMake NSEdgeInsetsMake
#define VMEdgeInsetsZero NSEdgeInsetsZero
#define VMEdgeInsetsEqualToEdgeInsets NSEdgeInsetsEqual
#endif // #if TARGET_OS_IPHONE

#endif /* VMGeometry_h */
