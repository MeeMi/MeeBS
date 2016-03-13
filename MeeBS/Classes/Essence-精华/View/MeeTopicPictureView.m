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
    
    // 对进度条设置

//    self.progressView.progressTintColor = [UIColor blueColor];
//    self.progressView.trackTintColor = [UIColor redColor];

    __weak typeof(self) weakSef = self;
    // 设置图片
    [_imageView sd_setImageWithURL:[NSURL URLWithString:topicModel.largeImage] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        NSLog(@"========%ld",(long)expectedSize);
        //if(receivedSize < 0 || expectedSize < 0) return ;
        // 设置图片下载进度
        weakSef.progressView.hidden = NO;

//
//        // 只要图片下载一点就会调用(频繁)(对进度条的属性设置，就方法外面)
        CGFloat progressValue = 1.0 * receivedSize / expectedSize;
        weakSef.progressView.progress = progressValue;
        weakSef.progressView.progressLabel.text = [NSString stringWithFormat:@"%0.f%%",progressValue * 100];
        
        self.progressView.roundedCorners = 5;
        self.progressView.progressLabel.textColor = [UIColor redColor];
        
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 图片下载完成操作
        // weakSef.progressView.hidden = YES;
    }];
    self.progressView.hidden = YES;
    
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
    }else{
        self.seeBigPicButton.hidden = YES;
    }
}


@end
