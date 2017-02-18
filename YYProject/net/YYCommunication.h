//
//  YYCommunication.h
//  YYProject
//
//  Created by 杨毅辉 on 2017/2/18.
//  Copyright © 2017年 杨毅辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YYCommunicationDelegate <NSObject>

@required

- (void)requestSuccess:(nullable id)responseObject URLString:(nullable NSString *)URLString parameters:(nullable NSDictionary *)parameters otherParams:(nullable NSDictionary *)otherParams;

- (void)requestFailure:(nullable NSError *)error URLString:(nullable NSString *)URLString parameters:(nullable NSDictionary *)parameters otherParams:(nullable NSDictionary *)otherParams;

@end

/**
 *  请求方式
 */
typedef NS_ENUM(NSInteger, YYCommunicationMode) {
    /**
     *  get请求
     */
    YYCommunicationModeGet = 0,
    /**
     *  post请求
     */
    YYCommunicationModePost,
};


@interface YYCommunication : NSObject

@property (nullable, nonatomic, weak) id <YYCommunicationDelegate> delegate;


/**
 网络请求（无参数）

 @param URLString 网址
 */
- (void)httpRequest:(nullable NSString *)URLString;

- (void)httpRequest:(nullable NSString *)URLString uidAndTokenFlag:(BOOL)uidAndTokenFlag;


/**
 网络请求（有参数版）

 @param allPara 参数
 */
- (void)httpRequestWithAllPara:(nullable NSDictionary *)allPara;


/**
 取消单个网络请求

 @param notificationName 通知名
 */
- (void)cancleRequestByNotificationName:(nullable NSString *)notificationName;


/**
 取消全部的网络请求
 */
- (void)cancleAllRequest;

@end
