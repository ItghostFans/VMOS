//
//  NSObject+Runtime.m
//  VMOS
//
//  Created by ItghostFan on 2024/12/3.
//

#import "NSObject+Runtime.h"

#import <objc/runtime.h>

@implementation NSObject (Runtime)

+ (void)runtime_swizzleSel:(SEL)oldSel newSel:(SEL)newSel {
    Method oldMethod = class_getInstanceMethod(self, oldSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    IMP newMethodImp = method_getImplementation(newMethod);
    if (class_addMethod(self, oldSel, newMethodImp, method_getTypeEncoding(newMethod))) {
        class_replaceMethod(self, oldSel, newMethodImp, method_getTypeEncoding(oldMethod));
    } else {
        method_exchangeImplementations(oldMethod, newMethod);
    }
}

@end
