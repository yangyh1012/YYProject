//
//  NSObject+YYObject.h
//  YYProject
//
//  Created by yangyh on 2017/7/16.
//  Copyright © 2017年 杨毅辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YYObject)

- (void)logTimeTakenToRunBlock:(void (^)(void))block withPrefix:(NSString *)prefixString;

@end
