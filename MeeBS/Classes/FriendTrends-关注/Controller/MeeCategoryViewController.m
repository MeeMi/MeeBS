//
//  MeeCategoryViewController.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/12/17.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeCategoryViewController.h"
#import "MeeHTTPSessionManager.h"

#import "MeeCategoryModel.h"
#import "MeeUserModel.h"

#import "MeeCategoryCell.h"
#import "MeeUserCell.h"

#import <MJExtension.h>
#import <SVProgressHUD.h>

#import "MeeRefreshHeader.h"
#import "MeeRefreshFooter.h"

#define MeeWeakSelf __weak typeof(self) weakSelf = self

static NSString *const categoryCell = @"categoryCell";
static NSString *const userCell = @"userCell";

@interface MeeCategoryViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *categoryTableVeiw;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@property (nonatomic, weak) MeeHTTPSessionManager *manger; /**< 请求管理 */

@property (nonatomic, strong) NSArray<MeeCategoryModel*> *categories; /**< 存放标签模型数组 */
// 因为每个标签对应着一组 用户模型，为了形成一一对应的关系，所以在 标签模型中定义一个数组，来存放对应的用户

@end

@implementation MeeCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐标签";
    self.view.backgroundColor = MeeRandomColor;
    
    // 设置tableView
    [self setupTableView];
    
    // 设置刷新 + 加载
    [self setupRefreshAndMore];
    
    // 加载标签分类的数据
    [self loadCateData];
}

#pragma mark - 初始化
- (void)setupTableView
{
    self.userTableView.rowHeight = 70;
    self.userTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIEdgeInsets insets = UIEdgeInsetsMake(MeeNavHeight, 0, 0, 0);
    self.userTableView.contentInset = insets;
    self.userTableView.scrollIndicatorInsets = insets;
    self.categoryTableVeiw.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setupRefreshAndMore
{
    // 刷新
    self.userTableView.mj_header = [MeeRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadUserData)] ;
    
    // 加载更多数据
    self.userTableView.mj_footer = [MeeRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUserData)];
}

#pragma mark - 懒加载
- (MeeHTTPSessionManager *)manger
{
    if (_manger == nil) {
        _manger = [MeeHTTPSessionManager shareManger];
    }
    return _manger;
}


#pragma mark - 加载数据

// 加载标签的数据
- (void)loadCateData
{
    
    // 创建蒙版
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    // __weak typeof(self) weakSelf = self;
    MeeWeakSelf;
    [weakSelf.manger GET:MeeBaseUrl parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
       // [responseObject writeToFile:@"/Users/Lee/Desktop/cate.plist" atomically:YES];
        weakSelf.categories = [MeeCategoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 获取数据一定要刷新表格
        [weakSelf.categoryTableVeiw reloadData];
        
        // 设置默认选中选中第一个标签的cell
        [weakSelf.categoryTableVeiw selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        // 分类数据获取完毕。刷新对应的用户的数据
        [weakSelf.userTableView.mj_header beginRefreshing];
        
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
}

// 加载用户的数据
- (void)loadUserData
{
    // 获取选择标签cell 的标签模型
    MeeCategoryModel *categoryModel = self.categories[self.categoryTableVeiw.indexPathForSelectedRow.row];
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = categoryModel.categoryID;
    // __weak typeof(self) weakSelf = self;
    MeeWeakSelf;
    [weakSelf.manger GET:MeeBaseUrl parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        // 成功访问服务器,就将页数page设置为 1
        categoryModel.page = 1;
        
       // [responseObject writeToFile:@"/Users/Lee/Desktop/user.plist" atomically:YES];
       // 数据转模型，并与对应的标签的模型进行绑定
        categoryModel.users = [MeeUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
       // 字典中获取的数据一定要进行数据转换，字典中一般存放的是 OC对象
        categoryModel.total = [responseObject[@"total"] integerValue];
       // 一定要刷新表格
        [weakSelf.userTableView reloadData];
        
        // 结束下拉刷新
        [weakSelf.userTableView.mj_header endRefreshing];
        
        // 当获取到全部数据，判断一下是否要隐藏底部的刷新
        if (categoryModel.users.count == categoryModel.total) {
            // 隐藏
            // self.userTableView.mj_footer.hidden = YES;
            // 提醒 没有更多数据
            [weakSelf.userTableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束下拉刷新
        [weakSelf.userTableView.mj_header endRefreshing];
    }];

}

// 刷新加载更多的第二方式: 直接获取服务器返回的下一页的页数next_page,total_page页数
// categoryModel.nextPage = [responseObject[@"next_page"] integerValue];
// 最后可以更具 next_page == total_page 隐藏加载更多

// 刷新加载更多的第一种方式：
// 自定义 page属性，根据page + 1 加载下一页，数组中累计到获取的数量 == 服务器返回的就 隐藏加载更多

// 加载更多的用户数据
- (void)loadMoreUserData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    // 获取选择标签cell 的标签模型
    MeeCategoryModel *categoryModel = self.categories[self.categoryTableVeiw.indexPathForSelectedRow.row];
    params[@"category_id"] = categoryModel.categoryID;
    NSInteger page = categoryModel.page + 1;
    params[@"page"] = @(page);
    
    MeeWeakSelf;
    [weakSelf.manger GET:MeeBaseUrl parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // 访问成功，保存刚才的页码数
        // 这句话位置很重要。如果写在block外面，如果访问失败，不应该记录是 +1的page，应该是 page - 1；
        categoryModel.page = page;
        
        [categoryModel.users addObjectsFromArray:[MeeUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]]];
        [weakSelf.userTableView reloadData];
        
        // 结束加载（如果不结束加载，下次就无法上拉加载）
        [weakSelf.userTableView.mj_footer endRefreshing];
        
        // 当获取到全部数据，判断一下是否要隐藏底部的刷新（当没有更多数据的时候，要么隐藏 footer，要么提醒 没有更数据 ）
        if (categoryModel.users.count == categoryModel.total) {
            // 隐藏
            // self.userTableView.mj_footer.hidden = YES;
            // 提醒 没有更多数据
            [weakSelf.userTableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束加载
        [weakSelf.userTableView.mj_footer endRefreshing];
    }];
}


#pragma mark -  UITableViewDataSource
// 一个控制器中定义两个tableView，共用一个数据源代理方法，有两个数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableVeiw) {
        return self.categories.count;
    }
    // 获取
    MeeCategoryModel *categoryModel = self.categories[self.categoryTableVeiw.indexPathForSelectedRow.row];
    return categoryModel.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableVeiw) {
        MeeCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryCell];
        cell.categoryModel = self.categories[indexPath.row];
        return cell;
    }else{
        MeeUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userCell];
        cell.userModel = self.categories[self.categoryTableVeiw.indexPathForSelectedRow.row].users[indexPath.row];
        return cell;
    }

}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 当点击了加载 用户的数据
    [self loadUserData];
}

@end
