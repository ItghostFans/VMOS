//
//  VMModelProperty+Number.h
//  Pods
//
//  Created by ItghostFan on 2026/4/25.
//

#import <Foundation/Foundation.h>

#import <VMOS/VMModelProperty.h>

NS_ASSUME_NONNULL_BEGIN

@interface VMModelProperty (Number)

@end

@protocol NSNumber <NSObject>
@end

@interface NSNumber (VMModelProperty) <
VMMPBool,
VMMPInt8,
VMMPUInt8,
VMMPInt16,
VMMPUInt16,
VMMPInt32,
VMMPUInt32,
VMMPInt64,
VMMPUInt64,
VMMPFloat,
VMMPDouble>
@end

NS_ASSUME_NONNULL_END
