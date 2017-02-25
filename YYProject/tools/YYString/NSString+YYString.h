//
//  NSString+YYString.h
//  YYProject
//
//  Created by 杨毅辉 on 2017/2/18.
//  Copyright © 2017年 杨毅辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YYString)

/**
 判断iPhone型号
 
 @return iPhone型号
 */
+ (NSString *)iPhoneModel;


/**
 判断平台
 
 @return 平台
 */
+ (NSString *)platform;

/**
 *  去除头尾空格
 *
 *  @param string  需要处理的字符串
 *
 *  @return 处理后的字符串
 */
+ (NSString *)stringByTrim:(NSString *)string;

/**
 *  检测字符串是否为空
 *
 *  @param string 需要检测的字符串
 *
 *  @return Yes为空，NO为非空
 */
+ (BOOL)isStringEmpty:(NSString *)string;

/**
 *  生成当前时间字符串
 *
 *  @return 当前时间字符串
 */
+ (NSString *)getCurrentTimeString;

/**
 *  状态码错误详细说明
 *
 *  @param code 状态码
 *
 *  @return 状态码错误详细说明
 */
+ (NSString *)codeDescription:(NSInteger)code;

/**
 *  将为nil的字符串赋值@""
 *
 *  @param str 可能为nil值的字符串
 *
 *  @return 为nil时赋值@""；不为nil时，返回原值。
 */
+ (NSString *)nullStrSetting:(NSString *)str;

/**
 *  获得当前语言
 *
 *  @return 语言字符串
 */
+ (NSString *)obtainCurrentLanguage;

@end

#pragma mark - NSString - AESString

@interface NSString (AESString)

/**
 *  AES加密
 *
 *  @param key 私钥
 *
 *  @return 加密字符串
 */
- (NSString *)encryptWithKey:(NSString *)key;

/**
 *  AES解密
 *
 *  @param key 私钥
 *
 *  @return 解密字符串
 */
- (NSString *)decryptWithKey:(NSString *)key;

@end

#pragma mark - NSString - CheckFormat

@interface NSString (CheckFormat)

+ (NSString *)isValidMobile:(NSString *)string;

+ (NSString *)isValidPassword:(NSString *)string;

+ (NSString *)isValidCode:(NSString *)string;

+ (NSString *)isValidQQ:(NSString *)string;

@end
