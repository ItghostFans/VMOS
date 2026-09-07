//
//  VMModel+Protected.h
//  Pods
//
//  Created by ItghostFan on 2026/9/7.
//

#import <VMOS/VMModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface VMModel ()

/// 从Dictionary初始化Model。
/// - Parameter dictionary: @{@"property": @"我是字段"}
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
