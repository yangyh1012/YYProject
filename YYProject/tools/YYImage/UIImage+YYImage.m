//
//  UIImage+YYImage.m
//  YYProject
//
//  Created by 杨毅辉 on 2017/2/18.
//  Copyright © 2017年 杨毅辉. All rights reserved.
//

#import "UIImage+YYImage.h"

@implementation UIImage (YYImage)

- (UIImage *)scaleToSize:(CGSize)size {
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    
    //BUG FIX:必须使用floor，不然图片会黑边
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(floor(size.width), floor(size.height)), NO, [UIScreen mainScreen].scale);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    
    return scaledImage;
}

+ (UIImage *)image:(UIImage *)image withMaxScaleLength:(CGFloat)maxScaleLength {
    
    CGFloat sizeMax = image.size.width > image.size.height ? image.size.width : image.size.height;
    
    if (sizeMax <= maxScaleLength + 50.0f && sizeMax >= maxScaleLength - 50.0f) {
        
        return image;
    } else {
        
        CGFloat scale = sizeMax / maxScaleLength;
        
        return  [image scaleToSize:CGSizeMake(image.size.width / scale, image.size.height / scale)];
    }
}

- (UIImage *)imageWithTintColor:(UIColor *)tintColor {
    
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor {
    
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode {
    
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

- (BOOL)imageDownloadWithUrlStr:(NSString *)urlStr imageName:(NSString *)imageName {
    
    NSArray *lastPaths = [urlStr componentsSeparatedByString:@"."];
    NSString *fileName = [NSString stringWithFormat:@"%@.%@",imageName,[lastPaths lastObject]];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
    
    // 本地沙盒目录
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 得到本地沙盒中名为"MyImage"的路径，"MyImage"是保存的图片名
    NSString *imageFilePath = [path stringByAppendingPathComponent:fileName];
    // 将取得的图片写入本地的沙盒中
    return [data writeToFile:imageFilePath  atomically:YES];
}

@end
