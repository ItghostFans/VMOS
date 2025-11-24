//
//  VMButtonCell.h
//  Pods
//
//  Created by ItghostFan on 2025/11/23.
//

#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC
#import <AppKit/AppKit.h>
#endif // #if TARGET_OS_IPHONE

NS_ASSUME_NONNULL_BEGIN

@class VMLabel;

API_AVAILABLE(macos(12.0))

@interface VMButtonCell : NSButtonCell

@property (weak, nonatomic, readonly) NSImageView *imageView;
@property (weak, nonatomic, readonly) VMLabel *titleLabel;

@end

NS_ASSUME_NONNULL_END
