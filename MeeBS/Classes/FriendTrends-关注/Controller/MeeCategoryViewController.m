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

#import <MJExtension.h>
#import <SVProgressHUD.h>

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
    
    
    // 加载标签分类的数据
    [self loadCateData];
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
    __weak typeof(self) weakSelf = self;
    [weakSelf.manger GET:MeeBaseUrl parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
       // [responseObject writeToFile:@"/Users/Lee/Desktop/cate.plist" atomically:YES];
        weakSelf.categories = [MeeCategoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 获取数据一定要刷新表格
        [weakSelf.categoryTableVeiw reloadData];
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
    __weak typeof(self) weakSelf = self;
    [weakSelf.manger GET:MeeBaseUrl parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
       // [responseObject writeToFile:@"/Users/Lee/Desktop/user.plist" atomically:YES];
       // 数据转模型，并与对应的标签的模型进行绑定
        catagoryModel.users = [MeeUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
       // 一定要刷新表格
        [self.userTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
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
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryCell];
        cell.textLabel.text = self.categories[indexPath.row].name;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userCell];
        cell.textLabel.text = self.categories[self.categoryTableVeiw.indexPathForSelectedRow.row].users[indexPath.row].screen_name;
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
