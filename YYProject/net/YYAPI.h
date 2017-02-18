//
//  YYAPI.h
//  YYProject
//
//  Created by 杨毅辉 on 2017/2/18.
//  Copyright © 2017年 杨毅辉. All rights reserved.
//

#import <Foundation/Foundation.h>

//***************************http请求定义 start***************************************//

extern NSString *const YYProjectBaseUrl;

extern NSString *const YYLocationUrl;

//***************************http请求定义 end***************************************//

@interface YYAPI : NSObject

+ (instancetype)sharedManager;

@end
