//
//  YYConstants.h
//  YYProject
//
//  Created by 杨毅辉 on 2017/2/18.
//  Copyright © 2017年 杨毅辉. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define Scale_To_iPhone6 375 / 320.0f
#define Scale_To_iPhone6P 414 / 320.0f

#define RGB_C(rgb) [UIColor colorWithRed:rgb/255.0 green:rgb/255.0 blue:rgb/255.0 alpha:1.0]
#define RGB_CA(rgb,a) [UIColor colorWithRed:rgb/255.0 green:rgb/255.0 blue:rgb/255.0 alpha:a]
#define RGB_Color(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGB_ColorA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//__weak __typeof(self)wself = self;
//__strong __typeof(self)self = wself;

#pragma mark - 数据名称定义

extern NSString *const YYProjectSid;

extern NSString *const YYProjectStatusFailed;
extern NSString *const YYProjectStatusSuccess;
extern NSString *const YYProjectStatusLoginFirst;

extern NSString *const YYYProjectRespDesc;

#pragma mark - 界面定义

extern CGFloat const YYProjectHUDLoadTextFont;
extern CGFloat const YYProjectHUDTipTextFont;
extern CGFloat const YYProjectHUDTipTime;

extern NSString *const YYProjectHUDRequestTipText;
extern NSString *const YYProjectHUDLoadTipText;
extern NSString *const YYProjectHUDFunctionDevelopingText;

#pragma mark - 请求名称定义

extern NSString *const YYNotificationLoginFirst;

extern NSString *const YYNotificationPageLoad;
extern NSInteger const YYProjectStartPage;

extern NSString *const YYNotificationKey;

#pragma mark - YYConstants

@interface YYConstants : NSObject

+ (instancetype)sharedManager;

- (UIImage *)YYProjectDefaultImage;

- (UIColor *)YYProjectDefaultColor;

- (UIColor *)YYProjectLightColor;

- (UIColor *)YYProjectLightLightColor;

- (UIColor *)YYProjectButtonColor;

@end
