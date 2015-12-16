//
//  MeeFooterView.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/12/14.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeFooterView.h"
#import "MeeHTTPSessionManager.h"
#import <SVProgressHUD.h>
#import <MJExtension.h>

#import "MeeSquareModel.h"
#import "MeeButton.h"

#import "MeeWebController.h"
@implementation MeeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor redColor];
//        self.height = 300;
        // 进行网络请求，获取数据
        [self loadData];
    }
    return self;
}

- (void)loadData
{
    MeeHTTPSessionManager *manager = [MeeHTTPSessionManager shareManger];
    // 设置参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"square";
    params[@"c"] = @"topic";
    __weak typeof(self) weakSelf = self;
    
    [manager GET:MeeBaseUrl parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // 进行数组字典转模型
        // [responseObject writeToFile:@"/Users/Lee/Desktop/a.plist" atomically:YES];
        NSArray *array = [MeeSquareModel mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        // 创建方块
        [weakSelf createSquare:array];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"【我】数据加载失败" maskType:SVProgressHUDMaskTypeBlack];
    }];
}

// 根据模块数组创建按钮
- (void)createSquare:(NSArray *)array
{
    // 每行个数
    NSInteger rowCount = 4;
    // 每个方块的宽度，高度
    CGFloat buttonW = MeeScreenW / rowCount;
    CGFloat buttonH = buttonW;
 
    for (int i = 0; i < array.count; i++) {
        MeeButton *btn = [MeeButton buttonWithType:UIButtonTypeCustom];
        btn.squareModel = array[i];
        btn.x = (i % rowCount) * buttonW;
        btn.y = (i / rowCount) * buttonH;
        // btn.width = buttonW - 1;
        // btn.height = buttonH - 1;
        btn.width = buttonW;
        btn.height = buttonH;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    
    // 出现一个小问题，当向上拖footView查看最后一个 Button的时候，松开手的时候没有设置 Button有回弹到原来的位置
    // 原因：没有设置footView的高度
    // 解决：获取获取最后一个Button获取最大的y值，设置footView的高度
    // NSLog(@"----> %zd",self.subviews.count);
    MeeButton *lastButton = [self.subviews lastObject];
    self.height = CGRectGetMaxY(lastButton.frame);
    // 因为是自定义的footView是先添加的footView后设置的高度，所以设置的高度不起作用
    // 解决方式：先设置高度 后添加 footView，所以获取footView，重新在添加一次 footView
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableFooterView = self;
}

- (void)btnClick:(MeeButton *)btn
{
    MeeSquareModel *squareModel = btn.squareModel;
    if ([squareModel.url hasPrefix:@"mod://"]) {
        if ([squareModel.url hasSuffix:@"BDJ_To_Check"]) {
            NSLog(@"跳转【%@】控制器",squareModel.name);
        }else if([squareModel.url hasSuffix:@"BDJ_To_RecentHot"]) {
            NSLog(@"跳转【%@】控制器",squareModel.name);
        }else if([squareModel.url hasSuffix:@"BDJ_To_RankingList"]) {
            NSLog(@"跳转【%@】控制器",squareModel.name);
        }else{
            NSLog(@"其他控制器");
        }
    }else if([squareModel.url hasPrefix:@"http://"]){
        // 跳转到webView控制器
        MeeWebController *webVc = [[MeeWebController alloc]init];
        webVc.title = squareModel.name;
        webVc.urlString = squareModel.url;
        // footView 获取控制器，然后push进去 webVc控制器
        
        // 1.获取window的根控制器
        // NSLog(@"%@",[self.window.rootViewController class]);
        UITabBarController *tabVc = (UITabBarController *)self.window.rootViewController;
        // 2.获取footView所在的导航控制器
        // tabVc.childViewControllers[] 需要知道那个导航控制器被点击
        UINavigationController *nav = tabVc.selectedViewController; //  获取根控制器中，被选中的控制器
        // 3.push
        [nav pushViewController:webVc animated:YES];
        
        
    }else{
        NSLog(@"其他");
    }
    
}





@end

