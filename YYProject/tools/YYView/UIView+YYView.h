//
//  UIView+YYView.h
//  YYProject
//
//  Created by 杨毅辉 on 2017/2/18.
//  Copyright © 2017年 杨毅辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YYView)

/**
 *  添加视图边框
 *
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 */
- (void)borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

- (void)borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor masksToBounds:(BOOL)masksToBounds;

- (void)borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius masksToBounds:(BOOL)masksToBounds;



/**
 视图圆角

 @param cornerRadius 圆角大小
 */
- (void)cornerRadius:(CGFloat)cornerRadius;

@end
