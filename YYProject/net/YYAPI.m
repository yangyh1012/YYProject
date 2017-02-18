//
//  YYAPI.m
//  YYProject
//
//  Created by 杨毅辉 on 2017/2/18.
//  Copyright © 2017年 杨毅辉. All rights reserved.
//

#import "YYAPI.h"

//***************************http请求定义 start***************************************//

NSString *const YYProjectBaseUrl = @"unknowName";

NSString *const YYLocationUrl = @"http://7xpso2.com1.z0.glb.clouddn.com/cities.txt";

//***************************http请求定义 end***************************************//

@implementation YYAPI

static YYAPI *sharedManager = nil;

+ (instancetype)sharedManager {
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

@end
