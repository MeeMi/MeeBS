//
//  MeeNavigationController.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/11/7.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeNavigationController.h"

@interface MeeNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation MeeNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 重写侧滑手势的代理方法
    self.interactivePopGestureRecognizer.delegate = self;
}

// 初始化化导航控制器，设置全世界导航控制器的属性
// 第一次使用当类进行或者子类时进行用于
+ (void)initialize
{
    // 1.拿到全世界的导航条
    UINavigationBar *navBar = [UINavigationBar appearance];
    // 设置属性
    // navBar.tintColor = [UIColor purpleColor];
    // navBar.barTintColor = [UIColor greenColor];
    // navBar.backgroundColor = [UIColor blueColor];
    
    // 2.设置导航条的背景图片
    // UIBarMetricsDefault, //背景与图片保存一致
    // UIBarMetricsCompact, 与控制器保持一致
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    // 3.设置导航条上的字体(富文本)
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize: 20]; // 设置字体的大小
    attr[NSForegroundColorAttributeName] = [UIColor orangeColor];  // 设置字体的颜色
   
    [navBar setTitleTextAttributes:attr];
    
}

// 每个根控制中push进来的子控制都会调用这个方法
// 在这个方法中，设置全世界子控制的返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if(self.childViewControllers.count != 0) // 0表示压入根控制器，1表示压入子控制器
    {
        // 重写统一子控制上的左边的返回按钮
        // 自定义按钮，按钮的测滑功能失效
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        // 注意：一定设置按钮的尺寸，要不然显示不出来
        [backButton sizeToFit];
        
        // 设置按钮的偏移
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        // backButton.titleEdgeInsets 设置按钮中的文字的内边距
        // backButton.imageEdgeInsets 设置按钮中的图片的内边距
        
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        
        // 子控制器进栈之前，隐藏底部的 tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // 这句话，就是将控制器压入
    [super pushViewController:viewController animated:animated];
   
}

#pragma mark - UIGestureRecognizerDelegate
// 判断是否允许触发当前手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 只要当子控件时，侧滑手势才能有效
    // 当时导航控制器的根控制器时，就不要手指有效，这样会有bug。因此导航控制器显示根控制器时，其中控制器数为 1
    // 进入子控制器，已经进入push方法，当是根控制器是 self.childViewControllers.count = 1
    return self.childViewControllers.count > 1;
}


// 子控制器出栈
- (void)back
{
    
    [self popViewControllerAnimated:YES];
}
@end
