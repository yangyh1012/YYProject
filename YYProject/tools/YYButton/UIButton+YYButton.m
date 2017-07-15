//
//  UIButton+YYButton.m
//  YYProject
//
//  Created by yangyh on 2017/7/16.
//  Copyright © 2017年 杨毅辉. All rights reserved.
//

#import "UIButton+YYButton.h"

@implementation UIButton (YYButton)

- (void)btnSettingBackgroundImageViewForBtn:(UIButton *)button urlStr:(NSString *)urlStr {
    
    [self btnSettingBackgroundImageViewForBtn:button urlStr:urlStr contentModeFlag:YES];
}

- (void)btnSettingBackgroundImageViewForBtn:(UIButton *)button urlStr:(NSString *)urlStr contentModeFlag:(BOOL)flag {
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    //BUG FIX:要是button的背景图拉伸，不要设置sd_setImageWithURL，而是设置sd_setBackgroundImageWithURL
    [button sd_setBackgroundImageWithURL:url forState:UIControlStateNormal placeholderImage:[[YYConstants sharedManager] YYProjectDefaultImage] options:SDWebImageRetryFailed];
    
    if (flag) {
        
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
}

@end
