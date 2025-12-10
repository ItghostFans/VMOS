//
//  NSCollectionView+UIKit.h
//  Pods
//
//  Created by ItghostFan on 2025/12/10.
//

#import <VMOS/VMKit.h>

NS_ASSUME_NONNULL_BEGIN

#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC

@interface NSCollectionView (UIKit)

@property (assign, nonatomic) BOOL pagingEnabled;
@property (assign, nonatomic) VMEdgeInsets contentInset;

- (nullable __kindof NSCollectionView *)cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

#endif // #if TARGET_OS_IPHONE

NS_ASSUME_NONNULL_END
