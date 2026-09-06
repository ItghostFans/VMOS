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

/// 只要VMModel作为了数组元素，他的子孙后代就必须要注册进来。
@protocol VMElement <NSObject>

@optional

/// 定义这个元素的所有子类，因为要用来注册属性，进行异步解析。
+ (NSMutableArray *)subclasses;

///// 将当前类注册进subclasses中。
///// - Parameter cls: 元素类。
//+ (void)registerClass:(Class)cls;

@end

/// 如果Property实现VMModel协议，那就需要实现Model转换方法。
/// - Note:
/// - (void)vm_set{property}Json:(id)json
/// - (id)vm_getJson{property}
@protocol VMModel <VMElement>
@end

@interface NSObject (VMModel) <VMModel>
@end

/// 可存储Model。
/// - Note:
///     readonly的Property不能保存。
@interface VMModel : NSObject <VMModel, NSCopying>

/// 属性映射表。
/// - Agent:
///     - 要使用GCD: Dispatch Once来限制全局变量，保证这里只创建一次映射表。
/// - Note: @{propertyName: jsonKey}
@property (strong, nonatomic, class, nullable, readonly) NSDictionary *propertiesMapping;

#pragma mark - Modeling

/// 从json字符串初始化Model。
/// - Agent:
///   - 1、针对NSArray<NSNumber>类似这种类型Property，在使用@[]数组时，需要加上(NSArray<NSNumber> *)转换，避免编译警告。
///   - 2、针对NSArray<NSNumber>类似这种类型Property，如果使用NSArray *变量，也务必加上<NSNumber>，避免编译警告。
/// - Note: 这里要注意，是VMModel的子类来调用。
/// - Parameters:
///   - json: 字符串 @"{\"property\": \”我是字段\"}"。
///   - queue: (Option) 派发的队列。为空则在主线程回调callback。
///   - callback: 回调Model或者Error。
+ (void)modelWithJson:(NSString * _Nonnull)json
                queue:(dispatch_queue_t _Nullable)queue
             callback:(void(^ _Nonnull)(VMModel * _Nullable model, NSError * _Nullable error))callback;

/// 从data数据初始化Model。
/// - Note: 这里要注意，是VMModel的子类来调用。
/// - Parameters:
///   - data: 二进制数据。
///   - queue: (Option) 派发的队列。为空则在主线程回调callback。
///   - callback: 回调Model或者Error。
+ (void)modelWithData:(NSData * _Nonnull)data
                queue:(dispatch_queue_t _Nullable)queue
             callback:(void(^ _Nonnull)(VMModel * _Nullable model, NSError * _Nullable error))callback;

/// 从Json字符串初始化Models。
/// - Note: 这里要注意，是VMModel的子类来调用。
/// - Parameters:
///   - json: Json字符串。
///   - queue: (Option) 派发的队列。为空则在主线程回调callback。
///   - callback: 回调Models或者Error。
+ (void)modelsWithJson:(NSString * _Nonnull)json
                 queue:(dispatch_queue_t _Nullable)queue
              callback:(void(^ _Nonnull)(NSArray<__kindof VMModel *> * _Nullable models, NSError * _Nullable error))callback;

/// 从data数据初始化Models。
/// - Note: 这里要注意，是VMModel的子类来调用。
/// - Parameters:
///   - data: 二进制数据。
///   - queue: (Option) 派发的队列。为空则在主线程回调callback。
///   - callback: 回调Models或者Error。
+ (void)modelsWithData:(NSData * _Nonnull)data
                 queue:(dispatch_queue_t _Nullable)queue
              callback:(void(^ _Nonnull)(NSArray<__kindof VMModel *> * _Nullable models, NSError * _Nullable error))callback;

/// 从Dictionary初始化Model。
/// - Note: 这里要注意，是VMModel的子类来调用。
/// - Parameters:
///   - dictinary: @{@"property": @"我是字段"}
///   - queue: (Option) 派发的队列。为空则在主线程回调callback。
///   - callback: 回调Model或者Error。
+ (void)modelWithDictinary:(NSDictionary * _Nonnull)dictinary
                     queue:(dispatch_queue_t _Nullable)queue
                  callback:(void(^ _Nonnull)(VMModel * _Nullable model, NSError * _Nullable error))callback;

#pragma mark - JsonModeling

/// 将Model转Dictionary。
/// - Parameters:
///   - model: VMModel
///   - queue: (Option) 派发的队列。为空则在主线程回调callback。
///   - callback: 回调Dictionary。
+ (void)dictionaryWithModel:(VMModel *)model
                      queue:(dispatch_queue_t _Nullable)queue
                   callback:(void(^ _Nonnull)(NSDictionary * _Nullable dictionary, NSError * _Nullable error))callback;

/// 将Model数组转json数组，注意使用元素类来处理。
/// - Parameters:
///   - models: VMModels，元素一定是要当前类型或者子类。
///   - queue: (Option) 派发的队列。为空则在主线程回调callback。
///   - callback: 回调Dictionaries。
+ (void)arrayWithModels:(NSArray<__kindof VMModel *> * _Nonnull)models
                  queue:(dispatch_queue_t _Nullable)queue
               callback:(void(^ _Nonnull)(NSArray<__kindof NSDictionary *> * _Nullable array))callback;

#pragma mark - Json

/// 将Model转json数据。
/// - Parameters:
///   - model: VMModel
///   - queue: (Option) 派发的队列。为空则在主线程回调callback。
///   - callback: 回调NSData。
+ (void)dataWithModel:(VMModel *)model
                queue:(dispatch_queue_t _Nullable)queue
             callback:(void(^ _Nonnull)(NSData * _Nullable data, NSError * _Nullable error))callback;

/// 将Model转json字符串。
/// - Parameters:
///   - model: VMModel
///   - encoding: 使用的编码。
///   - queue: (Option) 派发的队列。为空则在主线程回调callback。
///   - callback: 回调NSString。
+ (void)jsonWithModel:(VMModel *)model
             encoding:(NSStringEncoding)encoding
                queue:(dispatch_queue_t _Nullable)queue
             callback:(void(^ _Nonnull)(NSString * _Nullable json, NSError * _Nullable error))callback;

/// 将Model数组转json数据。
/// - Parameters:
///   - models: 当前调用的类型数组，务必保证元素跟当前调用类一致。
///   - queue: (Option) 派发的队列。为空则在主线程回调callback。
///   - callback: 回调NSData。
+ (void)dataWithModels:(NSArray *)models
                 queue:(dispatch_queue_t _Nullable)queue
              callback:(void(^ _Nonnull)(NSData * _Nullable data, NSError * _Nullable error))callback;

/// 将Model数组转json字符串。
/// - Parameters:
///   - models: 当前调用的类型数组，务必保证元素跟当前调用类一致。
///   - encoding: 使用的编码。
///   - queue: (Option) 派发的队列。为空则在主线程回调callback。
///   - callback: 回调NSString。
+ (void)jsonWithModels:(NSArray *)models
              encoding:(NSStringEncoding)encoding
                 queue:(dispatch_queue_t _Nullable)queue
              callback:(void(^ _Nonnull)(NSString * _Nullable json, NSError * _Nullable error))callback;

#pragma mark - Core

/// 判断是否VMModel类。
/// - Parameter model:
+ (BOOL)isModel:(Class)model;

/// 获取Model的属性信息。
/// - Parameters:
///   - model: Model。
///   - queue: (Option) 派发的队列。为空则在主线程回调callback。
///   - callback: 回调Model和对应的属性信息。
+ (void)propertiesOfModel:(Class _Nonnull)model
                    queue:(dispatch_queue_t _Nullable)queue
                 callback:(void(^ _Nonnull)(Class _Nonnull model, NSArray<__kindof VMModelProperty *> * _Nullable properties))callback;

@end

NS_ASSUME_NONNULL_END
