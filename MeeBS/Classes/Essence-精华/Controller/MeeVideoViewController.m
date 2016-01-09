//
//  MeeVideoViewController.m
//  MeeBS
//
//  Created by 扬帆起航 on 16/1/9.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "MeeVideoViewController.h"

@interface MeeVideoViewController ()<UITableViewDataSource,UIScrollViewDelegate>


@end

@implementation MeeVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = MeeRandomColor;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"2222";
    
    return cell;
}


@end
