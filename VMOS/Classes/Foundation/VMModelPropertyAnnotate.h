//
//  VMModelPropertyAnnotate.h
//  Pods
//
//  Created by ItghostFan on 2026/4/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VMModelPropertyAnnotate : NSObject

/// 属性的类。
/// NSString/NSNumber/NSArray。
@property (strong, nonatomic, readonly, nonnull) Class model;

/// model是否是VMModel类。
@property (assign, nonatomic, readonly) BOOL isModel;

/// 当model为NSArray时，elementLevel为的数组元素层级。
/// 如以下json的数组元素层级为3。
/// @"[
///     [
///         [
///             {

///             }
///         ]
///     ]
///   ]"
@property (assign, nonatomic, readonly) NSInteger elementLevel;

/// 当model为NSArray时，elementModel为VMModel派生类。
@property (strong, nonatomic, readonly, nonnull) Class elementModel;

- (instancetype)initWithAttribute:(NSString *)attribute;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
