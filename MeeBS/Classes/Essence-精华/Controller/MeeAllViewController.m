//
//  MeeAllViewController.m
//  MeeBS
//
//  Created by 扬帆起航 on 16/1/9.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "MeeAllViewController.h"
#import <MJRefresh.h>

#import "MeeRefreshFooter.h"
#import "MeeRefreshHeader.h"
#import "MeeHTTPSessionManager.h"

#import <MJExtension.h>

#import "MeeTopicModel.h"
#import "MeeTopicCell.h"

// 全局变量 ，const常量，右边不能再修改
static NSString * const cellID = @"topic";

@interface MeeAllViewController ()<UITableViewDataSource,UIScrollViewDelegate>


// 因为其内部有强引用，所以这里声明就要weak
@property (nonatomic, weak)  MeeHTTPSessionManager *manager; /**< 创建网络访问的任务管理者 */

@property (nonatomic, strong) NSMutableArray *topics; /**< 记录模型数据 */

// 记录加载更多的参数
@property (nonatomic, copy) NSString *maxtime; /**< 加载更多参数 */



@end

@implementation MeeAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tableview
    [self setupTableView];
    
    // 添加下拉刷新 + 上拉加载
    [self setupRefreshAndMoreData];
}

// 设置tableview
- (void)setupTableView
{
    self.tableView.backgroundColor = MeeBgColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UIEdgeInsets inset = UIEdgeInsetsMake(64 + 35 + MeeMargin, 0, 49, 0);
    self.tableView.contentInset = inset;
    self.tableView.scrollIndicatorInsets = inset;
    
    // 去掉cell的分割线
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    // 注册cell
    // 方式一：注册通过代码创建cell(这是通过代码创建的cell)
    //[self.tableView registerClass:[MeeTopicCell class] forCellReuseIdentifier:cellID];
    
    // 方式二：注册通过xib创建cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MeeTopicCell class]) bundle:nil] forCellReuseIdentifier:cellID];
    // xib必须通过代码设置cell的高度。storyBoard创建的高度，可以直接在里面设置
     self.tableView.rowHeight = 200; //(通过代理方法设置每行Cell的高度) 这个方法将每个cell的高度固定死了
}

- (void)setupRefreshAndMoreData
{
    self.tableView.mj_header = [MeeRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    // 进行主动刷新
    [self.tableView.mj_header beginRefreshing];
    
    // 加载更多
    self.tableView.mj_footer = [MeeRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

// 创建网络访问的任务管理者 ,通过懒加载初始化，用到的时候才去创建
- (MeeHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [MeeHTTPSessionManager manager];
    }
    return _manager;
}

- (NSMutableArray *)topics
{
    if (_topics == nil) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

#pragma mark - 刷新
- (void)refreshData
{
    // 进行网络请求
    // 参数
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = @"list";
    parame[@"c"] = @"data";
    parame[@"type"] = @"1";
    
    // AFN中的block一定要不要self
    __weak typeof(self) weakSelf = self;
    [self.manager GET:MeeBaseUrl parameters:parame success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // NSLog(@"-----> %@",responseObject);
        //[responseObject writeToFile:@"/Users/Lee/Desktop/data.plist" atomically:true];
        // 进行字典数组转模型
        weakSelf.topics = [MeeTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 存储maxtiem
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        // 刷新表格
        [weakSelf.tableView reloadData];
        // 结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - 加载更多
- (void)loadMoreData
{
    // 参数
    NSMutableDictionary *paramet = [NSMutableDictionary dictionary];
    paramet[@"a"] = @"list";
    paramet[@"c"] = @"data";
    paramet[@"type"] = @"1";
    // 加载更多需要多传入一个参数
    paramet[@"maxtime"] = self.maxtime;
    
    __weak typeof(self) weakSelf = self;
    [self.manager GET:MeeBaseUrl parameters:paramet success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // [responseObject writeToFile:@"/Users/Lee/Desktop/data2.plist" atomically:true];
        // 存储新的maxtime
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        // 数据转模型
        NSArray *moreTopic = [MeeTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 将加载的数据模型添加在数据的后
        [weakSelf.topics addObjectsFromArray:moreTopic];
       
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        // 数据刷新完成，就要结束footer，要不然，就不能下次刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 通过xib创建的cell
    MeeTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.topicModel = self.topics[indexPath.row];
    
    return cell;
}




@end
