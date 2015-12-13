//
//  MeeMeCellTableViewCell.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/12/13.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeMeCell.h"

@implementation MeeMeCell

// 是通过代码创建的cell
// 初始化cell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        // 设置cell右边的样式
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        // 设置cell中字体大小
        self.textLabel.font = [UIFont boldSystemFontOfSize:16];
        self.textLabel.textColor = [UIColor grayColor];
    }
    return self;
}

// 计算布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView.image == nil) return;
    
    // 设置imageView的尺寸
    CGFloat imageH = self.height - MeeMargin;
    self.imageView.width = imageH;
    self.imageView.height = imageH;
    self.imageView.x = MeeMargin;
    self.imageView.centerY = self.height * 0.5;
    
    // 设置文字的距离
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + MeeMargin;
    
}

@end
