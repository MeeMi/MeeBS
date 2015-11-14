//
//  MeeTagTableViewController.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/11/14.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeTagTableViewController.h"
#import "MeeHTTPSessionManager.h"

#import <MJExtension.h>

#import "MeeTagModel.h"

#import "MeeTagTableViewCell.h"
@interface MeeTagTableViewController ()<UITableViewDataSource>

@property (nonatomic, weak) MeeHTTPSessionManager *manage; /**< 网络访问的请求管理者 */
@property (nonatomic, strong) NSArray *tags; /**< <#注释#> */


@end

@implementation MeeTagTableViewController


#pragma mark - 懒加载
- (MeeHTTPSessionManager *)manage
{
    if (_manage == nil) {
        _manage = [MeeHTTPSessionManager manager];
    }
    return _manage;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"推荐标签";
    
    // 设置tableView
    [self setupTableView];
    
    // 获取网络数据
    [self loadData];

}

- (void)setupTableView
{
    self.tableView.rowHeight = 70;
    self.tableView.backgroundColor = MeeBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

// 获取网络数据
- (void)loadData
{
    // 创建参数
    NSDictionary *params = @{@"a" : @"tag_recommend",
                             @"acton" : @"sub",
                             @"c" : @"topic"};
    
    
    // 网络访问中的block 使用弱饮用，避免循环引用。控制器无法销毁
    __weak typeof(self) weakSelf = self;
    [self.manage GET:MeeBaseUrl parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // [responseObject writeToFile:@"/Users/Lee/Desktop/tag.plist" atomically:YES];
        // 进行字典转模型
        weakSelf.tags =  [MeeTagModel mj_objectArrayWithKeyValuesArray:responseObject];
        // 获取数据一定要刷新表格
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 1. 请求服务器失败  2.请求超时 3.取消请求任务都会来到这个地方
        // 必要时候，需要对错误的类型进行判断
    }];
}


#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell";
    MeeTagTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell  == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([MeeTagTableViewCell class]) owner:nil options:nil] lastObject];
    }

    cell.tagModel = self.tags[indexPath.row];
    
    return cell;
    
}



@end
