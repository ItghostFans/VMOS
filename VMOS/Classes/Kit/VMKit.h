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
#elif TARGET_OS_MAC
typedef NSColor VMColor;
typedef NSBezierPath VMBezierPath;
typedef NSImage VMImage;
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
