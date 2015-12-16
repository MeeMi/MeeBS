//
//  MeeButton.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/12/16.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeButton.h"
#import <SDWebImage/UIButton+WebCache.h>

@implementation MeeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        // self.backgroundColor = [UIColor whiteColor];
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    }
    return self;
}

// 调整
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 修改图片的尺寸
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.height * 0.5;
    self.imageView.centerX = self.width * 0.5;
    self.imageView.y = self.height * 0.1;
    
    // 修改文字的尺寸
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.height = self.height - self.titleLabel.y;
    self.titleLabel.width = self.width;
    
}


// 设置数据
- (void)setSquareModel:(MeeSquareModel *)squareModel
{
    _squareModel = squareModel;
    [self sd_setImageWithURL:[NSURL URLWithString:squareModel.icon] forState:UIControlStateNormal];
    [self setTitle:squareModel.name forState:UIControlStateNormal];
}

@end
