//
//  VMKit.h
//  Pods
//
//  Created by ItghostFan on 2025/11/5.
//

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#elif TARGET_OS_MAC
#import <AppKit/AppKit.h>
#endif // #if TARGET_OS_IPHONE

//#ifndef VMKit_h
//#define VMKit_h

#if TARGET_OS_IPHONE
typedef UIColor VMColor;
typedef UIBezierPath VMBezierPath;
typedef UIImage VMImage;
typedef UIFont VMFont;
typedef UIImageView VMImageView;
#elif TARGET_OS_MAC
typedef NSColor VMColor;
typedef NSBezierPath VMBezierPath;
typedef NSImage VMImage;
typedef NSFont VMFont;
typedef NSImageView VMImageView;
#endif // #if TARGET_OS_IPHONE

#import <VMOS/VMControlTypes.h>
#import <VMOS/VMView.h>

//#endif /* VMKit_h */
