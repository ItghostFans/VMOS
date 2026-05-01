//
//  VMModelProperty.h
//  Pods
//
//  Created by ItghostFan on 2026/4/23.
//

#import <Foundation/Foundation.h>

#import <VMOS/VMModelPropertyAnnotate.h>

#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@protocol VMMPNumber <NSObject>
@end

@protocol VMMPBool <VMMPNumber>
/// 同NSNumber。
- (BOOL)boolValue;
@end

@protocol VMMPInt8 <VMMPNumber>
- (int8_t)int8Value;
@end

@protocol VMMPUInt8 <VMMPNumber>
- (uint8_t)uint8Value;
@end

@protocol VMMPInt16 <VMMPNumber>
- (int16_t)int16Value;
@end

@protocol VMMPUInt16 <VMMPNumber>
- (uint16_t)uint16Value;
@end

@protocol VMMPInt32 <VMMPNumber>
- (int32_t)int32Value;
@end

@protocol VMMPUInt32 <VMMPNumber>
- (uint32_t)uint32Value;
@end

@protocol VMMPInt64 <VMMPNumber>
- (int64_t)int64Value;
@end

@protocol VMMPUInt64 <VMMPNumber>
- (uint64_t)uint64Value;
@end

@protocol VMMPFloat <VMMPNumber>
/// 同NSNumber。
- (float)floatValue;
@end

@protocol VMMPDouble <VMMPNumber>
/// 同NSNumber。
- (double)doubleValue;
@end

@interface VMModelProperty : NSObject

@property (strong, nonatomic, readonly, nonnull) NSString *name;
@property (strong, nonatomic, readonly, nonnull) VMModelPropertyAnnotate *annotate;

@property (assign, nonatomic, readonly) BOOL readonly;

@property (assign, nonatomic, readonly) SEL setter;
@property (assign, nonatomic, readonly) SEL getter;
@property (strong, nonatomic, readonly) NSString *variable;

- (instancetype)initWithProperty:(objc_property_t)property;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
