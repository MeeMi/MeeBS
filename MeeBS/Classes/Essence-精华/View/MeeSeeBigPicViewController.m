//
//  MeeSeeBigPicViewController.m
//  MeeBS
//
//  Created by liwei on 16/3/30.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "MeeSeeBigPicViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MeeSeeBigPicViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation MeeSeeBigPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    // 初始化界面
    [self setupUI];
}


- (void)setupUI
{
    // 添加scrollView
    UIScrollView * scrollView = [[UIScrollView alloc]init];
    // 设置scroolView的尺寸
    // 方式一：
    // 设置尺寸 因为View是重xib加载的宽度都是600
    // scrollView.frame = self.view.bounds;
    // 当设置 autoresizingMask ,当View 600 x 6000 缩放到屏幕大小时,scrollView 的尺寸也跟随一起缩放到屏幕大小
    // scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // 方式二：
    // scrollView.frame = CGRectMake(0, 0, MeeScreenW, MeeScreenH);
    
    // 方式三：
    scrollView.frame = [UIScreen mainScreen].bounds;
    
    // [self.view addSubview:scrollView]; 这样直接添加，会遮挡 xib中已经创建的按钮
    [self.view insertSubview:scrollView atIndex:0];
    
    
    // 在scrollView中添加图片
    UIImageView *imageView = [[UIImageView alloc]init];
    // 显示出图片内容
     [imageView sd_setImageWithURL:[NSURL URLWithString:self.topicModel.largeImage]];
    
    // 这种方式，没有图片缓存效果
    // NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.topicModel.largeImage]];
    // imageView.image = [UIImage imageWithData:imageData];
    
    // 设置图片的宽度，默认是屏幕的宽度
    imageView.width = MeeScreenW;
    // 设置图片的高度
    imageView.height = MeeScreenW / self.topicModel.width * self.topicModel.height;
    // 如果图片的高度小于屏幕的高度，就显示在屏幕的中央（等比缩放）
    // 如果图片的高度大于屏幕的高度，就从左上角显示
    if (self.topicModel.height >= MeeScreenH) {
        imageView.x = 0;
        imageView.y = 0;
    }else{
        imageView.centerX = MeeScreenW * 0.5;
        imageView.centerY = MeeScreenH * 0.5;
    }
    [scrollView addSubview:imageView];
    // 设置scrollView 可以滚动的范围,使超出了可以滚动
    scrollView.contentSize = CGSizeMake(0, imageView.height);
    
    // 设置图片的最大缩放和最新缩放比
    scrollView.minimumZoomScale = 0.5;
    if (self.topicModel.height > imageView.height) {
        scrollView.maximumZoomScale = self.topicModel.height / imageView.height;
    }
    
    // 设置scrollView的代理
    scrollView.delegate = self;
    self.imageView = imageView;
}

#pragma mark 
// 返回需要缩放的控件
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

// 缩放过程中，不断调用，调用频率很高
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    self.imageView.centerX = MeeScreenW * 0.5;
    self.imageView.centerY = MeeScreenH * 0.5;
}





- (IBAction)backBtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
