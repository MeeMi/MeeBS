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
    MeeCategoryModel *catagoryModel = self.categories[self.categoryTableVeiw.indexPathForSelectedRow.row];
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = catagoryModel.categoryID;
    // __weak typeof(self) weakSelf = self;
    MeeWeakSelf;
    [weakSelf.manger GET:MeeBaseUrl parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
       // [responseObject writeToFile:@"/Users/Lee/Desktop/user.plist" atomically:YES];
       // 数据转模型，并与对应的标签的模型进行绑定
        catagoryModel.users = [MeeUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
       // 一定要刷新表格
        [weakSelf.userTableView reloadData];
        
        // 结束下拉刷新
        [weakSelf.userTableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束下拉刷新
        [weakSelf.userTableView.mj_header endRefreshing];
    }];

}


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
        
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束下拉刷新
        [weakSelf.userTableView.mj_header endRefreshing];
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
