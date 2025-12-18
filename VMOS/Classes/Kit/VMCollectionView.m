//
//  VMCollectionView.m
//  Pods
//
//  Created by ItghostFan on 2025/12/2.
//

#import "VMCollectionView.h"

@implementation VMCollectionView

#if TARGET_OS_IPHONE

#elif TARGET_OS_MAC

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(NSCollectionViewLayout *)layout {
    if (self = [self initWithFrame:frame]) {
        self.collectionViewLayout = layout;
    }
    return self;
}

- (void)registerClass:(nullable Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier {
    [self registerClass:cellClass forItemWithIdentifier:identifier];
}

- (void)registerClass:(nullable Class)viewClass forSupplementaryViewOfKind:(NSString *)elementKind withReuseIdentifier:(NSString *)identifier {
    [self registerClass:viewClass forSupplementaryViewOfKind:elementKind withReuseIdentifier:identifier];
}

- (__kindof VMCollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return (VMCollectionViewCell *)[self makeItemWithIdentifier:identifier forIndexPath:indexPath];
}

- (__kindof VMCollectionReusableView *)dequeueReusableSupplementaryViewOfKind:(NSString *)elementKind withReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [self makeSupplementaryViewOfKind:elementKind withIdentifier:identifier forIndexPath:indexPath];
}

- (void)performBatchUpdates:(void (NS_NOESCAPE ^ _Nullable)(void))updates completion:(void (^ _Nullable)(BOOL finished))completion {
    [self performBatchUpdates:updates completionHandler:completion];
}

- (void)deselectItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
    [self deselectItemsAtIndexPaths:[NSSet setWithObject:indexPath]];
}

#endif // #if TARGET_OS_IPHONE

- (void)addToSuperview:(VMView *)superview {
#if TARGET_OS_IPHONE
    [superview addSubview:self];
    _scrollView = scrollView;
#elif TARGET_OS_MAC
    VMScrollView *scrollView = VMScrollView.new;
    [superview addSubview:scrollView];
    _scrollView = (VMView *)scrollView;
    scrollView.documentView = self;
#endif // #if TARGET_OS_IPHONE
}

@end
