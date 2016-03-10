//
//  MeeTopicPictureView.m
//  MeeBS
//
//  Created by liwei on 16/3/4.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "MeeTopicPictureView.h"

@interface MeeTopicPictureView() 
@property (weak, nonatomic) IBOutlet UIImageView *gifPic;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPicButton;

@end

@implementation MeeTopicPictureView

+ (instancetype)pictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MeeTopicPictureView class]) owner:nil options:nil]lastObject];
}


// 因为是重storyBoard ， xib 中加载的view所以，用awakeFromNib
- (void)awakeFromNib
{
    self.backgroundColor = [UIColor redColor];
    
    // 通过了 frame 设置了从 xib加载的View，就要禁止掉 View的自动拉伸
    self.autoresizingMask = UIViewAutoresizingNone;
}


// 对图片进行设置
- (void)setTopic:(MeeTopicModel *)topic
{
    
}


@end
