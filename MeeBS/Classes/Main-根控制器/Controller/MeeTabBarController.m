//
//  MeeTabBarController.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/11/7.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeTabBarController.h"
#import "MeeNavigationController.h"

#import "MeeEssenceViewController.h"
#import "MeeFriendTrendsViewController.h"
#import "MeeNewViewController.h"
#import "MeeMeViewController.h"

@interface MeeTabBarController ()

@end

@implementation MeeTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 添加子控制器
    [self setupChildVc];
    
    // 统一设置tabBarItem的样式
    [self setupTabBarItemStyle];
    
}

#pragma mark - 添加子控制器
- (void)setupChildVc
{
    /*
    MeeEssenceViewController *Essence = [[MeeEssenceViewController alloc]init];
    Essence.title = @"精华";
    Essence.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    Essence.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    Essence.view.backgroundColor = [UIColor purpleColor];
    MeeNavigationController *nav1 = [[MeeNavigationController alloc]initWithRootViewController:Essence];
    [self addChildViewController:nav1];
    
    MeeMeViewController *me = [[MeeMeViewController alloc]init];
    me.title = @"我";
    me.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    me.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
    me.view.backgroundColor = [UIColor grayColor];
    MeeNavigationController *nav2 = [[MeeNavigationController alloc]initWithRootViewController:me];
    [self addChildViewController:nav2];
     */
    
    [self setupOneChildVc:[[MeeEssenceViewController alloc]init] andTitle:@"精华" andImage:@"tabBar_essence_icon" andSelectImage:@"tabBar_essence_click_icon"];
    [self setupOneChildVc:[[MeeNewViewController alloc]init] andTitle:@"新帖" andImage:@"tabBar_new_icon" andSelectImage:@"tabBar_new_click_icon"];
    [self setupOneChildVc:[[MeeFriendTrendsViewController alloc]init] andTitle:@"关注" andImage:@"tabBar_friendTrends_icon" andSelectImage:@"tabBar_friendTrends_click_icon"];
    [self setupOneChildVc:[[MeeMeViewController alloc]init] andTitle:@"我" andImage:@"tabBar_me_icon" andSelectImage:@"tabBar_me_click_icon"];
}



// 添加一个控制器
- (void)setupOneChildVc:(UIViewController *) vc andTitle:(NSString *)title andImage:(NSString *)image andSelectImage:(NSString *)selectImage
{
    UINavigationController *nav = [[MeeNavigationController alloc]initWithRootViewController:vc];
    vc.view.backgroundColor = MeeRandomColor ;
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    [self addChildViewController:nav];
}



#pragma mark - 设置底部的tabBar的样式
- (void)setupTabBarItemStyle
{
    // 获取所以的TabBarItem
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    
    // 设置正在状态和选择中状态下的 文字的颜色 和大下
    
    // 正常状态下
    NSMutableDictionary *attr1 = [NSMutableDictionary dictionary];
    // 字体的大小
    attr1[NSFontAttributeName] = [UIFont systemFontOfSize:13.0];
    // 字体的颜色
    attr1[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
    [tabBarItem setTitleTextAttributes:attr1 forState:UIControlStateNormal];
    
    // 选中状态下
    NSMutableDictionary *attr2 = [NSMutableDictionary dictionary];
    [tabBarItem setTitleTextAttributes:attr2 forState:UIControlStateSelected];
    
}

@end















