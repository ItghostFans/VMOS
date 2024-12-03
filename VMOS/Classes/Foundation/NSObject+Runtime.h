//
//  NSObject+Runtime.h
//  VMOS
//
//  Created by ItghostFan on 2024/12/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Runtime)

+ (void)runtime_swizzleSel:(SEL)oldSel newSel:(SEL)newSel;

@end

NS_ASSUME_NONNULL_END
