//
//  VMStackView.h
//  Pods
//
//  Created by ItghostFan on 2025/12/31.
//

#import <VMOS/VMKit.h>

NS_ASSUME_NONNULL_BEGIN
#if TARGET_OS_IPHONE
typedef NS_ENUM(NSInteger, VMLayoutConstraintAxis) {
    VMLayoutConstraintAxisHorizontal = UILayoutConstraintAxisHorizontal,
    VMLayoutConstraintAxisVertical = UILayoutConstraintAxisVertical,
};

@interface VMStackView : UIStackView
#elif TARGET_OS_MAC
typedef NS_ENUM(NSInteger, VMLayoutConstraintAxis) {
    VMLayoutConstraintAxisHorizontal = NSUserInterfaceLayoutOrientationHorizontal,
    VMLayoutConstraintAxisVertical = NSUserInterfaceLayoutOrientationVertical,
};

@interface VMStackView : NSStackView
@property (assign, nonatomic) VMLayoutConstraintAxis axis;
#endif // #if TARGET_OS_IPHONE

@end

NS_ASSUME_NONNULL_END
