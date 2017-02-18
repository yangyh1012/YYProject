//
//  YYCommunication.m
//  YYProject
//
//  Created by 杨毅辉 on 2017/2/18.
//  Copyright © 2017年 杨毅辉. All rights reserved.
//

#import "YYCommunication.h"

@interface YYCommunication ()

@property (nonatomic, strong) NSMutableDictionary *requestDic;

@end

@implementation YYCommunication

static YYCommunication *sharedManager = nil;

- (id)init {
    
    if(self = [super init]) {
        
        self.requestDic = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)httpRequest:(NSString *)URLString {
    
    [self httpRequest:URLString parameters:nil otherParams:nil mode:YYCommunicationModePost uidAndTokenFlag:NO imageData:nil];
}

- (void)httpRequest:(NSString *)URLString uidAndTokenFlag:(BOOL)uidAndTokenFlag {
    
    [self httpRequest:URLString parameters:nil otherParams:nil mode:YYCommunicationModePost uidAndTokenFlag:uidAndTokenFlag imageData:nil];
}

- (void)httpRequestWithAllPara:(NSDictionary *)allPara {
    
    //普通请求的例子
    //    NSDictionary *parameters = @{@"URLString":URLString,
    //                                 @"parameters":@{@"":@""},
    //                                 @"otherParams":@{@"":@""},
    //                                 @"mode":@1,
    //                                 @"uidAndTokenFlag":@1};
    
    //图片上传的例子
    //    NSDictionary *parameters = @{@"URLString":URLString,
    //                                 @"parameters":@{@"":@""},
    //                                 @"otherParams":@{@"":@""},
    //                                 @"imageData":imageData,
    //                                 @"uidAndTokenFlag":@1};
    
    NSString *URLString = allPara[@"URLString"];
    
    NSDictionary *parameters = allPara[@"parameters"];
    NSDictionary *otherParams = allPara[@"otherParams"];
    
    NSNumber *modeNum = allPara[@"mode"];
    YYCommunicationMode mode = YYCommunicationModePost;
    if (modeNum) {
        
        mode = [modeNum integerValue];
    }
    
    NSNumber *uidAndTokenNum = allPara[@"uidAndTokenFlag"];
    BOOL uidAndTokenFlag = YES;
    if (uidAndTokenNum) {
        
        if ([uidAndTokenNum integerValue] == 0) {
            
            uidAndTokenFlag = NO;
        }
    }
    
    NSData *imageData = allPara[@"imageData"];
    
    [self httpRequest:URLString parameters:parameters otherParams:otherParams mode:mode uidAndTokenFlag:uidAndTokenFlag imageData:imageData];
}

- (void)httpRequest:(NSString *)URLString parameters:(NSDictionary *)parameters otherParams:(NSDictionary *)otherParams mode:(YYCommunicationMode)mode uidAndTokenFlag:(BOOL)uidAndTokenFlag imageData:(NSData *)imageData {
    
    NSMutableDictionary *mutableParameters = nil;
    if (!parameters) {
        
        mutableParameters = [[NSMutableDictionary alloc] init];
    } else {
        
        mutableParameters = [parameters mutableCopy];
    }
    
    NSMutableDictionary *mutableOtherParams = nil;
    if (!otherParams) {
        
        mutableOtherParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:URLString,YYNotificationKey, nil];
    } else {
        
        mutableOtherParams = [otherParams mutableCopy];
        [mutableOtherParams setObject:URLString forKey:YYNotificationKey];
    }
    
    if (uidAndTokenFlag) {
        
        NSString *sid = [[YYDataHandle sharedManager] userDefaultSecretStringValueWithKey:YYProjectSid];
        if ([NSString isStringEmpty:sid]) {
            
            sid = @"";
        }
        
        [mutableParameters setObject:sid forKey:YYProjectSid];
    }
    
    //防止中文错误
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    DLog(@"请求开始：：：");
    
    __weak __typeof(self)wself = self;
    
    //不是图片上传时
    if (!imageData) {
        
        if (mode == 0) {
            
            NSURLSessionDataTask *dataTask = [[YYNetManage sharedManager] GET:URLString parameters:mutableParameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [wself requestSuccess:responseObject URLString:URLString parameters:mutableParameters otherParams:mutableOtherParams];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                [wself requestFailure:error URLString:URLString parameters:mutableParameters otherParams:mutableOtherParams];
            }];
            
            //加入线程集合
            [self.requestDic setObject:dataTask forKey:URLString];
            
        } else if (mode == 1) {
            
            NSURLSessionDataTask *dataTask = [[YYNetManage sharedManager] POST:URLString parameters:mutableParameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [wself requestSuccess:responseObject URLString:URLString parameters:mutableParameters otherParams:mutableOtherParams];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                [wself requestFailure:error URLString:URLString parameters:mutableParameters otherParams:mutableOtherParams];
            }];
            
            //加入线程集合
            [self.requestDic setObject:dataTask forKey:URLString];
        }
        
    } else {
        
        NSData *paramData = [NSJSONSerialization dataWithJSONObject:mutableParameters options:NSJSONWritingPrettyPrinted error:nil];
        
        NSURLSessionDataTask *dataTask = [[YYNetManage sharedManager] POST:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            //在表单这里提交图片以外的参数
            [formData appendPartWithFormData:paramData name:@"param"];
            
            //上传文件
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", [NSString getCurrentTimeString]];
            
            //BUG FIX:name为图片上传的参数
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"multipart/form-data"];
            
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [wself requestSuccess:responseObject URLString:URLString parameters:mutableParameters otherParams:mutableOtherParams];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [wself requestFailure:error URLString:URLString parameters:mutableParameters otherParams:mutableOtherParams];
        }];
        
        //加入线程集合
        [self.requestDic setObject:dataTask forKey:URLString];
    }
}

- (void)requestSuccess:(id)responseObject URLString:(NSString *)URLString parameters:(NSDictionary *)parameters otherParams:(NSDictionary *)otherParams {
    
    DLog(@"请求成功，返回的数据为：%@",responseObject);
    DLog(@"请求成功，请求的地址为：%@",URLString);
    DLog(@"请求成功，参数列表为：%@",parameters);
    DLog(@"请求结束：：：");
    
    [self.delegate requestSuccess:responseObject URLString:URLString parameters:parameters otherParams:otherParams];
}

- (void)requestFailure:(NSError *)error URLString:(NSString *)URLString parameters:(NSDictionary *)parameters otherParams:(NSDictionary *)otherParams {
    
    DLog(@"请求失败，错误原因：%@",[NSString codeDescription:[error code]]);
    if (error.userInfo[@"com.alamofire.serialization.response.error.data"]) {
        
        DLog(@"response.error: %@",[[NSString alloc] initWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
    }
    
    DLog(@"请求成功，请求的地址为：%@",URLString);
    DLog(@"请求成功，参数列表为：%@",parameters);
    DLog(@"请求结束：：：");
    
    [self.delegate requestFailure:error URLString:URLString parameters:parameters otherParams:otherParams];
}







- (void)cancleRequestByNotificationName:(NSString *)notificationName {
    
    DLog(@"notificationName：%@请求被取消",notificationName);
    NSURLSessionDataTask *dataTask = [self.requestDic objectForKey:notificationName];
    if (dataTask) {
        
        [dataTask cancel];
        [self.requestDic removeObjectForKey:notificationName];
    }
}

- (void)cancleAllRequest {
    
    for (NSURLSessionDataTask *dataTask in self.requestDic) {
        
        [dataTask cancel];
        [self.requestDic removeAllObjects];
    }
}

@end
