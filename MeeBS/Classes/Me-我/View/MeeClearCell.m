//
//  MeeClearCell.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/12/16.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeClearCell.h"

@implementation MeeClearCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.text = @"清理缓存";
        // 自定义cell右边的视图
        UIActivityIndicatorView *loadimgView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.accessoryView = loadimgView;
        [loadimgView startAnimating];
        
        // 获取文件大小，并显示出来
        
        // 要计算缓存文件大小，是一个耗时的过程，所以开一个异步的子线程
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // NSLog(@"线程--->%@",[NSThread currentThread]);
            // [NSThread sleepForTimeInterval:2.5];
            // 调用计算缓存的文件的方法
            NSInteger fileSize = [self getFileSize];
             // 单位换算 GB / M / KB / B
            double unit = 1000.0;
            NSString *fileSizeText = nil;
            if (fileSize > pow(unit, 3)) {
                fileSizeText = [NSString stringWithFormat:@"清理缓存(%0.2zdG)",fileSize / pow(unit, 3)];
            }else if(fileSize > pow(unit, 2)) {
                fileSizeText = [NSString stringWithFormat:@"清理缓存(%0.2zdM)",fileSize / pow(unit, 2)];
            }else if(fileSize > unit) {
                fileSizeText = [NSString stringWithFormat:@"清理缓存(%0.2zdKB)",fileSize / unit];
            }else{
                fileSizeText = [NSString stringWithFormat:@"清理缓存(%zdB)",fileSize];
            }
            
            // 在主线程中更新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                self.textLabel.text = fileSizeText;
            });
            
        });
        
        // 清理缓存
        // 给自定义的cell添加点击手势，当点击的时候，执行清除缓存的方法
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clearClick)];
        [self addGestureRecognizer:tap];
     
    }
    return self;
}

#pragma mark - 计算缓存文件的大小
- (unsigned long long)getFileSize
{
    // 1.文件路径cachesPath
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    // 使用框架SDWebImage 会在caches文件夹中生产一个 default文件夹
    // stringByAppendingPathComponent 比 stringByAppendingString 多生成一个 /
    NSString *filePath = [cachesPath stringByAppendingPathComponent:@"default"];
    
    // 2.获取文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 3.获取文件的属性
    NSDictionary *dic =[fileManager attributesOfItemAtPath:filePath error:nil];
    // 4.获取文件的大小
    // NSLog(@"---> %@",dictionary[NSFileSize]);
    NSInteger fileSize = dic.fileSize;  // unsigned long long
    // NSInteger fileSize = [dic[NSFileSize]integerValue];
    return fileSize;
}

#pragma mark - 清除缓存
- (void)clearClick
{
    
}



#pragma mark - 设置cell之间的距离
// 设置cell之间的间距
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
