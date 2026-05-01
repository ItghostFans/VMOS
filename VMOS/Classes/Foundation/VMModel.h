//
//  VMModel.h
//  Pods
//
//  Created by ItghostFan on 2026/4/23.
//

#import <Foundation/Foundation.h>

#import <VMOS/VMModelProperty.h>
#import <VMOS/VMModelProperty+Array.h>
#import <VMOS/VMModelProperty+Number.h>
#import <VMOS/VMModelProperty+String.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, VMMError) {
    VMMErrorSuccess = 0,
    VMMErrorInvalidJson = 1,    /// 无效的json串。
};

@protocol VMModel <NSObject>
@end

@interface NSObject (VMModel) <VMModel>
@end

@interface VMModel : NSObject <VMModel>

#pragma mark - Modeling

/// 从json字符串初始化Model。
/// - Parameters:
///   - json: 字符串 @"{\"property\": \”我是字段\"}"
///   - callback: 主线程回调，回调Model或者Error。
+ (void)modelWithJson:(NSString * _Nonnull)json
             callback:(void(^ _Nonnull)(VMModel * _Nullable model, NSError * _Nullable error))callback;

/// 从data二制数据初始化Model。
/// - Parameters:
///   - data: 二进制数据。
///   - callback: 主线程回调，回调Model或者Error。
+ (void)modelWithData:(NSData * _Nonnull)data
             callback:(void(^ _Nonnull)(VMModel * _Nullable model, NSError * _Nullable error))callback;

/// 从Dictionary初始化Model。
/// - Parameters:
///   - dictinary: @{@"property": @"我是字段"}
///   - callback: 主线程回调，回调Model或者Error。
+ (void)modelWithDictinary:(NSDictionary * _Nonnull)dictinary
                  callback:(void(^ _Nonnull)(VMModel * _Nullable model, NSError * _Nullable error))callback;

#pragma mark - JsonModeling

+ (void)dictionaryWithModel:(VMModel *)model callback:(void(^ _Nonnull)(NSDictionary * _Nullable dictionary, NSError * _Nullable error))callback;

+ (void)arrayWithModels:(NSArray<__kindof VMModel *> * _Nonnull)models callback:(void(^ _Nonnull)(NSArray<__kindof NSDictionary *> * _Nullable model))callback;

#pragma mark - Core

/// 判断是否VMModel类。
/// - Parameter model:
+ (BOOL)isModel:(Class)model;

/// 获取Model的属性信息。
/// - Parameters:
///   - model: Model。
///   - callback: 主线程回调，回调Model和对应的属性信息。
+ (void)propertiesOfModel:(Class _Nonnull)model
                 callback:(void(^ _Nonnull)(Class _Nonnull model, NSArray<__kindof VMModelProperty *> * _Nullable properties))callback;

@end

NS_ASSUME_NONNULL_END
