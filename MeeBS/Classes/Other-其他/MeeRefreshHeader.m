//
//  MeeRefreshHeader.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/12/19.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeRefreshHeader.h"

@implementation MeeRefreshHeader


// 自定义下拉刷新。重写父类的方法

// 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    // 普通闲置状态
    // [self setTitle:@"1" forState:MJRefreshStateIdle];
    // 正在 下拉状态 的文字
    // [self setTitle:@"下拉状态" forState:MJRefreshStatePulling];
    // 正在 刷新状态 的文字
    // [self setTitle:@"刷新状态" forState:MJRefreshStateRefreshing];
    
    // 添加一个控件
    // [self addSubview:[[UISwitch alloc]init]];
    // 可以再属性的时候，设置一个log的图标
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine-icon-more"]];
    logo.width = 50;
    logo.height = 50;
    logo.y = 0;
    logo.x = 0;
    [self addSubview:logo];
    
    self.stateLabel.textColor = MeeRandomColor;
    self.lastUpdatedTimeLabel.textColor = MeeRandomColor;
    
    // 设置自动设置透明度
    // self.backgroundColor = [UIColor yellowColor];
    self.automaticallyChangeAlpha = YES;
}




@end
