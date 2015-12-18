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
#import <MJExtension.h>
#import <SVProgressHUD.h>

static NSString *const categoryCell = @"categoryCell";
static NSString *const userCell = @"userCell";

@interface MeeCategoryViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *categoryTableVeiw;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@property (nonatomic, weak) MeeHTTPSessionManager *manger; /**< 请求管理 */

@property (nonatomic, strong) NSArray<MeeCategoryModel*> *categories; /**< 存放标签模型数组 */


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
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @"9";
    __weak typeof(self) weakSelf = self;
    [weakSelf.manger GET:MeeBaseUrl parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        [responseObject writeToFile:@"/Users/Lee/Desktop/user.plist" atomically:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


#pragma mark -  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryCell];
    cell.textLabel.text = self.categories[indexPath.row].name;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 当点击了加载 用户的数据
    [self loadUserData];
}















@end
