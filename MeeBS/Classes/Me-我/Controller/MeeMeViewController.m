//
//  MeeMeViewController.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/11/7.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeMeViewController.h"

@interface MeeMeViewController ()

@end

@implementation MeeMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *moonItem = [UIBarButtonItem barItemWithImage:@"mine-moon-icon" andSelectImage:@"mine-moon-icon-click" action:@selector(moonClick) andTarget:self];
    UIBarButtonItem *settingItem = [UIBarButtonItem barItemWithImage:@"mine-setting-icon" andSelectImage:@"mine-setting-icon-click" action:@selector(settingClick) andTarget:self];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
}

- (void)moonClick
{
    NSLog(@"sss - %s - %zd",__func__,__LINE__);
}

- (void)settingClick
{
    NSLog(@"sss - %s - %zd",__func__,__LINE__);
}

@end
