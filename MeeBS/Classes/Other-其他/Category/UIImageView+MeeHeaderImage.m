//
//  UIImageView+MeeHeaderImage.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/11/15.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "UIImageView+MeeHeaderImage.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImage+MeeCircleImage.m"
@implementation UIImageView (MeeHeaderImage)

/**
 *  设置头像
 */
- (void)setHeaderImage:(NSString*)urlString
{
    // 对占位图片的圆角处理
    
    UIImage *placeImage = [[UIImage imageNamed:@"defaultUserIcon"]circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:placeImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 对图片进行处理
        // 如果图片下载失败
        if(image == nil)return;
     
        self.image = [image circleImage];
        
    }];
}


@end
