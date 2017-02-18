//
//  UIView+YYView.m
//  YYProject
//
//  Created by 杨毅辉 on 2017/2/18.
//  Copyright © 2017年 杨毅辉. All rights reserved.
//

#import "UIView+YYView.h"

@implementation UIView (YYView)

- (void)cornerRadius:(CGFloat)cornerRadius {
    
    [self borderWidth:0 borderColor:nil cornerRadius:cornerRadius masksToBounds:YES];
}

- (void)borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    
    [self borderWidth:borderWidth borderColor:borderColor cornerRadius:0 masksToBounds:YES];
}

- (void)borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor masksToBounds:(BOOL)masksToBounds {
    
    [self borderWidth:borderWidth borderColor:borderColor cornerRadius:0 masksToBounds:masksToBounds];
}

- (void)borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius masksToBounds:(BOOL)masksToBounds {
    
    UIView *view = self;
    
    if (!(borderWidth == 0 &&
          borderColor == nil)) {
        
        view.layer.borderWidth = borderWidth;
        view.layer.borderColor = borderColor.CGColor;
    }
    
    if (cornerRadius != 0) {
        
        view.layer.cornerRadius = cornerRadius;
    }
    
    view.layer.masksToBounds = masksToBounds;
}

@end
