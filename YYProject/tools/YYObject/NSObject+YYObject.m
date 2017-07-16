//
//  NSObject+YYObject.m
//  YYProject
//
//  Created by yangyh on 2017/7/16.
//  Copyright © 2017年 杨毅辉. All rights reserved.
//

#import "NSObject+YYObject.h"

@implementation NSObject (YYObject)

- (void)logTimeTakenToRunBlock:(void (^)(void))block withPrefix:(NSString *)prefixString {
    
    double a = CFAbsoluteTimeGetCurrent();
    block();
    double b = CFAbsoluteTimeGetCurrent();
    
    double m = ((b-a) * 1000.0f); // convert from seconds to milliseconds
    
    DLog(@"%@: %.5f ms", prefixString ? prefixString : @"Time taken", m);
}

@end
