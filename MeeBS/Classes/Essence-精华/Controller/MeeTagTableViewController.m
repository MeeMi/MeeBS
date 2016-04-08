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
#import <SVProgressHUD.h>
@interface MeeTagTableViewController ()<UITableViewDataSource>

@property (nonatomic, weak) MeeHTTPSessionManager *manager; /**< 网络访问的请求管理者 */
@property (nonatomic, strong) NSArray *tags; /**< <#注释#> */


@end

@implementation MeeTagTableViewController


#pragma mark - 懒加载
- (MeeHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [MeeHTTPSessionManager shareManger];
    }
    return _manager;
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
    self.tableView.showsVerticalScrollIndicator = NO; // 取消竖值方向上的指示器
}

// 获取网络数据
- (void)loadData
{
    // 添加蒙版
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    // 创建参数
    NSDictionary *params = @{@"a" : @"tag_recommend",
                             @"acton" : @"sub",
                             @"c" : @"topic"};
    
    
    // 网络访问中的block 使用弱饮用，避免循环引用。控制器无法销毁
    __weak typeof(self) weakSelf = self;
    [self.manager GET:MeeBaseUrl parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // [responseObject writeToFile:@"/Users/Lee/Desktop/tag.plist" atomically:YES];
        // 进行字典转模型
        weakSelf.tags =  [MeeTagModel mj_objectArrayWithKeyValuesArray:responseObject];
        // 获取数据一定要刷新表格
        [weakSelf.tableView reloadData];
        
        // 取消蒙版
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 1. 请求服务器失败  2.请求超时 3.取消请求任务都会来到这个地方
        // 必要时候，需要对错误的类型进行判断
        
        // 判断 error是哪一种
        if(error.code == NSURLErrorCancelled) return ;
        if (error.code == NSURLErrorTimedOut) {
            [SVProgressHUD showErrorWithStatus:@"请求超时..."];
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"请求数据失败..."];
        }
        
        // 取消蒙版
        [SVProgressHUD dismiss];
    }];
}


// 当网络很慢是，当正在加载数据的时候，突然销毁控制器，但是网络的请求任务并没请求，还在请求。
// 这样造成 偷跑流量的现象，必须在控制器的销毁的同时，取消网络的请求任务
- (void)dealloc
{
    // 取消所以的任务
    // 方法一：
    // 拿到说有的任务，进行取消
    // 当任务取消会来到 failure中
    // 这个做法Session还是能够使用的
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 方法二：
    // 调用这个代码，session会死掉，不能在在使用。如果要再次使用Session需要重新创建
    //[self.manager invalidateSessionCancelingTasks:YES];
}

// 控制器的View将要消失
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 让蒙版消失,要让蒙版先于控制器消失，将蒙版放在 viewWillDisappear
    // [SVProgressHUD dismiss];
    [SVProgressHUD dismiss];
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
