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
    NSLog(@"---> %zd",array.count);
    for (int i = 0; i < array.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.x = (i % rowCount) * buttonW;
        btn.y = (i / rowCount) * buttonH;
        btn.width = buttonW;
        btn.height = buttonH;
        btn.backgroundColor = MeeRandomColor;
        [self addSubview:btn];
    }
}




@end
