//
//  YYNetManage.h
//  YYProject
//
//  Created by 杨毅辉 on 2017/2/18.
//  Copyright © 2017年 杨毅辉. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface YYNetManage : AFHTTPSessionManager

+ (instancetype)sharedManager;

@end
