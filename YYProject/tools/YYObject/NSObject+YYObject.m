//
//  NSObject+YYObject.m
//  YYProject
//
//  Created by yangyh on 2017/7/16.
//  Copyright © 2017年 杨毅辉. All rights reserved.
//

#import "NSObject+YYObject.h"

@implementation NSObject (YYObject)

- (CGFloat)multiplesForPhone {
    
    if (IS_IPHONE_6) {
        
        return Scale_To_iPhone6;
    } else if (IS_IPHONE_6P) {
        
        return Scale_To_iPhone6P;
    } else {
        
        return 1.0f;
    }
}

@end
