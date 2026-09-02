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
#define VMImageJPEGRepresentation UIImageJPEGRepresentation
#define VMImagePNGRepresentation UIImagePNGRepresentation
#define VMFontWeight UIFontWeight
#define VMFontWeightUltraLight UIFontWeightUltraLight
#define VMFontWeightThin UIFontWeightThin
#define VMFontWeightLight UIFontWeightLight
#define VMFontWeightRegular UIFontWeightRegular
#define VMFontWeightMedium UIFontWeightMedium
#define VMFontWeightSemibold UIFontWeightSemibold
#define VMFontWeightBold UIFontWeightBold
#define VMFontWeightHeavy UIFontWeightHeavy
#define VMFontWeightBlack UIFontWeightBlack

#define VMImageResizingMode UIImageResizingMode
#define VMImageResizingModeStretch UIImageResizingModeStretch
#define VMImageResizingModeTile UIImageResizingModeTile

#define VMImageSymbolConfiguration UIImageSymbolConfiguration

#define VMImageSymbolScale UIImageSymbolScale
#define VMImageSymbolScaleDefault UIImageSymbolScaleDefault
#define VMImageSymbolScaleUnspecified UIImageSymbolScaleUnspecified
#define VMImageSymbolScaleSmall UIImageSymbolScaleSmall
#define VMImageSymbolScaleMedium UIImageSymbolScaleMedium
#define VMImageSymbolScaleLarge UIImageSymbolScaleLarge
typedef UIFont VMFont;
typedef UIImageView VMImageView;
typedef UIScreen VMScreen;

#define VMViewContentMode UIViewContentMode
#define VMViewContentModeScaleToFill UIViewContentModeScaleToFill
#define VMViewContentModeScaleAspectFit UIViewContentModeScaleAspectFit
#define VMViewContentModeScaleAspectFill UIViewContentModeScaleAspectFill
#define VMViewContentModeRedraw UIViewContentModeRedraw
#define VMViewContentModeCenter UIViewContentModeCenter
#define VMViewContentModeTop UIViewContentModeTop
#define VMViewContentModeBottom UIViewContentModeBottom
#define VMViewContentModeLeft UIViewContentModeLeft
#define VMViewContentModeRight UIViewContentModeRight
#define VMViewContentModeTopLeft UIViewContentModeTopLeft
#define VMViewContentModeTopRight UIViewContentModeTopRight
#define VMViewContentModeBottomLeft UIViewContentModeBottomLeft
#define VMViewContentModeBottomRight UIViewContentModeBottomRight

#elif TARGET_OS_MAC
typedef NSColor VMColor;
typedef NSBezierPath VMBezierPath;
typedef NSImage VMImage;
extern NSData * __nullable VMImagePNGRepresentation(VMImage * __nonnull image);
extern NSData * __nullable VMImageJPEGRepresentation(VMImage * __nonnull image, CGFloat compressionQuality);
#define VMFontWeight NSFontWeight
#define VMFontWeightUltraLight NSFontWeightUltraLight
#define VMFontWeightThin NSFontWeightThin
#define VMFontWeightLight NSFontWeightLight
#define VMFontWeightRegular NSFontWeightRegular
#define VMFontWeightMedium NSFontWeightMedium
#define VMFontWeightSemibold NSFontWeightSemibold
#define VMFontWeightBold NSFontWeightBold
#define VMFontWeightHeavy NSFontWeightHeavy
#define VMFontWeightBlack NSFontWeightBlack

#define VMImageResizingMode NSImageResizingMode
#define VMImageResizingModeStretch NSImageResizingModeStretch
#define VMImageResizingModeTile NSImageResizingModeTile

#define VMImageSymbolConfiguration NSImageSymbolConfiguration

#define VMImageSymbolScale NSImageSymbolScale
#define VMImageSymbolScaleSmall NSImageSymbolScaleSmall
#define VMImageSymbolScaleMedium NSImageSymbolScaleMedium
#define VMImageSymbolScaleLarge NSImageSymbolScaleLarge
typedef NSFont VMFont;
typedef NSImageView VMImageView;
typedef NSScreen VMScreen;

typedef NS_ENUM(NSInteger, VMViewContentMode) {
    VMViewContentModeScaleToFill = NSViewLayerContentsPlacementScaleAxesIndependently,
    VMViewContentModeScaleAspectFit = NSViewLayerContentsPlacementScaleProportionallyToFit,      // contents scaled to fit with fixed aspect. remainder is transparent
    VMViewContentModeScaleAspectFill = NSViewLayerContentsPlacementScaleProportionallyToFill,     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
    VMViewContentModeRedraw,              // redraw on bounds change (calls -setNeedsDisplay)
    VMViewContentModeCenter = NSViewLayerContentsPlacementCenter,              // contents remain same size. positioned adjusted.
    VMViewContentModeTop = NSViewLayerContentsPlacementTop,
    VMViewContentModeBottom = NSViewLayerContentsPlacementBottom,
    VMViewContentModeLeft = NSViewLayerContentsPlacementLeft,
    VMViewContentModeRight = NSViewLayerContentsPlacementRight,
    VMViewContentModeTopLeft = NSViewLayerContentsPlacementTopLeft,
    VMViewContentModeTopRight = NSViewLayerContentsPlacementTopRight,
    VMViewContentModeBottomLeft = NSViewLayerContentsPlacementBottomLeft,
    VMViewContentModeBottomRight = NSViewLayerContentsPlacementBottomRight,
};

#endif // #if TARGET_OS_IPHONE

#import <VMOS/NSScreen+UIKit.h>
#import <VMOS/VMFoundation.h>
#import <VMOS/NSValue+UIKit.h>
#import <VMOS/VMControlTypes.h>
#import <VMOS/NSView+UIKit.h>
#import <VMOS/VMControl.h>
//#import <VMOS/VMButton.h> // 不明白为什么这里会导致VMControl无法找到
#import <VMOS/VMView.h>
#import <VMOS/VMViewController.h>
#import <VMOS/VMViewController+AppKit.h>
#import <VMOS/NSImage+UIKit.h>
#import <VMOS/NSCollectionView+UIKit.h>
#import <VMOS/NSCollectionViewLayoutAttributes+UIKit.h>
#import <VMOS/VMCollectionViewCell.h>
#import <VMOS/VMCollectionView.h>
#import <VMOS/VMCollectionViewFlowLayout.h>
#import <VMOS/VMCollectionReusableView.h>
#import <VMOS/NSCollectionViewItem+UIKit.h>
#import <VMOS/NSIndexPath+UIKit.h>
#import <VMOS/VMTableView.h>
#import <VMOS/VMTableViewCell.h>
#import <VMOS/VMTableViewHeaderFooterView.h>
#import <VMOS/VMScrollView.h>
#import <VMOS/VMStackView.h>
#import <VMOS/VMColor+CSS.h>

//#endif /* VMKit_h */
