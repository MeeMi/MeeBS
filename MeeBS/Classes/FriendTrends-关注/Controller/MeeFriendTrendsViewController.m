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


@end
