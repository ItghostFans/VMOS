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
/// - Note: 这里要注意，是VMModel的子类来调用。
/// - Parameters:
///   - json: 字符串 @"{\"property\": \”我是字段\"}"。
///   - queue: （Option）派发的队列。为空则在主线程回调callback。
///   - callback: 回调Model或者Error。
+ (void)modelWithJson:(NSString * _Nonnull)json
                queue:(dispatch_queue_t _Nullable)queue
             callback:(void(^ _Nonnull)(VMModel * _Nullable model, NSError * _Nullable error))callback;

/// 从data二制数据初始化Model。
/// - Note: 这里要注意，是VMModel的子类来调用。
/// - Parameters:
///   - data: 二进制数据。
///   - queue: （Option）派发的队列。为空则在主线程回调callback。
///   - callback: 回调Model或者Error。
+ (void)modelWithData:(NSData * _Nonnull)data
                queue:(dispatch_queue_t _Nullable)queue
             callback:(void(^ _Nonnull)(VMModel * _Nullable model, NSError * _Nullable error))callback;

/// 从Dictionary初始化Model。
/// - Note: 这里要注意，是VMModel的子类来调用。
/// - Parameters:
///   - dictinary: @{@"property": @"我是字段"}
///   - queue: （Option）派发的队列。为空则在主线程回调callback。
///   - callback: 回调Model或者Error。
+ (void)modelWithDictinary:(NSDictionary * _Nonnull)dictinary
                     queue:(dispatch_queue_t _Nullable)queue
                  callback:(void(^ _Nonnull)(VMModel * _Nullable model, NSError * _Nullable error))callback;

#pragma mark - JsonModeling

/// 将Model转Dictionary。
/// - Parameters:
///   - model: VMModel
///   - queue: （Option）派发的队列。为空则在主线程回调callback。
///   - callback: 回调Dictionary。
+ (void)dictionaryWithModel:(VMModel *)model
                      queue:(dispatch_queue_t _Nullable)queue
                   callback:(void(^ _Nonnull)(NSDictionary * _Nullable dictionary, NSError * _Nullable error))callback;

/// 将Model数组转json 数组。
/// - Parameters:
///   - models: VMModels。
///   - queue: （Option）派发的队列。为空则在主线程回调callback。
///   - callback: 回调Dictionarys。
+ (void)arrayWithModels:(NSArray<__kindof VMModel *> * _Nonnull)models
                queue:(dispatch_queue_t _Nullable)queue
               callback:(void(^ _Nonnull)(NSArray<__kindof NSDictionary *> * _Nullable model))callback;

#pragma mark - Core

/// 判断是否VMModel类。
/// - Parameter model:
+ (BOOL)isModel:(Class)model;

/// 获取Model的属性信息。
/// - Parameters:
///   - model: Model。
///   - queue: （Option）派发的队列。为空则在主线程回调callback。
///   - callback: 回调Model和对应的属性信息。
+ (void)propertiesOfModel:(Class _Nonnull)model
                    queue:(dispatch_queue_t _Nullable)queue
                 callback:(void(^ _Nonnull)(Class _Nonnull model, NSArray<__kindof VMModelProperty *> * _Nullable properties))callback;

@end

NS_ASSUME_NONNULL_END
