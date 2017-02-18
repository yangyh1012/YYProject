//
//  UIImage+YYImage.h
//  YYProject
//
//  Created by 杨毅辉 on 2017/2/18.
//  Copyright © 2017年 杨毅辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YYImage)

/**
 *  重构图片尺寸
 *
 *  @param image          图片
 *  @param maxScaleLength 图片尺寸
 *
 *  @return 处理后的图片
 */
+ (UIImage *)image:(UIImage *)image withMaxScaleLength:(CGFloat)maxScaleLength;


/**
 *  修改图片颜色（如何使用：[[UIImage imageNamed:@"image"] imageWithTintColor:[UIColor orangeColor]]; ）
 *
 *  @param tintColor 指定颜色
 *
 *  @return 图片
 */
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;
- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor;

/**
 *  图片文件下载
 *
 *  @param urlStr    image的url字符串地址
 *  @param imageName image的图片名称
 *
 *  @return 是否写入成功
 */
- (BOOL)imageDownloadWithUrlStr:(NSString *)urlStr imageName:(NSString *)imageName;

@end
