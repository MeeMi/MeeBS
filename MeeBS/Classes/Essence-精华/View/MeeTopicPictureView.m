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

@end
