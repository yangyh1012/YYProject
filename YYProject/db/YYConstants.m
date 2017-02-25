//
//  YYConstants.m
//  YYProject
//
//  Created by 杨毅辉 on 2017/2/18.
//  Copyright © 2017年 杨毅辉. All rights reserved.
//

#import "YYConstants.h"

#pragma mark - 数据名称定义

NSString *const YYProjectSid = @"YYProjectSid_YYProject";

NSString *const YYProjectStatusFailed = @"0";
NSString *const YYProjectStatusSuccess = @"1";
NSString *const YYProjectStatusLoginFirst = @"2";

NSString *const YYYProjectRespDesc = @"RespDesc";

#pragma mark - 界面定义

CGFloat const YYProjectHUDLoadTextFont = 20.0f;
CGFloat const YYProjectHUDTipTextFont = 15.0f;
CGFloat const YYProjectHUDTipTime = 1.5f;

NSString *const YYProjectHUDRequestTipText = @"";
NSString *const YYProjectHUDLoadTipText = @"";
NSString *const YYProjectHUDFunctionDevelopingText = @"功能即将上线，敬请期待...";

#pragma mark - 请求名称定义

NSString *const YYNotificationLoginFirst = @"YYTestNotification_YYNotificationLoginFirst";

NSString *const YYNotificationPageLoad = @"YYTestNotification_YYNotificationPageLoad";
NSInteger const YYProjectStartPage = 1;

NSString *const YYNotificationKey = @"YYNotification_YYNotificationKey";

#pragma mark - YYConstants

@implementation YYConstants

static YYConstants *sharedManager = nil;

+ (instancetype)sharedManager {
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (UIImage *)YYProjectDefaultImage {
    
    return [UIImage imageNamed:@"defaultImage"];
}

- (UIColor *)YYProjectDefaultColor {
    
    return RGB_Color(0, 122, 255);
}

- (UIColor *)YYProjectLightColor {
    
    return RGB_Color(230, 230, 230);
}

- (UIColor *)YYProjectLightLightColor {
    
    return RGB_Color(245, 245, 245);
}

- (UIColor *)YYProjectButtonColor {
    
    return RGB_Color(0, 122, 255);
}

@end
