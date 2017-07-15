//
//  NSMutableAttributedString+YYMutableAttributedString.m
//  YYProject
//
//  Created by yangyh on 2017/7/16.
//  Copyright © 2017年 杨毅辉. All rights reserved.
//

#import "NSMutableAttributedString+YYMutableAttributedString.h"

@implementation NSMutableAttributedString (YYMutableAttributedString)

- (NSMutableAttributedString *)attributedStringSetting:(NSString *)allStr rangeStr:(NSString *)rangeStr underLineFlag:(BOOL)flag {
    
    return [self attributedStringSetting:allStr rangeStr:rangeStr textColor:nil fontSize:nil underLineFlag:flag];
}

- (NSMutableAttributedString *)attributedStringSetting:(NSString *)allStr rangeStr:(NSString *)rangeStr textColor:(UIColor *)color fontSize:(UIFont *)font {
    
    return [self attributedStringSetting:allStr rangeStr:rangeStr textColor:color fontSize:font underLineFlag:NO];
}

- (NSMutableAttributedString *)attributedStringSetting:(NSString *)allStr rangeStr:(NSString *)rangeStr textColor:(UIColor *)color fontSize:(UIFont *)font underLineFlag:(BOOL)flag {
    
    if ([NSString isStringEmpty:allStr]) {
        
        allStr = @"";
    }
    
    if ([NSString isStringEmpty:rangeStr]) {
        
        rangeStr = @"";
    }
    
    NSString *brandLabelStr = allStr;
    NSMutableAttributedString *brandLabelText = [[NSMutableAttributedString alloc] initWithString:brandLabelStr];
    NSRange brandLabelRange = [brandLabelStr rangeOfString:rangeStr];
    
    if (color) {
        
        [brandLabelText addAttribute:NSForegroundColorAttributeName value:color range:brandLabelRange];
    }
    
    if (font) {
        
        [brandLabelText addAttribute:NSFontAttributeName value:font range:brandLabelRange];
    }
    
    if (flag) {
        
        [brandLabelText addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:brandLabelRange];
    }
    
    return brandLabelText;
}

@end
