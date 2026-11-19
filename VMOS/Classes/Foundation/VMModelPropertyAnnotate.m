//
//  VMModelPropertyAnnotate.m
//  Pods
//
//  Created by ItghostFan on 2026/4/23.
//

#import "VMModelPropertyAnnotate.h"

#import <VMOS/VMModel.h>

@implementation VMModelPropertyAnnotate

- (instancetype)initWithAttribute:(NSString *)attribute {
    if (self = [self init]) {
        NSScanner *scanner = [NSScanner scannerWithString:attribute];
        if (![scanner scanString:@"@" intoString:nil]) {
            return nil;
        }
        if (![scanner scanString:@"\"" intoString:nil]) {
            return nil;
        }
        NSString *cls = nil;
        /// "T@\"NSString<VMMPOptional>\",&,N,V_identifier"
        /// "T@\"NSString\",&,N,V_identifier"
        BOOL mayBeBoolean = NO;
        if ([scanner.string containsString:@"<"] && [scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"<"] intoString:&cls]) {
            if (NSNumber.class == NSClassFromString(cls)) {
                mayBeBoolean = YES;
            }
        } else {
            [scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\""] intoString:&cls];
        }
        _model = NSClassFromString(cls);
        if (_model == NSString.class) {
            _isPrimitive = YES;
        } else
        if (_model == NSNumber.class) {
            _isPrimitive = YES;
            if (mayBeBoolean) {
                NSString *numberType = nil;
                if ([scanner scanString:@"<" intoString:nil] && [scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@">"] intoString:&numberType]) {
                    if ([numberType isEqualToString:NSStringFromProtocol(@protocol(VMMPBool))]) {
                        _isBoolean = mayBeBoolean;
                    }
                }
            }
        } else
        if (_model == NSArray.class) {
            _isPrimitive = YES;
            _elementLevel += 1;
            NSString *elementCls = nil;
            NSMutableArray<__kindof NSString *> *models = NSMutableArray.new;
            while ([scanner scanString:@"<" intoString:nil] &&
                   [scanner scanUpToString:@">" intoString:&elementCls] &&
                   [scanner scanString:@">" intoString:nil]) {
                [models addObject:elementCls];
            }
            if (models.count) {
                NSSet *numberTypes = [NSSet setWithArray:@[
                    NSStringFromProtocol(@protocol(VMMPBool)),
                    NSStringFromProtocol(@protocol(VMMPInt8)),
                    NSStringFromProtocol(@protocol(VMMPUInt8)),
                    NSStringFromProtocol(@protocol(VMMPInt16)),
                    NSStringFromProtocol(@protocol(VMMPUInt16)),
                    NSStringFromProtocol(@protocol(VMMPInt32)),
                    NSStringFromProtocol(@protocol(VMMPUInt32)),
                    NSStringFromProtocol(@protocol(VMMPInt64)),
                    NSStringFromProtocol(@protocol(VMMPUInt64)),
                    NSStringFromProtocol(@protocol(VMMPFloat)),
                    NSStringFromProtocol(@protocol(VMMPDouble)),
                ]
                ];
                NSMutableSet *elementModels = [NSMutableSet setWithCapacity:models.count];
                for (NSString *model in models) {
                    if ([numberTypes containsObject:model]) {
                        NSAssert([models indexOfObject:model] == models.count - 1, @"Check %@", attribute);
                        if ([model isEqualToString:NSStringFromProtocol(@protocol(VMMPBool))]) {
                            _isBoolean = YES;
                        }
                        break;
                    }
                    Class elementModel = NSClassFromString(model);
                    if (elementModel == NSArray.class) {
                        _elementLevel += 1;
                        continue;
                    }
                    if (elementModel == NSString.class ||
                        elementModel == NSNumber.class ||
                        [VMModel isModel:elementModel] ||
                        [elementModel conformsToProtocol:@protocol(VMModel)]) {
                        [elementModels addObject:elementModel];
                    }
                }
                NSAssert(elementModels.count == 1, @"Check!");
                _elementModel = elementModels.allObjects.firstObject;
            }
        } else {
            /// 这里可以不用是模型，如果不是模型的话，Getter和Setter需要特殊处理。
            _isModel = [VMModel isModel:_model];
        }
    }
    return self;
}

@end
