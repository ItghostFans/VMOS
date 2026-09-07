//
//  NSString+VMModel.h
//  Pods
//
//  Created by ItghostFan on 2026/9/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (VMModel)

/// 从Json字符串初始化Strings。
/// - Parameters:
///   - json: Json字符串。
///   - queue: (Option) 派发的队列。为空则在主线程回调callback。
///   - callback: 回调Models或者Error。
+ (void)modelsWithJson:(NSString * _Nonnull)json
                 queue:(dispatch_queue_t _Nullable)queue
              callback:(void(^ _Nonnull)(NSArray<__kindof NSString *> * _Nullable models, NSError * _Nullable error))callback;

/// 从data数据初始化Strings。
/// - Parameters:
///   - data: 二进制数据。
///   - queue: (Option) 派发的队列。为空则在主线程回调callback。
///   - callback: 回调Models或者Error。
+ (void)modelsWithData:(NSData * _Nonnull)data
                 queue:(dispatch_queue_t _Nullable)queue
              callback:(void(^ _Nonnull)(NSArray<__kindof NSString *> * _Nullable models, NSError * _Nullable error))callback;

/// 从url数据初始化Strings。
/// - Parameters:
///   - url: string对象数组存储的url。
///   - queue: (Option) 派发的队列。为空则在主线程回调callback。
///   - callback: 回调Models或者Error。
+ (void)modelsWithUrl:(NSURL * _Nonnull)url
                queue:(dispatch_queue_t _Nullable)queue
             callback:(void(^ _Nonnull)(NSArray<__kindof NSString *> * _Nullable models, NSError * _Nullable error))callback;

/// 将String数组转json数据。
/// - Parameters:
///   - models: 当前调用的类型数组，务必保证元素跟当前调用类一致。
///   - queue: (Option) 派发的队列。为空则在主线程回调callback。
///   - callback: 回调NSData。
+ (void)dataWithModels:(NSArray *)models
                 queue:(dispatch_queue_t _Nullable)queue
              callback:(void(^ _Nonnull)(NSData * _Nullable data, NSError * _Nullable error))callback;

/// 将String数组转json字符串。
/// - Parameters:
///   - models: 当前调用的类型数组，务必保证元素跟当前调用类一致。
///   - encoding: 使用的编码。
///   - queue: (Option) 派发的队列。为空则在主线程回调callback。
///   - callback: 回调NSString。
+ (void)jsonWithModels:(NSArray *)models
              encoding:(NSStringEncoding)encoding
                 queue:(dispatch_queue_t _Nullable)queue
              callback:(void(^ _Nonnull)(NSString * _Nullable json, NSError * _Nullable error))callback;

@end

NS_ASSUME_NONNULL_END
