//
//  UIButton+YYButton.h
//  YYProject
//
//  Created by yangyh on 2017/7/16.
//  Copyright © 2017年 杨毅辉. All rights reserved.
//



@interface UIButton (YYButton)

/**
 *  按钮设置网络背景图(默认 UIViewContentModeScaleAspectFit)
 *
 *  @param button 按钮
 *  @param urlStr 网址字符串
 */
- (void)btnSettingBackgroundImageViewForBtn:(UIButton *)button urlStr:(NSString *)urlStr;

- (void)btnSettingBackgroundImageViewForBtn:(UIButton *)button urlStr:(NSString *)urlStr contentModeFlag:(BOOL)flag;

@end
