//
//  VMCollectionView.h
//  Pods
//
//  Created by ItghostFan on 2025/12/2.
//

#import <VMOS/VMKit.h>

@class VMView;

#if TARGET_OS_IPHONE

typedef UICollectionViewUpdateItem VMCollectionViewUpdateItem;
typedef UICollectionViewLayoutAttributes VMCollectionViewLayoutAttributes;
#define VMCollectionElementKindSectionHeader UICollectionElementKindSectionHeader
#define VMCollectionElementKindSectionFooter UICollectionElementKindSectionFooter

typedef NS_ENUM(NSInteger, VMCollectionUpdateAction) {
    VMCollectionUpdateActionInsert = UICollectionUpdateActionInsert,
    VMCollectionUpdateActionDelete = UICollectionUpdateActionDelete,
    VMCollectionUpdateActionReload = UICollectionUpdateActionReload,
    VMCollectionUpdateActionMove = UICollectionUpdateActionMove,
    VMCollectionUpdateActionNone = UICollectionUpdateActionNone,
};

typedef NS_ENUM(NSInteger, VMCollectionViewScrollDirection) {
    VMCollectionViewScrollDirectionVertical = UICollectionViewScrollDirectionVertical,
    VMCollectionViewScrollDirectionHorizontal = UICollectionViewScrollDirectionHorizontal,
};

#elif TARGET_OS_MAC

typedef NSCollectionViewUpdateItem VMCollectionViewUpdateItem;
typedef NSCollectionViewLayoutAttributes VMCollectionViewLayoutAttributes;
#define VMCollectionElementKindSectionHeader NSCollectionElementKindSectionHeader
#define VMCollectionElementKindSectionFooter NSCollectionElementKindSectionFooter

typedef NS_ENUM(NSInteger, VMCollectionUpdateAction) {
    VMCollectionUpdateActionInsert = NSCollectionUpdateActionInsert,
    VMCollectionUpdateActionDelete = NSCollectionUpdateActionDelete,
    VMCollectionUpdateActionReload = NSCollectionUpdateActionReload,
    VMCollectionUpdateActionMove = NSCollectionUpdateActionMove,
    VMCollectionUpdateActionNone = NSCollectionUpdateActionNone,
};

typedef NS_ENUM(NSInteger, VMCollectionViewScrollDirection) {
    VMCollectionViewScrollDirectionVertical = NSCollectionViewScrollDirectionVertical,
    VMCollectionViewScrollDirectionHorizontal = NSCollectionViewScrollDirectionHorizontal,
};

#endif // #if TARGET_OS_IPHONE

NS_ASSUME_NONNULL_BEGIN

#if TARGET_OS_IPHONE

@interface VMCollectionView : UICollectionView

#elif TARGET_OS_MAC

@class VMCollectionReusableView;
@class VMCollectionViewCell;

@interface VMCollectionView : NSCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(NSCollectionViewLayout *)layout;
- (void)registerClass:(nullable Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;
- (void)registerClass:(nullable Class)viewClass forSupplementaryViewOfKind:(NSString *)elementKind withReuseIdentifier:(NSString *)identifier;
- (__kindof VMCollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;
- (__kindof VMCollectionReusableView *)dequeueReusableSupplementaryViewOfKind:(NSString *)elementKind withReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;
- (void)performBatchUpdates:(void (NS_NOESCAPE ^ _Nullable)(void))updates completion:(void (^ _Nullable)(BOOL finished))completion;
- (void)deselectItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

#endif // #if TARGET_OS_IPHONE

// 因为macOS和iOS的滚动视图是不一致的。
@property (weak, nonatomic, readonly) VMView *scrollView;

- (void)addToSuperview:(VMView *)superview;

@end

NS_ASSUME_NONNULL_END
