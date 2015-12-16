//
//  MeeMeViewController.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/11/7.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeMeViewController.h"
#import "MeeMeCell.h"
#import "MeeFooterView.h"

#import "MeeSettingViewController.h"

static  NSString * const ID = @"cell";

@interface MeeMeViewController ()

@end

@implementation MeeMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupTableView];
}

#pragma mark - 设置导航条
- (void)setupNav
{
    UIBarButtonItem *moonItem = [UIBarButtonItem barItemWithImage:@"mine-moon-icon" andSelectImage:@"mine-moon-icon-click" action:@selector(moonClick) andTarget:self];
    UIBarButtonItem *settingItem = [UIBarButtonItem barItemWithImage:@"mine-setting-icon" andSelectImage:@"mine-setting-icon-click" action:@selector(settingClick) andTarget:self];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
}

#pragma mark - 设置tableView
- (void)setupTableView
{
    // 设置tableView的样式
    self.tableView.rowHeight = 54;
    // 设置tableView每一块的 头部和尾部的高度（需要把tableView的模式设置为Group才会有效）
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(MeeMargin-35, 0, 0, 0);
    
    //self.tableView.style = UITableViewStyleGrouped;
    // 注册cell(加载cell)
    // [self.tableView registerClass:[MeeMeCell class] forCellReuseIdentifier:ID];
    
    // 添加footView
    MeeFooterView *footView = [[MeeFooterView alloc]init];;
    self.tableView.tableFooterView = footView;
    
}

#pragma mark - 数据源代理方法
// tableView中有两部分，每部分中只有一个 cell
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    MeeMeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        // 通过判断创建cell的方式
        cell = [[MeeMeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    // 设置cell不要选中背景色
    // cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // cell.backgroundColor = MeeRandomColor;
    if (indexPath.section == 0) {
        cell.imageView.image = [[UIImage imageNamed:@"defaultUserIcon"]circleImage];
        cell.textLabel.text = @"登录/注册";
    }else{
        cell.textLabel.text = @"离线下载";
    }
    
    // 自定义cell
    return cell;
}


// 设置每组的底部高度
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 10;
//}

// 点击cell选中调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"----> %zd",indexPath.section);
}


#pragma mark - 内部控制方法
- (void)moonClick
{
    NSLog(@"sss - %s - %zd",__func__,__LINE__);
}

- (void)settingClick
{
    // NSLog(@"sss - %s - %zd",__func__,__LINE__);
    MeeSettingViewController *settingVc = [[MeeSettingViewController alloc]initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:settingVc animated:YES];
}

@end










