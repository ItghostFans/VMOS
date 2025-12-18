//
//  VMCollectionViewCell.h
//  Pods
//
//  Created by ItghostFan on 2025/12/10.
//

#import <VMOS/VMKit.h>

NS_ASSUME_NONNULL_BEGIN
#if TARGET_OS_IPHONE
@interface VMCollectionViewCell : UICollectionViewCell
#elif TARGET_OS_MAC
@interface VMCollectionViewCell : NSCollectionViewItem

- (instancetype)initWithFrame:(CGRect)frame;

#endif // #if TARGET_OS_IPHONE

@end

NS_ASSUME_NONNULL_END
