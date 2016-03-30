//
//  MeeTopicPictureView.m
//  MeeBS
//
//  Created by liwei on 16/3/4.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "MeeTopicPictureView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <DALabeledCircularProgressView.h>

#import "MeeSeeBigPicViewController.h"

@interface MeeTopicPictureView() 
@property (weak, nonatomic) IBOutlet UIImageView *gifPic;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPicButton;

@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;



@end

@implementation MeeTopicPictureView

+ (instancetype)pictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MeeTopicPictureView class]) owner:nil options:nil]lastObject];
}


// 因为是重storyBoard ， xib 中加载的view所以，用awakeFromNib
- (void)awakeFromNib
{
    // self.backgroundColor = [UIColor redColor];
    
    // 通过了 frame 设置了从 xib加载的View，就要禁止掉 View的自动拉伸
    self.autoresizingMask = UIViewAutoresizingNone;
}


// 对图片进行设置
- (void)setTopicModel:(MeeTopicModel *)topicModel
{
    _topicModel = topicModel;
    __weak typeof(self) weakSelf = self;
    // 设置进度条的熟悉设置
    self.progressView.roundedCorners = 5;
    self.progressView.progressLabel.textColor = [UIColor blueColor];
    self.progressView.progressTintColor = [UIColor grayColor];
    self.progressView.trackTintColor = [UIColor lightGrayColor];
    // 对进度条设置
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topicModel.largeImage] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        // 会对图片进行下载，条用比较平凡
        // 设置进度条
        if(receivedSize < 0 || expectedSize < 0 ) return ;
        weakSelf.progressView.hidden = NO;
        
        CGFloat progressValue = 1.0 * receivedSize / expectedSize;
        weakSelf.progressView.progress = progressValue;
        weakSelf.progressView.progressLabel.text = [NSString stringWithFormat:@"%0.1f%%",progressValue * 100];
        
     } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        weakSelf.progressView.hidden = YES;
    }];


    
    // 对图片进行判断
    // 1.判断是不是 GIF 图片
    // 方式一： 直接用模型中的属性
//    if(topicModel.isGif) {
//        self.gifPic.hidden = NO;
//    }else{
//        self.gifPic.hidden = YES;
//    }
    
    // 方式二：判断链接的后缀名
    /*
    if([topicModel.largeImage hasSuffix:@"gif"]){
        self.gifPic.hidden = NO;
    }else{
        self.gifPic.hidden = YES;
    }
    */
    
    // 方式三：判断链接的扩展名
    NSString *extensionName = [topicModel.largeImage pathExtension];
    if ([extensionName isEqualToString:@"gif"]) {
        self.gifPic.hidden = NO;
    }else{
        self.gifPic.hidden = YES;
    }
    
    
    // 2.判断是不是 大图
    if(topicModel.bigPicture){
        self.seeBigPicButton.hidden = NO;
        // 设置图片的显示模式
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    }else{
        self.seeBigPicButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
}

// 点击查看大图
- (IBAction)seeBigPicBtn:(UIButton *)sender {
    if (self.imageView.image == nil) return;  // 当图片没有下载完，禁止点击按钮跳转
    MeeSeeBigPicViewController *seeVc = [[MeeSeeBigPicViewController alloc]init];
    seeVc.topicModel = self.topicModel;
    [self.window.rootViewController presentViewController:seeVc animated:YES completion:nil];
}



@end
