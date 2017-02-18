//
//  NSString+YYString.m
//  YYProject
//
//  Created by 杨毅辉 on 2017/2/18.
//  Copyright © 2017年 杨毅辉. All rights reserved.
//

#import "NSString+YYString.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (YYString)

+ (NSString *)stringByTrim:(NSString *)string {
    
    return string == nil ? nil : [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (BOOL)isStringEmpty:(NSString *)string {
    
    return string == nil ? YES : [NSString stringByTrim:string].length < 1 ? YES : NO;
}

+ (NSString *)getCurrentTimeString {
    
    NSDateFormatter *dateformat=[[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyyMMddHHmmss"];
    
    return [dateformat stringFromDate:[NSDate date]];
}

+ (NSString *)codeDescription:(NSInteger)code {
    
    NSString *errorDescription = nil;
    switch (code) {
            
        case kCFURLErrorUnknown:
        {
            errorDescription = @"未知网络错误";
        }
            break;
        case kCFURLErrorCancelled:
        {
            errorDescription = @"未知网络错误";
        }
            break;
        case kCFURLErrorBadURL:
        {
            errorDescription = @"主域名错误";
        }
            break;
        case kCFURLErrorTimedOut:
        {
            errorDescription = @"网络连接超时";
        }
            break;
        case kCFURLErrorUnsupportedURL:
        {
            errorDescription = @"不支持网址错误";
        }
            break;
        case kCFURLErrorCannotFindHost:
        {
            errorDescription = @"未找到主机";
        }
            break;
        case kCFURLErrorCannotConnectToHost:
        {
            errorDescription = @"无法连接到主机";
        }
            break;
        case kCFURLErrorNetworkConnectionLost:
        {
            errorDescription = @"连接丢失";
        }
            break;
        case kCFURLErrorDNSLookupFailed:
        {
            errorDescription = @"DNS搜寻失败";
        }
            break;
        case kCFURLErrorHTTPTooManyRedirects:
        {
            errorDescription = @"多重定向失败";
        }
            break;
        case kCFURLErrorResourceUnavailable:
        {
            errorDescription = @"资源不可用";
        }
            break;
        case kCFURLErrorNotConnectedToInternet:
        {
            errorDescription = @"网络连接失败";
        }
            break;
        case kCFURLErrorRedirectToNonExistentLocation:
        {
            errorDescription = @"重定向失败";
        }
            break;
        case kCFURLErrorBadServerResponse:
        {
            errorDescription = @"服务器响应失败";
        }
            break;
        case kCFURLErrorUserCancelledAuthentication:
        {
            errorDescription = @"用户取消认证失败";
        }
            break;
        case kCFURLErrorUserAuthenticationRequired:
        {
            errorDescription = @"用户请求认证失败";
        }
            break;
        case kCFURLErrorZeroByteResource:
        {
            errorDescription = @"服务器无资源";
        }
            break;
        case kCFURLErrorCannotDecodeRawData:
        {
            errorDescription = @"数据解码失败";
        }
            break;
        case kCFURLErrorCannotDecodeContentData:
        {
            errorDescription = @"数据解码失败";
        }
            break;
        case kCFURLErrorCannotParseResponse:
        {
            errorDescription = @"无法解析响应数据";
        }
            break;
        case kCFURLErrorInternationalRoamingOff:
        {
            errorDescription = @"网络漫游错误";
        }
            break;
        case kCFURLErrorCallIsActive:
        {
            errorDescription = @"当前请求不活跃";
        }
            break;
        case kCFURLErrorDataNotAllowed:
        {
            errorDescription = @"数据不被允许";
        }
            break;
        case kCFURLErrorRequestBodyStreamExhausted:
        {
            errorDescription = @"请求包被清空";
        }
            break;
        case kCFURLErrorFileDoesNotExist:
        {
            errorDescription = @"文件不存在";
        }
            break;
        case kCFURLErrorFileIsDirectory:
        {
            errorDescription = @"文件目录不存在";
        }
            break;
        case kCFURLErrorNoPermissionsToReadFile:
        {
            errorDescription = @"没有读取文件的权限";
        }
            break;
        case kCFURLErrorDataLengthExceedsMaximum:
        {
            errorDescription = @"数据包长度超过限制";
        }
            break;
        default:
        {
            errorDescription = @"服务器开小差，请稍后再试~";
        }
            break;
    }
    
    return errorDescription;
}

+ (NSString *)nullStrSetting:(NSString *)str {
    
    if (str == nil) {
        
        return @"";
    } else {
        
        return str;
    }
}


+ (NSString *)obtainCurrentLanguage {
    
    //Hans简体中文、Hant繁体中文
    NSArray *languages = [NSLocale preferredLanguages];
    return [languages objectAtIndex:0];
}

@end



#pragma mark - NSString - AESString

@implementation NSString (AESString)

static Byte iv[] = {1,2,3,4,5,6,7,8};//BPEncrypt

static NSDictionary *s_tokenAddition = nil;


/**
 AES加密

 @param key key
 @return 加密后的字符串
 */
- (NSString *)encryptWithKey:(NSString *)key {
    
    NSString *ciphertext = nil;
    
    const char *bytes = [self UTF8String];
    NSUInteger length = [self length];
    
    unsigned char buffer[1024];memset(buffer, 0, sizeof(char));
    
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv, bytes, length, buffer, 1024, &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        
        ciphertext = [data base64Encoding];
    }
    
    return ciphertext;
}


/**
 AES解密

 @param key key
 @return 解密后的字符串
 */
- (NSString *)decryptWithKey:(NSString *)key {
    
    if ([self isEqualToString:@""]) {
        return @"";
    }
    
    NSData *cipherData = [[NSData alloc] initWithBase64EncodedString:self options:0];
    
    NSInteger length = self.length;
    if (length < 1024) {
        length = 1024;
    }
    unsigned char buffer[length];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          length,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    } else {
        free(buffer);
    }
    return plainText;
}

@end



#pragma mark - NSString - CheckFormat

@implementation NSString (CheckFormat)

+ (NSString *)isValidMobile:(NSString *)string {
    
    if ([NSString isStringEmpty:string]) {
        
        return @"请填写正确的电话号码";
    }
    
    if (string.length != 11) {
        
        return @"请填写正确的电话号码";
    } else {
        
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:string];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:string];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:string];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            
            return nil;
        } else {
            
            return @"请填写正确的电话号码";
        }
    }
}

+ (NSString *)isValidPassword:(NSString *)string {
    
    if ([NSString isStringEmpty:string]) {
        
        return @"请填写正确的密码";
    }
    
    if ((string.length >= 6) &&
        (string.length <= 16) &&
        ([string rangeOfString:@" "].length == 0)) {
        
        return nil;
    } else {
        
        return @"请填写正确的密码";
    }
}

+ (NSString *)isValidCode:(NSString *)string {
    
    if ([NSString isStringEmpty:string]) {
        
        return @"请填写正确的验证码";
    }
    
    if ((string.length == 6) &&
        ([string rangeOfString:@" "].length == 0)) {
        
        return nil;
    } else {
        
        return @"请填写正确的验证码";
    }
}

+ (NSString *)isValidQQ:(NSString *)string {
    
    return nil;
}


@end
