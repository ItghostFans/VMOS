//
//  VMModelProperty.m
//  Pods
//
//  Created by ItghostFan on 2026/4/23.
//

#import "VMModelProperty.h"

@interface VMModelProperty ()
/// 原始Model Property属性。
@property (strong, nonatomic) NSMutableDictionary *attributes;
@end

@implementation VMModelProperty

- (instancetype)initWithProperty:(objc_property_t)property {
    if (self = [self init]) {
        const char *name = property_getName(property);
        _name = [NSString stringWithUTF8String:name];
        
        unsigned int propertyAttributeCount = 0;
        objc_property_attribute_t *propertyAttribute = property_copyAttributeList(property, &propertyAttributeCount);
        _attributes = [NSMutableDictionary dictionaryWithCapacity:propertyAttributeCount];
        for (unsigned int index = 0; index < propertyAttributeCount; ++index) {
            NSString *attributeName = [NSString stringWithUTF8String:propertyAttribute[index].name];
            NSString *attribute = [NSString stringWithUTF8String:propertyAttribute[index].value];
            _attributes[attributeName] = attribute;
            if ([attributeName isEqualToString:@"R"]) {
                _readonly = YES;
            } else
            if ([attributeName isEqualToString:@"T"]) {
                _annotate = [[VMModelPropertyAnnotate alloc] initWithAttribute:attribute];
            } else
            if ([attributeName isEqualToString:@"G"]) {
                _getter = NSSelectorFromString(attribute);
            } else
            if ([attributeName isEqualToString:@"S"]) {
                _setter = NSSelectorFromString(attribute);
            }
            if ([attributeName isEqualToString:@"V"]) {
                _variable = attribute;
            }
        }
        if (!_setter) {
            _setter = NSSelectorFromString([NSString stringWithFormat:@"set%@:", _name.capitalizedString]);
        }
        if (!_getter) {
            _getter = NSSelectorFromString(_name);
        }
        free(propertyAttribute);
    }
    return self;
}

@end
