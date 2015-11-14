//
//  MeeEssenceViewController.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/11/7.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeEssenceViewController.h"
#import "MeeTagTableViewController.h"


@interface MeeEssenceViewController ()

@end

@implementation MeeEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建左边的
    
    // 方式一：
    /*
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
    // 设置按钮的尺寸，否则无法显示
    [leftButton sizeToFit];
    [leftButton addTarget:self action:@selector(leftBaeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
     */
    
    // 方式二：
    /*
    self.navigationItem.leftBarButtonItem = [self barItemWithImage:@"MainTagSubIcon" andSelectImage:@"MainTagSubIconClick" action:@selector(leftBarButtonItem)];
     */
    
    // 方式三：UIBarButtonItem 分类
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImage:@"MainTagSubIcon" andSelectImage:@"MainTagSubIconClick" action:@selector(leftBaeButtonClick) andTarget:self];
}


#pragma mark - 导航条左边的按钮点击事件
- (void)leftBaeButtonClick
{
    // 进入推荐标签的子控制器
    MeeTagTableViewController *tagVc = [[MeeTagTableViewController alloc]init];
 
    [self.navigationController pushViewController:tagVc animated:YES];
}

// 因为很多控制器，都要写这段代码，所以抽成 UIBarButtonItem的分类
- (UIBarButtonItem *) barItemWithImage:(NSString *)image andSelectImage:(NSString *)selectImage action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
    // 设置按钮的尺寸，否则无法显示
    [btn sizeToFit];
    [btn addTarget:self action:@selector(leftBaeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

@end
