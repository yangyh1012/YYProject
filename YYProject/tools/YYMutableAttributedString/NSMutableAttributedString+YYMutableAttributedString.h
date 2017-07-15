//
//  NSMutableAttributedString+YYMutableAttributedString.h
//  YYProject
//
//  Created by yangyh on 2017/7/16.
//  Copyright © 2017年 杨毅辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (YYMutableAttributedString)

/**
 *  富文本
 *
 *  @param allStr   需要处理的整个字符串
 *  @param rangeStr 需要处理的部分字符串
 *  @param flag     是否需要下划线
 *
 *  @return 处理后的富文本
 */
- (NSMutableAttributedString *)attributedStringSetting:(NSString *)allStr rangeStr:(NSString *)rangeStr underLineFlag:(BOOL)flag;

- (NSMutableAttributedString *)attributedStringSetting:(NSString *)allStr rangeStr:(NSString *)rangeStr textColor:(UIColor *)color fontSize:(UIFont *)font;

- (NSMutableAttributedString *)attributedStringSetting:(NSString *)allStr rangeStr:(NSString *)rangeStr textColor:(UIColor *)color fontSize:(UIFont *)font underLineFlag:(BOOL)flag;

@end
