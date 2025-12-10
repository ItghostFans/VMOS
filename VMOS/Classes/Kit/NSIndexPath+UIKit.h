//
//  NSIndexPath+UIKit.h
//  Pods
//
//  Created by ItghostFan on 2025/12/8.
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC

NS_ASSUME_NONNULL_BEGIN

@interface NSIndexPath (UIKit)

@property (nonatomic, readonly) NSInteger row;

+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END

#endif // #if TARGET_OS_IPHONE
