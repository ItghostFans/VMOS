//
//  NSNumber+VMModel.m
//  Pods
//
//  Created by ItghostFan on 2026/9/5.
//

#import "NSNumber+VMModel.h"

@implementation NSNumber (VMModel)

+ (void)modelsWithJson:(NSString * _Nonnull)json
                 queue:(dispatch_queue_t _Nullable)queue
              callback:(void(^ _Nonnull)(NSArray<__kindof NSNumber *> * _Nullable models, NSError * _Nullable error))callback {
    [self modelsWithData:[json dataUsingEncoding:NSUTF8StringEncoding] queue:queue callback:callback];
}

+ (void)modelsWithData:(NSData * _Nonnull)data
                 queue:(dispatch_queue_t _Nullable)queue
              callback:(void(^ _Nonnull)(NSArray<__kindof NSNumber *> * _Nullable models, NSError * _Nullable error))callback {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSError *error = nil;
        NSArray *models = nil;
        @try {
            models = [NSJSONSerialization JSONObjectWithData:data options:(0) error:&error];
        } @catch (NSException *exception) {
        } @finally {
        }
        if (![models isKindOfClass:NSArray.class]) {
            dispatch_async(queue ?: dispatch_get_main_queue(), ^{
                callback(nil, [NSError errorWithDomain:@"Invalid Data!" code:-1 userInfo:nil]);
            });
            return;
        }
        dispatch_async(queue ?: dispatch_get_main_queue(), ^{
            callback(models, nil);
        });
    });
}

+ (void)dataWithModels:(NSArray *)models
                 queue:(dispatch_queue_t _Nullable)queue
              callback:(void(^ _Nonnull)(NSData * _Nullable data, NSError * _Nullable error))callback {
#ifdef DEBUG
    [models enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSAssert([obj isKindOfClass:self], @"Check!");
    }];
#endif
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSError *error = nil;
        NSData *data = nil;
        @try {
            data = [NSJSONSerialization dataWithJSONObject:models options:(0) error:&error];
        } @catch (NSException *exception) {
        } @finally {
        }
        dispatch_async(queue ?: dispatch_get_main_queue(), ^{
            callback(data, error);
        });
    });
}

+ (void)jsonWithModels:(NSArray *)models
              encoding:(NSStringEncoding)encoding
                 queue:(dispatch_queue_t _Nullable)queue
              callback:(void(^ _Nonnull)(NSString * _Nullable json, NSError * _Nullable error))callback {
    [self dataWithModels:models queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0) callback:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error) {
            callback(nil, error);
            return;
        }
        dispatch_async(queue, ^{
            callback([[NSString alloc] initWithData:data encoding:encoding], nil);
        });
    }];
}

@end
