//
//  MeeRefreshFooter.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/12/19.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeRefreshFooter.h"

@implementation MeeRefreshFooter

- (void)prepare
{
    [super prepare];
    
    // 设置文字
    // [self setTitle:@"Click or drag up to refresh" forState:MJRefreshStateIdle];
    // [self setTitle:@"Loading more ..." forState:MJRefreshStateRefreshing];
     [self setTitle:@"哥，没有跟多数据了..." forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    self.stateLabel.font = [UIFont systemFontOfSize:15];
    // 设置颜色
    self.stateLabel.textColor = MeeRandomColor;
    
    /** 当底部控件出现多少时就自动刷新(默认为1.0，也就是底部控件完全出现时，才会自动刷新) */
    self.triggerAutomaticallyRefreshPercent = 0.8;
}

@end
