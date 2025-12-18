//
//  VMTableView.m
//  Pods
//
//  Created by ItghostFan on 2025/12/3.
//

#import "VMTableView.h"

#import <VMOS/NSBundle+Cross.h>

@implementation VMTableView

#if TARGET_OS_IPHONE

#elif TARGET_OS_MAC

- (instancetype)initWithFrame:(CGRect)frame style:(VMTableViewStyle)style {
    if (self = [super initWithFrame:frame]) {
        NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:@""];
        [self addTableColumn:column];
        self.allowsColumnResizing = YES;
        self.style = NSTableViewStyleFullWidth;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableColumns.firstObject.width = CGRectGetWidth(self.bounds);
}

- (NSTableHeaderView *)tableHeaderView {
    return self.headerView;
}

- (void)setTableHeaderView:(NSTableHeaderView *)tableHeaderView {
    self.headerView = tableHeaderView;
}

- (void)registerClass:(nullable Class)cellClass forCellReuseIdentifier:(NSString *)identifier {
    NSArray<__kindof NSBundle *> *allBundles = NSBundle.allBizBundles;
    for (NSBundle *cellBundle in allBundles) {
        @try {
            NSNib *cellXib = [[NSNib alloc] initWithNibNamed:identifier bundle:cellBundle];
            [self registerNib:cellXib forIdentifier:identifier];
            return;
        } @catch (NSException *exception) {
        } @finally {
        }
    }
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

- (void)addToSuperview:(VMView *)superview {
#if TARGET_OS_IPHONE
    [superview addSubview:self];
    _scrollView = scrollView;
#elif TARGET_OS_MAC
    VMScrollView *scrollView = VMScrollView.new;
    [superview addSubview:scrollView];
    _scrollView = (VMView *)scrollView;
    scrollView.documentView = self;
//    [superview addSubview:self];
//    _scrollView = (VMView *)self;
#endif // #if TARGET_OS_IPHONE
}

@end
