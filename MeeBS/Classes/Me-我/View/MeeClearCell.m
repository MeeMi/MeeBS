//
//  MeeClearCell.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/12/16.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeClearCell.h"
#import <SVProgressHUD.h>
#import <SDImageCache.h>

#define MeeFilePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"default"]

@implementation MeeClearCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.text = @"清理缓存";
        // 自定义cell右边的视图
        UIActivityIndicatorView *loadimgView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.accessoryView = loadimgView;
        [loadimgView startAnimating];
        
        // 在计算文件的大小的时候，要禁止到cell与用户的交互
        self.userInteractionEnabled = NO;
        
        // 获取文件大小，并显示出来
        
        // 要计算缓存文件大小，是一个耗时的过程，所以开一个异步的子线程
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // NSLog(@"线程--->%@",[NSThread currentThread]);
             [NSThread sleepForTimeInterval:2];
            // 调用计算缓存的文件的方法
            unsigned long long fileSize = [self getFileSize];
             // 单位换算 GB / M / KB / B
            double unit = 1000.0;
            NSString *fileSizeText = nil;
            if (fileSize >= pow(unit, 3)) {
                fileSizeText = [NSString stringWithFormat:@"清理缓存(%0.2fG)",fileSize / pow(unit, 3)];
            }else if(fileSize >= pow(unit, 2)) {
                fileSizeText = [NSString stringWithFormat:@"清理缓存(%0.2fM)",fileSize / pow(unit, 2)];
            }else if(fileSize >= unit) {
                fileSizeText = [NSString stringWithFormat:@"清理缓存(%0.2fKB)",fileSize / unit];
            }else{
                fileSizeText = [NSString stringWithFormat:@"清理缓存(%zdB)",fileSize];
            }
            
            // 在主线程中更新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                self.textLabel.text = fileSizeText;
                // 清除掉右边的转动的菊花,将右边改为箭头
                self.accessoryView = nil;
                self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                // 设置能够与用户的交互
                self.userInteractionEnabled = YES;
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
    // 2.1判断路径下文件是否是文件夹
    BOOL isDirectory = NO;
    BOOL exist = [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
    if (!exist) return 0; // 路径不存在
    if (isDirectory) { // 如果是文件夹，就对文件进行遍历
        // 3.获取文件的遍历器
        NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtPath:filePath];
        unsigned long long fileSize = 0;
        // 遍历计算
        for (NSString *path in enumerator) {
            // 拼接全路径
            NSString *fullPath = [filePath stringByAppendingPathComponent:path];
            fileSize += [fileManager attributesOfItemAtPath:fullPath error:nil].fileSize;
        }
        return fileSize;
    }
    
    // 如果是文件，返回文件的大小
    
    // 3.获取文件的属性
    NSDictionary *dic =[fileManager attributesOfItemAtPath:filePath error:nil];
    // 4.获取文件的大小
    NSInteger fileSize = dic.fileSize;  // unsigned long long
    // NSInteger fileSize = [dic[NSFileSize]integerValue];
    return fileSize;
}

#pragma mark - 清除缓存
- (void)clearClick
{
    // 添加蒙版
    [SVProgressHUD showWithStatus:@"正在清理中"];
    // 清理缓存也是一个耗时的过程，所以也在子线程中，执行
    [[[NSOperationQueue alloc]init]addOperationWithBlock:^{
        // 1.获取文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        // 2.删除文件
        [fileManager removeItemAtPath:MeeFilePath error:nil];
        
        // 3.更新UI
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            self.textLabel.text = @"清理缓存(0B)";
            [SVProgressHUD dismiss];
        }];
    }];
    
    
    // 清除缓存的第二种方法
    // 因为default文件夹是 SDWebImage框架总创建的，所以，可以通过其内部方法，删除文件夹
    // cleanDisk 遍历计算文件，找到过期的文件，清楚过期文件，期限为 1 weak ,有对应的block方法
    // clearDisk 直接删除文件，然后又重新创建一个default文件夹，有对应的block方法
    // clearMemory: 清空内存缓存
    
    // 这种方式，只清除SDWebImage方法缓存的图片清除
//    [[SDImageCache sharedImageCache]clearDiskOnCompletion:^{
//        /*
//         // 这是clearDiskOnCompletion 内部方法：其参数是completion block
//         // 原理：在子线程，先删除整个文件夹，然后创建文件。 删除完成就是在线程中回调 completion
//         dispatch_async(self.ioQueue, ^{
//             // 删除文件夹
//             [_fileManager removeItemAtPath:self.diskCachePath error:nil];
//             // 创建文件夹
//             [_fileManager createDirectoryAtPath:self.diskCachePath
//             withIntermediateDirectories:YES
//             attributes:nil
//             error:NULL];
//
//             if (completion) {
//             // 如果 completion中有值，在主线程中调用
//             dispatch_async(dispatch_get_main_queue(), ^{
//             completion();
//             });
//             }
//         });
//         */
//        // 立即我们在这里写的代码，就是在completion中的代码block，最终会在主线程中调用
//        self.textLabel.text = @"清理缓存(0B)";
//        [SVProgressHUD dismiss];
//    }];
    
}


#pragma mark 问题
// 注意出现一个问题：移除屏幕clearCell，再移入clearCell上的还没有加载完的loadingView消失
// 解决方式：重写layoutSubViews,(layoutSubViews 会频繁调用，会设置cell的尺寸，就会调用)
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 当cell离开屏幕时 UIActivityIndicatorView 动画就停止
    // cell重新显示在屏幕上的时候，应该重新显示 UIActivityIndicatorView 动画
    UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *) self.accessoryView;
    [loadingView startAnimating];
}




#pragma mark - 设置cell之间的距离
// 设置cell之间的间距
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
