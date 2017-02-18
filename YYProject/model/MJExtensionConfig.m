//
//  MJExtensionConfig.m
//  YYProject
//
//  Created by 杨毅辉 on 2017/2/18.
//  Copyright © 2017年 杨毅辉. All rights reserved.
//

#import "MJExtensionConfig.h"
#import "YYTestData.h"

@implementation MJExtensionConfig

+ (void)load {
    
    [YYTestData mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        
        return @{
                 @"idd" : @"id"
                 };
    }];
}

@end
