//
//  MeeFriendTrendsViewController.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/11/7.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeFriendTrendsViewController.h"

@interface MeeFriendTrendsViewController ()

@end

@implementation MeeFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImage:@"friendsRecommentIcon" andSelectImage:@"friendsRecommentIcon-click" action:@selector(leftBaeButtonClick) andTarget:self];
}


#pragma mark - 导航条左边的按钮点击事件
- (void)leftBaeButtonClick
{
    NSLog(@"sss - %s - %zd",__func__,__LINE__);
}




// 当一个控制器modal多个控制器,可以在这个方法在统一管理返回
/**
 *  这个方法的作用:用来让其他控制器回到当前控制器
 *  必备格式:1.IBAction 2.有1个UIStoryboardSegue *参数
 */
- (IBAction)backToThisController:(UIStoryboardSegue *)segues
{
    // 获取还回的控制器
    // NSLog(@"%@",segues.sourceViewController);
}

@end
