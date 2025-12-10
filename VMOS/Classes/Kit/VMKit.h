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
typedef UIScreen VMScreen;
#elif TARGET_OS_MAC
typedef NSColor VMColor;
typedef NSBezierPath VMBezierPath;
typedef NSImage VMImage;
typedef NSFont VMFont;
typedef NSImageView VMImageView;
typedef NSScreen VMScreen;
#endif // #if TARGET_OS_IPHONE

#import <VMOS/NSScreen+UIKit.h>
#import <VMOS/VMFoundation.h>
#import <VMOS/NSValue+UIKit.h>
#import <VMOS/VMControlTypes.h>
#import <VMOS/NSView+UIKit.h>
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

//#endif /* VMKit_h */
