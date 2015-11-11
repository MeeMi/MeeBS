//
//  MeeTabBar.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/11/11.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeTabBar.h"

@interface MeeTabBar()

@property (nonatomic, weak) UIButton *publicButton; /**< 记录发布按钮 */

@end

@implementation MeeTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 创建中间的发布按钮
        UIButton *publicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publicButton setImage:[UIImage imageNamed:@"tabBar_publish_icon" ] forState:UIControlStateNormal];
        [publicButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        //[publicButton sizeToFit];
        // 添加点击事件
        [publicButton addTarget:self action:@selector(publishBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.publicButton = publicButton;
        [self addSubview:publicButton];
        
    }
    return self;
}

// 计算布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
   // 通过遍历 UITabBar 中的子控件 _UITabBarBackgroundView UIButton UIImageView UITabBarButton
    // 现在字需要 UIButton，UITabBarButton 的总个数
    
    CGFloat tabBarW = self.frame.size.width ;
    CGFloat tabBarH = self.frame.size.height;
    CGFloat btnW = tabBarW / 5;
    CGFloat btnH = tabBarH;
    
    // 设置按钮的的位置
    // 这种方法，设置按钮尺寸 跟随图片的尺寸 [publicButton sizeToFit];
    //self.publicButton.center = CGPointMake(tabBarW * 0.5, tabBarH * 0.5);
    
    // 给 里面的 UITabBarButton 添加索引，根据索引计算 publicButton的位置
    NSUInteger index = 0;
    for (UIView *tabView in self.subviews) {
        // 找出里面的 UITabBarButton
        // UITabBarButton 是苹果自己使用的类，不对外公开使用
        Class UITabBarButtonClass = NSClassFromString(@"UITabBarButton");
        if(![tabView isKindOfClass:UITabBarButtonClass]) continue;
        // 设UITabBarButton 的位置
        CGFloat x = index * btnW;
        if (index == 2) { // 根据索引重写计算了 publicButton的位置和尺寸
            self.publicButton.frame = CGRectMake(x, 0, btnW, btnH);
        }
        
        if (index >= 2) {
            x += btnW;
        }
        tabView.frame = CGRectMake(x, 0, btnW, btnH);
        index++;
    }
    
}


- (void)publishBtnClick
{
    NSLog(@"sss - %s - %zd",__func__,__LINE__);
}

@end
