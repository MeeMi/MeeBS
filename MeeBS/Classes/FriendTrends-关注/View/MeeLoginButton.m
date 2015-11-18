//
//  MeeLoginButton.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/11/18.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeLoginButton.h"

@implementation MeeLoginButton

// 自定义Button,修改button中的图片在上文字在下面的情况


- (void)awakeFromNib
{

    // 设置 文字居中
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.y = 0;
    self.imageView.centerX = self.width * 0.5;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.x = 0;
    self.titleLabel.height = self.height - self.imageView.height;
    self.titleLabel.width = self.width;
    
    
}


@end
