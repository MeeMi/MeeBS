//
//  MeeNewViewController.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/11/7.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeNewViewController.h"

@interface MeeNewViewController ()

@end

@implementation MeeNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImage:@"MainTagSubIcon" andSelectImage:@"MainTagSubIconClick" action:@selector(leftBaeButtonClick) andTarget:self];
}

- (void)leftBaeButtonClick
{
    NSLog(@"sss - %s - %zd",__func__,__LINE__);
}

@end
