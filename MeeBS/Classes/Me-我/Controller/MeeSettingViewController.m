//
//  MeeSettingViewController.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/12/16.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeSettingViewController.h"
#import "MeeClearCell.h"
#import "MeeSettingCell.h"
#import "MeeOtherCell.h"
static NSString * const clearCell = @"clearCell";
static NSString * const settingCell = @"settingCell";
static NSString * const othetCell = @"otherCell";

@interface MeeSettingViewController ()

@end

@implementation MeeSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = MeeBgColor;
    [self setupTableView];
}

- (void)setupTableView
{
 
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 注册cell
    // 通过代码创建的cell
    [self.tableView registerClass:[MeeClearCell class] forCellReuseIdentifier:clearCell];
    [self.tableView registerClass:[MeeSettingCell class] forCellReuseIdentifier:settingCell];
    // 从xib创建的Cell，从xib注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MeeOtherCell class]) bundle:nil] forCellReuseIdentifier:othetCell];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        // 第一部分
        if (indexPath.row == 0) {
            MeeClearCell *cell = [tableView dequeueReusableCellWithIdentifier:clearCell];
            //cell.textLabel.text = @"清理缓存";
            return cell;
        }else{
            MeeSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:settingCell];
            if(indexPath.row == 1){
                cell.textLabel.text = @"检查更新";
            }else if (indexPath.row == 2){
                cell.textLabel.text = @"给我评分";
            }else if(indexPath.row == 3){
                cell.textLabel.text = @"关于我们";
            }else if(indexPath.row == 4){
                cell.textLabel.text = @"分享";
            }else {
                cell.textLabel.text = @"更多";
            }
             return cell;
        }
    }else {
        
        return [tableView dequeueReusableCellWithIdentifier:othetCell];
    }
    
}

@end










