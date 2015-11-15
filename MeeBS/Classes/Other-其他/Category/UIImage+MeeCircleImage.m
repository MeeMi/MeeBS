//
//  UIImageView+MeeCircleImage.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/11/15.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "UIImage+MeeCircleImage.h"

@implementation UIImage (MeeCircleImage)

// 创建图片的分类，将图片裁剪成圆形


// 方法一：对象方法
- (instancetype)circleImage
{
    // 1.开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    // 获取当前的上文
    CGContextRef content = UIGraphicsGetCurrentContext();
    
    // 2.画圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(content, rect);
    // 3.裁剪
    CGContextClip(content);
    // 4.将图片画到矩形
    [self drawInRect:rect];
    // 5.从上下文中获取图片
    UIImage *image  = UIGraphicsGetImageFromCurrentImageContext();
    // 6.关闭上下文
    UIGraphicsEndImageContext();
    // 7.返回图片
    return image;
}





// 方法二：类方法
+ (instancetype)circleImageName: (NSString*)imageName
{
     UIImage *image = [UIImage imageNamed:imageName];
    
    // 1.开启图形上下文
    UIGraphicsBeginImageContext(image.size);
    // 2.描述裁剪的路径
    CGRect rect  = CGRectMake(0, 0, image.size.width, image.size.height);
    // 画带圆角的矩形
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:image.size.width * 0.5];
    // 3.设置裁剪区
    [path addClip];
    
    // 4.画图片
    [image drawAtPoint:CGPointZero];
    // 5.从上下文中获取图片
    image = UIGraphicsGetImageFromCurrentImageContext();
    // 6.关闭上下
    UIGraphicsEndImageContext();
    
    return image;
}

@end
