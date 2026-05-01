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
        if (![scanner scanString:@"@" intoString:NULL]) {
            return nil;
        }
        if (![scanner scanString:@"\"" intoString:NULL]) {
            return nil;
        }
        NSString *cls = nil;
        /// "T@\"NSString<VMMPOptional>\",&,N,V_identifier"
        /// "T@\"NSString\",&,N,V_identifier"
        [scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\"<"] intoString:&cls];
        _model = NSClassFromString(cls);
        if (_model == NSString.class) {
            
        } else
        if (_model == NSNumber.class) {
            
        } else
        if (_model == NSArray.class) {
            _elementLevel += 1;
            NSString *elementCls = nil;
            NSMutableArray<__kindof NSString *> *models = NSMutableArray.new;
            while ([scanner scanString:@"<" intoString:nil] &&
                   [scanner scanUpToString:@">" intoString:&elementCls] &&
                   [scanner scanString:@">" intoString:nil]) {
                [models addObject:elementCls];
            }
            if (models.count) {
#ifdef DEBUG
                NSMutableSet *elementModels = [NSMutableSet setWithCapacity:models.count];
                for (NSString *model in models) {
                    Class elementModel = NSClassFromString(model);
                    if (elementModel == NSArray.class) {
                        _elementLevel += 1;
                        continue;
                    }
                    if (elementModel == NSString.class ||
                        elementModel == NSNumber.class ||
                        [VMModel isModel:elementModel]) {
                        [elementModels addObject:elementModel];
                    }
                }
                NSAssert(elementModels.count == 1, @"Check!");
                _elementModel = elementModels.allObjects.firstObject;
#else
                for (NSString *model in models) {
                    Class elementModel = NSClassFromString(model);
                    if ([VMModel isModel:elementModel]) {
                        _elementModel = elementModel;
                        break;
                    }
                }
#endif // #ifdef DEBUG
            }
        } else {
            _isModel = [VMModel isModel:_model];
            NSAssert(_isModel, @"Check!");
        }
    }
    return self;
}

@end
