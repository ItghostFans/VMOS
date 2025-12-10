//
//  VMTableView.h
//  Pods
//
//  Created by ItghostFan on 2025/12/3.
//

#import <VMOS/VMKit.h>

NS_ASSUME_NONNULL_BEGIN

#if TARGET_OS_IPHONE

typedef NS_ENUM(NSUInteger, VMTableViewStyle) {
    VMTableViewStylePlain = UITableViewStylePlain,                  // regular table view
    VMTableViewStyleGrouped = UITableViewStyleGrouped,              // sections are grouped together
    VMTableViewStyleInsetGrouped = UITableViewStyleInsetGrouped,    // grouped sections are inset with rounded corners
};

typedef NS_ENUM(NSInteger, VMTableViewCellSeparatorStyle) {
    VMTableViewCellSeparatorStyleNone = UITableViewCellSeparatorStyleNone,
    VMTableViewCellSeparatorStyleSingleLine = UITableViewCellSeparatorStyleSingleLine,
};

typedef NS_ENUM(NSInteger, VMTableViewRowAnimation) {
    VMTableViewRowAnimationFade = UITableViewRowAnimationFade,
    VMTableViewRowAnimationRight = UITableViewRowAnimationRight,           // slide in from right (or out to right)
    VMTableViewRowAnimationLeft = UITableViewRowAnimationLeft,
    VMTableViewRowAnimationTop = UITableViewRowAnimationTop,
    VMTableViewRowAnimationBottom = UITableViewRowAnimationBottom,
    VMTableViewRowAnimationNone = UITableViewRowAnimationNone,            // available in iOS 3.0
    VMTableViewRowAnimationMiddle = UITableViewRowAnimationMiddle,          // available in iOS 3.2.  attempts to keep cell centered in the space it will/did occupy
    VMTableViewRowAnimationAutomatic = UITableViewRowAnimationAutomatic,  // available in iOS 5.0.  chooses an appropriate animation style for you
};

@interface VMTableView : UITableView
#elif TARGET_OS_MAC

typedef NS_ENUM(NSInteger, VMTableViewStyle) {
    VMTableViewStylePlain,          // regular table view
    VMTableViewStyleGrouped,        // sections are grouped together
    VMTableViewStyleInsetGrouped,   // grouped sections are inset with rounded corners
};

typedef NS_ENUM(NSInteger, VMTableViewCellSeparatorStyle) {
    VMTableViewCellSeparatorStyleNone,
    VMTableViewCellSeparatorStyleSingleLine,
};

typedef NS_ENUM(NSInteger, VMTableViewRowAnimation) {
    VMTableViewRowAnimationFade = NSTableViewAnimationEffectFade,
    VMTableViewRowAnimationRight = NSTableViewAnimationSlideRight,           // slide in from right (or out to right)
    VMTableViewRowAnimationLeft = NSTableViewAnimationSlideLeft,
    VMTableViewRowAnimationTop = NSTableViewAnimationSlideUp,
    VMTableViewRowAnimationBottom = NSTableViewAnimationSlideDown,
    VMTableViewRowAnimationNone = NSTableViewAnimationEffectNone,            // available in iOS 3.0
    VMTableViewRowAnimationMiddle = NSTableViewAnimationEffectGap,          // available in iOS 3.2.  attempts to keep cell centered in the space it will/did occupy
    VMTableViewRowAnimationAutomatic = 100  // available in iOS 5.0.  chooses an appropriate animation style for you
};

@interface VMTableView : NSTableView

@property (assign, nonatomic) VMTableViewCellSeparatorStyle separatorStyle;

// TODO: 以下内个只是暂时先兼容UIKit。
@property (assign, nonatomic) BOOL allowsSelection;
@property (assign, nonatomic) BOOL showsVerticalScrollIndicator;
@property (assign, nonatomic) BOOL showsHorizontalScrollIndicator;
@property (assign, nonatomic) CGFloat estimatedRowHeight;
@property (assign, nonatomic) CGFloat estimatedSectionFooterHeight;
@property (assign, nonatomic) CGFloat estimatedSectionHeaderHeight;

@property (nonatomic, strong, nullable) NSTableHeaderView *tableHeaderView;
@property (nonatomic, strong, nullable) VMView *tableFooterView;

- (instancetype)initWithFrame:(CGRect)frame style:(VMTableViewStyle)style;

- (void)registerClass:(nullable Class)cellClass forCellReuseIdentifier:(NSString *)identifier;
- (void)registerClass:(nullable Class)aClass forHeaderFooterViewReuseIdentifier:(NSString *)identifier;

- (void)performBatchUpdates:(void (NS_NOESCAPE ^ _Nullable)(void))updates completion:(void (^ _Nullable)(BOOL finished))completion;

- (void)insertSections:(NSIndexSet *)sections withRowAnimation:(VMTableViewRowAnimation)animation;
- (void)deleteSections:(NSIndexSet *)sections withRowAnimation:(VMTableViewRowAnimation)animation;
- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(VMTableViewRowAnimation)animation;

- (void)insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(VMTableViewRowAnimation)animation;
- (void)deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(VMTableViewRowAnimation)animation;
- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(VMTableViewRowAnimation)animation;

#endif // #if TARGET_OS_IPHONE

@end

NS_ASSUME_NONNULL_END
