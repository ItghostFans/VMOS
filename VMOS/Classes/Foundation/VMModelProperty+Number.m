//
//  VMModelProperty+Number.m
//  Pods
//
//  Created by ItghostFan on 2026/4/25.
//

#import "VMModelProperty+Number.h"

@implementation VMModelProperty (Number)

@end

@implementation NSNumber (VMModelProperty)

- (int8_t)int8Value { 
    return [self charValue];
}

- (uint8_t)uint8Value { 
    return [self unsignedCharValue];
}

- (int16_t)int16Value { 
    return [self shortValue];
}

- (uint16_t)uint16Value { 
    return [self unsignedShortValue];
}

- (int32_t)int32Value { 
    return [self intValue];
}

- (uint32_t)uint32Value { 
    return [self unsignedIntValue];
}

- (int64_t)int64Value { 
    return [self longLongValue];
}

- (uint64_t)uint64Value {
    return [self unsignedLongLongValue];
}

@end
