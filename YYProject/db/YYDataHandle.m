//
//  YYDataHandle.m
//  YYProject
//
//  Created by 杨毅辉 on 2017/2/18.
//  Copyright © 2017年 杨毅辉. All rights reserved.
//

#import "YYDataHandle.h"

#define YYUserDefaults_Directory @"/YYUserDefaults/"
#define YYUserDefaults_FileName @"userDefaults.special"
#define YYUserDefaults_Key @"(*&^#@12343O^$%I!KJjf&23d^jf&^%h1234%hL.;'^%k"

@implementation YYDataHandle

static YYDataHandle *sharedManager = nil;

+ (instancetype)sharedManager {
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}



#pragma mark - NSUserDefaults

- (void)setUserDefaultObjectValue:(id)obj WithKey:(NSString *)key {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:obj forKey:key];
    
    //BUG FIX:防止当应用突然退出时，数据没有保存
    [defaults synchronize];
}

- (id)userDefaultObjectValueWithKey:(NSString *)key {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}


#pragma mark - YYUserDefaults

- (void)setUserDefaultSecretStringValue:(NSString *)str WithKey:(NSString *)key {
    
    NSMutableDictionary *datas = [self userDefaultDatas];
    
    if (!datas) {
        
        datas = [[NSMutableDictionary alloc] init];
    }
    
    [datas setObject:str forKey:key];
    
    [self writeUserDefaultDataWithDatas:datas];
}

- (NSString *)userDefaultSecretStringValueWithKey:(NSString *)key {
    
    NSMutableDictionary *datas = [self userDefaultDatas];
    
    return [datas objectForKey:key];
}

- (NSString *)applicationDocumentsDirectoryFilePlist {
    
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [filePath objectAtIndex:0];
    NSString *dbFileDir = [documentPath stringByAppendingPathComponent:YYUserDefaults_Directory];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:dbFileDir];
    if (!isExist) {
        
        [fileManager createDirectoryAtPath:dbFileDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *path = [dbFileDir stringByAppendingPathComponent:YYUserDefaults_FileName];
    
    return path;
}

- (NSMutableDictionary *)userDefaultDatas {
    
    NSString *plistPath = [self applicationDocumentsDirectoryFilePlist];
    
    return [self userDefaultDataWithPath:plistPath];
}

- (NSMutableDictionary *)userDefaultDataWithPath:(NSString *)plistPath {
    
    NSData *encryptedData = [NSData dataWithContentsOfFile:plistPath];
    NSError *error;
    NSData *decryptData = [RNDecryptor decryptData:encryptedData
                                      withPassword:YYUserDefaults_Key
                                             error:&error];
    
    NSMutableDictionary *datas = [NSJSONSerialization JSONObjectWithData:decryptData
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:nil];
    
    return datas;
}

- (BOOL)writeUserDefaultDataWithDatas:(NSMutableDictionary *)antherDatas {
    
    NSString *plistPath = [self applicationDocumentsDirectoryFilePlist];
    
    NSData *data = [self userDefaultDataWithDatas:antherDatas path:plistPath];
    
    return [data writeToFile:plistPath atomically:YES];
}

- (NSData *)userDefaultDataWithDatas:(NSMutableDictionary *)datas path:(NSString *)plistPath {
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:datas
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    NSError *error;
    NSData *encryptedData = [RNEncryptor encryptData:data
                                        withSettings:kRNCryptorAES256Settings
                                            password:YYUserDefaults_Key
                                               error:&error];
    
    return encryptedData;
}

#pragma mark - Other

@end
