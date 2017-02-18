//
//  YYNetManage.m
//  YYProject
//
//  Created by 杨毅辉 on 2017/2/18.
//  Copyright © 2017年 杨毅辉. All rights reserved.
//

#import "YYNetManage.h"

@implementation YYNetManage

+ (instancetype)sharedManager {
    
    static YYNetManage *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [[YYNetManage alloc] initWithBaseURL:[NSURL URLWithString:YYProjectBaseUrl]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:0];
        _sharedClient.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"text/plain", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"application/xml", @"application/json", @"application/json;charset=UTF-8",@"image/png",@"image/jpeg",@"MultipartFile",@"multipart/form-data", nil];
    });
    
    return _sharedClient;
}

@end
