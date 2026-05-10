//
//  VMModel.m
//  Pods
//
//  Created by ItghostFan on 2026/4/23.
//

#import "VMModel.h"

#import <objc/runtime.h>

@interface VMModel ()

@property (strong, nonatomic, class, readonly) NSMutableDictionary<__kindof NSString *, __kindof NSMutableArray<__kindof VMModelProperty *> *> *modelProperties;
@property (strong, nonatomic, class, readonly) NSMutableDictionary<__kindof NSString *, __kindof NSMutableArray *> *modelPropertiesTasks;

@end

@implementation VMModel

+ (NSDictionary *)propertiesMapping {
    return nil;
}

#pragma mark - Modeling Async

+ (void)modelWithJson:(NSString * _Nonnull)json
                queue:(dispatch_queue_t _Nullable)queue
             callback:(void(^ _Nonnull)(VMModel * _Nullable model, NSError * _Nullable error))callback {
    [self propertiesOfModel:self queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0) callback:^(Class  _Nonnull __unsafe_unretained model, NSArray<__kindof VMModelProperty *> * _Nullable properties) {
        NSError *error = nil;
        VMModel *object = [[model alloc] initWithJson:json error:&error];
        dispatch_async(queue ? : dispatch_get_main_queue(), ^{
            callback(object, error);
        });
    }];
}

+ (void)modelWithData:(NSData * _Nonnull)data
                queue:(dispatch_queue_t _Nullable)queue
             callback:(void(^ _Nonnull)(VMModel * _Nullable model, NSError * _Nullable error))callback {
    [self propertiesOfModel:self queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0) callback:^(Class  _Nonnull __unsafe_unretained model, NSArray<__kindof VMModelProperty *> * _Nullable properties) {
        NSError *error = nil;
        VMModel *object = [[model alloc] initWithData:data error:&error];
        dispatch_async(queue ? : dispatch_get_main_queue(), ^{
            callback(object, error);
        });
    }];
}

+ (void)modelWithDictinary:(NSDictionary * _Nonnull)dictinary
                     queue:(dispatch_queue_t _Nullable)queue
                  callback:(void(^ _Nonnull)(VMModel * _Nullable model, NSError * _Nullable error))callback {
    [self propertiesOfModel:self queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0) callback:^(Class  _Nonnull __unsafe_unretained model, NSArray<__kindof VMModelProperty *> * _Nullable properties) {
        VMModel *object = [[model alloc] initWithDictionary:dictinary];
        dispatch_async(queue ? : dispatch_get_main_queue(), ^{
            callback(object, nil);
        });
    }];
}

#pragma mark - JsonModeling Async

+ (void)dictionaryWithModel:(VMModel *)model
                      queue:(dispatch_queue_t _Nullable)queue
                   callback:(void(^ _Nonnull)(NSDictionary * _Nullable dictionary, NSError * _Nullable error))callback {
    [self propertiesOfModel:model.class queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0) callback:^(Class  _Nonnull __unsafe_unretained modelClass, NSArray<__kindof VMModelProperty *> * _Nullable properties) {        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSDictionary *dictionary = model.dictionary;
            dispatch_async(queue ? : dispatch_get_main_queue(), ^{
                callback(dictionary, nil);
            });
        });
    }];
}

+ (void)arrayWithModels:(NSArray<__kindof VMModel *> * _Nonnull)models
                  queue:(dispatch_queue_t _Nullable)queue
               callback:(void(^ _Nonnull)(NSArray<__kindof NSDictionary *> * _Nullable array))callback {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:models.count];
        for (VMModel *model in models) {
            NSAssert([model isKindOfClass:self], @"Check!");
            [array addObject:model.dictionary];
        }
        dispatch_async(queue ? : dispatch_get_main_queue(), ^{
            callback(array);
        });
    });
}

#pragma mark - Core

+ (BOOL)isModel:(Class)model {
    Class superClass = model;
    while (superClass != VMModel.class) {
        superClass = class_getSuperclass(superClass);
        if (!superClass ||
            superClass == class_getSuperclass(VMModel.class) ||
            superClass == NSObject.class) {
            return NO;
        }
    }
    return YES;
}

+ (void)propertiesOfModel:(Class _Nonnull)model
                    queue:(dispatch_queue_t _Nullable)queue
                 callback:(void(^ _Nonnull)(Class _Nonnull model, NSArray<__kindof VMModelProperty *> * _Nullable properties))callback {
    @synchronized (self.modelProperties) {
        NSMutableArray<__kindof VMModelProperty *> *properties = self.modelProperties[NSStringFromClass(model)];
        if (properties) {
            callback(model, properties);
            return;
        }
        
        if (![VMModel isModel:model]) {
            callback(model, properties);
            return;
        }
        
        @synchronized (self.modelPropertiesTasks) {
            NSMutableArray *modelPropertiesTasks = self.modelPropertiesTasks[NSStringFromClass(model)];
            if (modelPropertiesTasks) {
                [modelPropertiesTasks addObject:[callback copy]];
                return;
            } else {
                modelPropertiesTasks = NSMutableArray.new;
                self.modelPropertiesTasks[NSStringFromClass(model)] = modelPropertiesTasks;
                [modelPropertiesTasks addObject:[callback copy]];
            }
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSMutableArray<__kindof VMModelProperty *> *properties = [self propertiesOfModel:model];
            @synchronized (self.modelProperties) {
                self.modelProperties[NSStringFromClass(model)] = properties;
            }
            dispatch_group_t group = dispatch_group_create();
            for (VMModelProperty *property in properties) {
                if (property.annotate.isModel) {
                    dispatch_group_enter(group);
                    [VMModel propertiesOfModel:property.annotate.model queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0) callback:^(Class  _Nonnull __unsafe_unretained model, NSArray<__kindof VMModelProperty *> * _Nullable properties) {
                        dispatch_group_leave(group);
                    }];
                } else
                if (property.annotate.elementModel) {
                    dispatch_group_enter(group);
                    [VMModel propertiesOfModel:property.annotate.elementModel queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0) callback:^(Class  _Nonnull __unsafe_unretained model, NSArray<__kindof VMModelProperty *> * _Nullable properties) {
                        dispatch_group_leave(group);
                    }];
                }
            }
            dispatch_group_notify(group, queue ? : dispatch_get_main_queue(), ^{
                @synchronized (self.modelPropertiesTasks) {
                    NSMutableArray *modelPropertiesTasks = self.modelPropertiesTasks[NSStringFromClass(model)];
                    for (id task in modelPropertiesTasks) {
                        void(^callback)(Class model, NSArray<__kindof VMModelProperty *> *properties) = task;
                        callback(model, properties);
                    }
                    [self.modelPropertiesTasks removeObjectForKey:NSStringFromClass(model)];
                }
            });
        });
    }
}

#pragma mark - JsonModeling Sync

- (nonnull NSDictionary *)dictionary {
    NSMutableArray<__kindof VMModelProperty *> *properties = nil;
    @synchronized (self.class.modelProperties) {
        properties = self.class.modelProperties[NSStringFromClass(self.class)];
    }
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:properties.count];
    for (VMModelProperty *property in properties) {
        NSDictionary *propertiesMapping = self.class.propertiesMapping;
        NSString *jsonKey = propertiesMapping[property.name] ? : property.name;
        dictionary[jsonKey] = [self convertProperty:property value:^id(VMModelProperty *property) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            return [self performSelector:property.getter];
#pragma clang diagnostic pop
        } convertElement:^BOOL(VMModelProperty *property, __autoreleasing id *element) {
            /// object数组如： @[[[@{}, @{}],[@{}, @{}]],[[@{}, @{}],[@{}, @{}]]]
            NSAssert([*element isKindOfClass:VMModel.class], @"Check!");
            if ([*element isKindOfClass:VMModel.class]) {
                *element = [*element dictionary];
                return YES;
            }
            return NO;
        } convertModel:^id(VMModelProperty *property, id model) {
            return [model dictionary];
        }];
    }
    return dictionary;
}

#pragma mark - Private Sync

- (nullable id)convertProperty:(VMModelProperty *)property
                         value:(id(^ _Nonnull)(VMModelProperty *property))value
                convertElement:(BOOL(^ _Nonnull)(VMModelProperty *property, id * _Nonnull element))convertElement
                  convertModel:(id(^ _Nonnull)(VMModelProperty *property, id _Nonnull model))convertModel {
    id variable = nil;
    if (property.annotate.model == NSString.class ||
        property.annotate.model == NSNumber.class) {
        variable = value(property);
    } else
    if (property.annotate.model == NSArray.class) {
        if (property.annotate.elementModel == NSString.class ||
            property.annotate.elementModel == NSNumber.class) {
            variable = value(property);
        } else {
            /// 待处理的元素。
            variable = [NSMutableArray arrayWithCapacity:[value(property) count]];

            NSMutableArray *currentLevelValues = [value(property) mutableCopy];
            NSMutableArray *currentLevelElements = variable;
            
            if (property.annotate.elementLevel == 1) {
                for (NSUInteger index = 0; index < currentLevelValues.count; ++index) {
                    id value = currentLevelValues[index];
                    NSAssert([value isKindOfClass:VMModel.class] || [value isKindOfClass:NSDictionary.class], @"Check!");
                    if (convertElement(property, &value)) {
                        [currentLevelElements addObject:value];
                    }
                }
            } else {
                /// 广度递归遍历。
                NSInteger elementLevel = 1;
                while (elementLevel < property.annotate.elementLevel) {
                    NSMutableArray *nextLevelValues = NSMutableArray.new;
                    NSMutableArray *nextLevelElements = NSMutableArray.new;
                    for (NSUInteger index = 0; index < currentLevelValues.count; ++index) {
                        id value = currentLevelValues[index];
                        if ([value isKindOfClass:NSArray.class]) {
                            NSAssert(elementLevel < property.annotate.elementLevel, @"Check!");
                            for (id nextValue in value) {
                                [nextLevelValues addObject:nextValue];
                            }
                            NSMutableArray *currentElements = NSMutableArray.new;
                            [currentLevelElements addObject:currentElements];
                            [nextLevelElements addObject:currentElements];
                            if (elementLevel == property.annotate.elementLevel - 1) {
                                for (NSUInteger index = 0; index < [value count]; ++index) {
                                    id element = value[index];
                                    NSAssert([element isKindOfClass:VMModel.class] || [element isKindOfClass:NSDictionary.class], @"Check!");
                                    if (convertElement(property, &element)) {
                                        [currentElements addObject:element];
                                    }
                                }
                            } else {
                            }
                        }
                    }
                    currentLevelValues = nextLevelValues;
                    currentLevelElements = nextLevelElements;
                    elementLevel += 1;
                }
            }
        }
    } else
    if (property.annotate.isModel) {
        variable = convertModel(property, value(property));
    }
    return variable;
}

#pragma mark - instancetype Sync

/// 从json字符串初始化Model。
/// - Parameter json: 字符串 @"{\"property\": \”我是字段\"}"
- (nullable instancetype)initWithJson:(NSString *)json error:(__autoreleasing NSError ** _Nullable)error {
    if (self = [self initWithData:[json dataUsingEncoding:NSUTF8StringEncoding] error:error]) {
    }
    return self;
}

/// 从data二制数据初始化Model。
/// - Parameter data: 二进制数据。
- (nullable instancetype)initWithData:(NSData *)data error:(__autoreleasing NSError ** _Nullable)error {
    @try {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
        if (![dictionary isKindOfClass:NSDictionary.class]) {
            *error = [NSError errorWithDomain:[NSString stringWithFormat:@"Invalid Json: %@ For Model: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding], self.class] code:VMMErrorInvalidJson userInfo:nil];
            return nil;
        }
        if (self = [self initWithDictionary:dictionary]) {
        }
    } @catch (NSException *exception) {
        self = nil;
    } @finally {
    }
    return self;
}

/// 从Dictionary初始化Model。
/// - Parameter dictionary: @{@"property": @"我是字段"}
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [self init]) {
        NSMutableArray<__kindof VMModelProperty *> *properties = nil;
        @synchronized (self.class.modelProperties) {
            properties = self.class.modelProperties[NSStringFromClass(self.class)];
        }
        NSDictionary *propertiesMapping = self.class.propertiesMapping;
        for (VMModelProperty *property in properties) {
            id variable = [self convertProperty:property value:^id(VMModelProperty *property) {
                NSString *jsonKey = propertiesMapping[property.name] ? : property.name;
                return dictionary[jsonKey];
            } convertElement:^BOOL(VMModelProperty *property, __autoreleasing id * _Nonnull element) {
                /// json数组如： "[[[{}, {}],[{}, {}]],[[{}, {}],[{}, {}]]]"
                if ([*element isKindOfClass:NSDictionary.class]) {
                    *element = [[property.annotate.elementModel alloc] initWithDictionary:*element];
                    return YES;
                }
                return NO;
            } convertModel:^id(VMModelProperty *property, id  _Nonnull model) {
                NSAssert([model isKindOfClass:NSDictionary.class], @"Check!");
                return [[property.annotate.model alloc] initWithDictionary:model];
            }];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:property.setter withObject:variable];
#pragma clang diagnostic pop
        }
    }
    return self;
}

+ (nullable NSMutableArray *)modelsWithDictionaryArray:(NSArray<__kindof NSDictionary *> * _Nullable)dictionaryArray {
    if (!dictionaryArray) {
        return nil;
    }
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:dictionaryArray.count];
    for (NSDictionary *dictionary in dictionaryArray) {
        [models addObject:[[self alloc] initWithDictionary:dictionary]];
    }
    return models;
}

#pragma mark - Private

+ (NSMutableDictionary<__kindof Class, __kindof NSMutableArray<__kindof VMModelProperty *> *> *)modelProperties {
    static dispatch_once_t onceToken;
    static NSMutableDictionary *g_modelProperties = nil;
    dispatch_once(&onceToken, ^{
        g_modelProperties = NSMutableDictionary.new;
    });
    return g_modelProperties;
}

+ (NSMutableDictionary<__kindof NSString *, __kindof NSMutableArray *> *)modelPropertiesTasks {
    static dispatch_once_t onceToken;
    static NSMutableDictionary *g_modelPropertiesTasks = nil;
    dispatch_once(&onceToken, ^{
        g_modelPropertiesTasks = NSMutableDictionary.new;
    });
    return g_modelPropertiesTasks;
}

#pragma mark - Async

+ (NSMutableArray<__kindof VMModelProperty *> *)propertiesOfModel:(Class)model {
    unsigned int propertyCount = 0;
    objc_property_t *property = class_copyPropertyList(model, &propertyCount);
    NSMutableArray<__kindof VMModelProperty *> *properties = [NSMutableArray arrayWithCapacity:propertyCount];
    if (!propertyCount) {
        return properties;
    }
    for (unsigned int index = 0; index < propertyCount; ++index) {
        VMModelProperty *modelProperty = [[VMModelProperty alloc] initWithProperty:property[index]];
        if (modelProperty.readonly) {
            continue;
        }
        [properties addObject:modelProperty];
    }
    free(property);
    return properties;
}

@end
