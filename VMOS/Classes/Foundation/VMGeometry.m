//
//  VMGeometry.m
//  Pods
//
//  Created by ItghostFan on 2026/4/12.
//

#import "VMGeometry.h"

NSDictionary * CGRectToObject(CGRect frame) {
    NSMutableDictionary *object = NSMutableDictionary.new;
    object[@"x"] = @(frame.origin.x);
    object[@"y"] = @(frame.origin.y);
    object[@"width"] = @(frame.size.width);
    object[@"height"] = @(frame.size.height);
    return object;
}

CGRect CGRectFromObject(NSDictionary *object) {
    CGRect frame = {
        {[object[@"x"] doubleValue], [object[@"y"] doubleValue]},
        {[object[@"width"] doubleValue], [object[@"height"] doubleValue]}
    };
    return frame;
}
