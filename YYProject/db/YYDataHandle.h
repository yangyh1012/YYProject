//
//  YYDataHandle.h
//  YYProject
//
//  Created by 杨毅辉 on 2017/2/18.
//  Copyright © 2017年 杨毅辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYDataHandle : NSObject

+ (instancetype)sharedManager;



- (void)setUserDefaultObjectValue:(id)obj WithKey:(NSString *)key;

- (id)userDefaultObjectValueWithKey:(NSString *)key;




/**
 *  可以用来保存token或者任何重要的字符串，因为此方法通过AES256加密
 *
 *  @param str 需要加密的字符串
 *  @param key 私钥
 */
- (void)setUserDefaultSecretStringValue:(NSString *)str WithKey:(NSString *)key;

/**
 *  解密
 *
 *  @param key 私钥
 *
 *  @return 解密后的字符串
 */
- (NSString *)userDefaultSecretStringValueWithKey:(NSString *)key;

@end
