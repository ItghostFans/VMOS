//
//  VMControlTypes.h
//  Pods
//
//  Created by ItghostFan on 2025/11/24.
//

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#elif TARGET_OS_MAC
#import <AppKit/AppKit.h>
#endif // #if TARGET_OS_IPHONE

#ifndef VMControlTypes_h
#define VMControlTypes_h

#if TARGET_OS_IPHONE
typedef NS_ENUM(NSUInteger, VMImagePosition) {
    VMImagePositionNoImage        = 0,
    VMImagePositionImageOnly      = 1,
    VMImagePositionImageBelow     = 4,
    VMImagePositionImageAbove     = 5,
//    VMImagePositionImageOverlaps  = 6,
    VMImagePositionImageLeading   = 7,
    VMImagePositionImageTrailing  = 8,
};

typedef NS_OPTIONS(NSUInteger, VMControlState) {
    VMControlStateNormal       = UIControlStateNormal,
    VMControlStateHighlighted  = UIControlStateHighlighted,     // used when UIControl isHighlighted is set
    VMControlStateDisabled     = UIControlStateDisabled,
    VMControlStateSelected     = UIControlStateSelected,        // flag usable by app (see below)
    VMControlStateFocused      = UIControlStateFocused,         // Applicable only when the screen supports focus
    VMControlStateApplication  = UIControlStateApplication,     // additional flags available for application use
    VMControlStateReserved     = UIControlStateReserved,        // flags reserved for internal framework use
};

typedef NS_OPTIONS(NSUInteger, VMControlEvents) {
    VMControlEventTouchDown                                         = UIControlEventTouchDown,      // on all touch downs
    VMControlEventTouchDownRepeat                                   = UIControlEventTouchDownRepeat,      // on multiple touchdowns (tap count > 1)
    VMControlEventTouchDragInside                                   = UIControlEventTouchDragInside,
    VMControlEventTouchDragOutside                                  = UIControlEventTouchDragOutside,
    VMControlEventTouchDragEnter                                    = UIControlEventTouchDragEnter,
    VMControlEventTouchDragExit                                     = UIControlEventTouchDragExit,
    VMControlEventTouchUpInside                                     = UIControlEventTouchUpInside,
    VMControlEventTouchUpOutside                                    = UIControlEventTouchUpOutside,
    VMControlEventTouchCancel                                       = UIControlEventTouchCancel,

    VMControlEventValueChanged                                      = UIControlEventValueChanged,     // sliders, etc.
    VMControlEventPrimaryActionTriggered API_AVAILABLE(ios(9.0))    = UIControlEventPrimaryActionTriggered,     // semantic action: for buttons, etc.
    VMControlEventMenuActionTriggered API_AVAILABLE(ios(14.0)) API_UNAVAILABLE(watchos)      = UIControlEventMenuActionTriggered,     // triggered when the menu gesture fires but before the menu presents

    VMControlEventEditingDidBegin                                   = UIControlEventEditingDidBegin,     // UITextField
    VMControlEventEditingChanged                                    = UIControlEventEditingChanged,
    VMControlEventEditingDidEnd                                     = UIControlEventEditingDidEnd,
    VMControlEventEditingDidEndOnExit                               = UIControlEventEditingDidEndOnExit,     // 'return key' ending editing

    VMControlEventAllTouchEvents                                    = UIControlEventAllTouchEvents,  // for touch events
    VMControlEventAllEditingEvents                                  = UIControlEventAllEditingEvents,  // for UITextField
    VMControlEventApplicationReserved                               = UIControlEventApplicationReserved,  // range available for application use
    VMControlEventSystemReserved                                    = UIControlEventSystemReserved,  // range reserved for internal framework use
    VMControlEventAllEvents                                         = UIControlEventAllEvents,
};

#elif TARGET_OS_MAC

typedef NS_ENUM(NSUInteger, VMImagePosition) {
    VMImagePositionNoImage        = NSNoImage,
    VMImagePositionImageOnly      = NSImageOnly,
    VMImagePositionImageBelow     = NSImageBelow,
    VMImagePositionImageAbove     = NSImageAbove,
//    VMImagePositionImageOverlaps  = NSImageOverlaps,
    VMImagePositionImageLeading   = NSImageLeading,
    VMImagePositionImageTrailing  = NSImageTrailing,
};

typedef NS_OPTIONS(NSUInteger, VMControlState) {
    VMControlStateNormal       = 0,
    VMControlStateHighlighted  = 1 << 0,                    // used when UIControl isHighlighted is set
    VMControlStateDisabled     = 1 << 1,
    VMControlStateSelected     = 1 << 2,                    // flag usable by app (see below)
    VMControlStateFocused      = 1 << 3,                    // Applicable only when the screen supports focus
    VMControlStateApplication  = 0x00FF0000,                // additional flags available for application use
    VMControlStateReserved     = 0xFF000000,                // flags reserved for internal framework use
};

typedef NS_OPTIONS(NSUInteger, VMControlEvents) {
    VMControlEventTouchDown                                         = 1 <<  0,      // on all touch downs
    VMControlEventTouchDownRepeat                                   = 1 <<  1,      // on multiple touchdowns (tap count > 1)
    VMControlEventTouchDragInside                                   = 1 <<  2,
    VMControlEventTouchDragOutside                                  = 1 <<  3,
    VMControlEventTouchDragEnter                                    = 1 <<  4,
    VMControlEventTouchDragExit                                     = 1 <<  5,
    VMControlEventTouchUpInside                                     = 1 <<  6,
    VMControlEventTouchUpOutside                                    = 1 <<  7,
    VMControlEventTouchCancel                                       = 1 <<  8,

    VMControlEventValueChanged                                      = 1 << 12,     // sliders, etc.
    VMControlEventPrimaryActionTriggered                            = 1 << 13,     // semantic action: for buttons, etc.
    VMControlEventMenuActionTriggered                               = 1 << 14,     // triggered when the menu gesture fires but before the menu presents

    VMControlEventEditingDidBegin                                   = 1 << 16,     // UITextField
    VMControlEventEditingChanged                                    = 1 << 17,
    VMControlEventEditingDidEnd                                     = 1 << 18,
    VMControlEventEditingDidEndOnExit                               = 1 << 19,     // 'return key' ending editing

    VMControlEventAllTouchEvents                                    = 0x00000FFF,  // for touch events
    VMControlEventAllEditingEvents                                  = 0x000F0000,  // for UITextField
    VMControlEventApplicationReserved                               = 0x0F000000,  // range available for application use
    VMControlEventSystemReserved                                    = 0xF0000000,  // range reserved for internal framework use
    VMControlEventAllEvents                                         = 0xFFFFFFFF,
};
#endif // #if TARGET_OS_IPHONE

#endif /* VMControlTypes_h */
