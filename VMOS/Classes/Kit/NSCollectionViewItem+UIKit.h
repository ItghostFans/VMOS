//
//  NSCollectionViewItem+UIKit.h
//  Pods
//
//  Created by ItghostFan on 2025/12/2.
//

#import <VMOS/VMKit.h>

#if TARGET_OS_IPHONE

#elif TARGET_OS_MAC

@class VMView;

NS_ASSUME_NONNULL_BEGIN

@interface NSCollectionViewItem (UIKit)
@property (weak, nonatomic, readonly) NSView *contentView;
@end

NS_ASSUME_NONNULL_END

#endif // #if TARGET_OS_IPHONE
