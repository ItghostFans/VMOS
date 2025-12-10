//
//  VMTableView.m
//  Pods
//
//  Created by ItghostFan on 2025/12/3.
//

#import "VMTableView.h"

@implementation VMTableView

#if TARGET_OS_IPHONE

#elif TARGET_OS_MAC

- (instancetype)initWithFrame:(CGRect)frame style:(VMTableViewStyle)style {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

- (NSTableHeaderView *)tableHeaderView {
    return self.headerView;
}

- (void)setTableHeaderView:(NSTableHeaderView *)tableHeaderView {
    self.headerView = tableHeaderView;
}

- (void)registerClass:(nullable Class)cellClass forCellReuseIdentifier:(NSString *)identifier {
}

- (void)registerClass:(nullable Class)aClass forHeaderFooterViewReuseIdentifier:(NSString *)identifier {
}

- (void)performBatchUpdates:(void (NS_NOESCAPE ^ _Nullable)(void))updates completion:(void (^ _Nullable)(BOOL finished))completion {
    if (updates) {
        [self beginUpdates];
        updates();
        [self endUpdates];
    }
    if (completion) {
        completion(YES);
    }
}

- (void)insertSections:(NSIndexSet *)sections withRowAnimation:(VMTableViewRowAnimation)animation {
}

- (void)deleteSections:(NSIndexSet *)sections withRowAnimation:(VMTableViewRowAnimation)animation {
}

- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(VMTableViewRowAnimation)animation {
}

- (void)insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(VMTableViewRowAnimation)animation {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wenum-conversion"
    [self insertRowsAtIndexes:[self indexesFromIndexPaths:indexPaths] withAnimation:animation];
#pragma clang diagnostic pop
}

- (void)deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(VMTableViewRowAnimation)animation {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wenum-conversion"
    [self removeRowsAtIndexes:[self indexesFromIndexPaths:indexPaths] withAnimation:animation];
#pragma clang diagnostic pop
}

- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(VMTableViewRowAnimation)animation {
    [self reloadDataForRowIndexes:[self indexesFromIndexPaths:indexPaths] columnIndexes:[self columnIndexesInRect:self.visibleRect]];
}

#pragma mark - Private

- (NSMutableIndexSet *)indexesFromIndexPaths:(NSArray<__kindof NSIndexPath *> *)indexPaths {
    NSMutableIndexSet *indexes = NSMutableIndexSet.new;
    for (NSIndexPath *indexPath in indexPaths) {
        [indexes addIndex:indexPath.row];
    }
    return indexes;
}

#endif // #if TARGET_OS_IPHONE

@end
