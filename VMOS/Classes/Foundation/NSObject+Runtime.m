//
//  NSObject+Runtime.m
//  VMOS
//
//  Created by ItghostFan on 2024/12/3.
//

#import "NSObject+Runtime.h"

#import <objc/runtime.h>

@implementation NSObject (Runtime)

+ (void)runtime_swizzleSel:(SEL)oldSel newSel:(SEL)newSel cls:(Class)cls {
    Method oldMethod = class_getInstanceMethod(cls, oldSel);
    Method newMethod = class_getInstanceMethod(cls, newSel);
    IMP oldMethodImp = method_getImplementation(oldMethod);
    IMP newMethodImp = method_getImplementation(newMethod);
    if (class_addMethod(cls, oldSel, newMethodImp, method_getTypeEncoding(newMethod))) {
        class_replaceMethod(cls, oldSel, oldMethodImp, method_getTypeEncoding(oldMethod));
    } else {
        method_exchangeImplementations(oldMethod, newMethod);
    }
}

@end
