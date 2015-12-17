//
//  MeeCategoryViewController.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/12/17.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeCategoryViewController.h"

@interface MeeCategoryViewController ()

@property (weak, nonatomic) IBOutlet UITableView *categoryTableVeiw;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@end

@implementation MeeCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐标签";
    self.view.backgroundColor = MeeRandomColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
