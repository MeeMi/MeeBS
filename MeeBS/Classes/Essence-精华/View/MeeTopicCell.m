//
//  MeeTopicCell.m
//  MeeBS
//
//  Created by 扬帆起航 on 16/2/24.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "MeeTopicCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MeeHotUserModel.h"

#import "MeeTopicPictureView.h"

@interface MeeTopicCell()

@property (weak, nonatomic) IBOutlet UIImageView *hreadImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;  // 文本内容

// 最热评论
@property (weak, nonatomic) IBOutlet UILabel *hotCommetLabel; // 最热评论内容

@property (weak, nonatomic) IBOutlet UIView *cmtToolView;

// 按钮旁边 的数字处理
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *pinglunBtn;


// cell类型 - 中间部分
// 因为最终要添加到 cell中 有个数组对其进行强引用。
@property (nonatomic, weak) MeeTopicPictureView *picView; /**< 图片的view */



@end


@implementation MeeTopicCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setTopicModel:(MeeTopicModel *)topicModel
{
    _topicModel = topicModel;
    
    // 设置头像(圆角头像)
    [self.hreadImageView setHeaderImage:self.topicModel.profile_image];
    
    // 设置昵称
    self.nameLabel.text = self.topicModel.name;
    
    // 设置时间
    self.timeLabel.text = self.topicModel.created_at;
    
    // 设置文本内容
    self.contentLabel.text = self.topicModel.text;
    
    // 最热评论的内容 (用户名 + 评论内容组成)
    // 方式一： 直接使用最热评论的 NSArray 数组（不使用数据模型）
    /*
    if(topicModel.top_cmt.count){  // 不为0 ，说明有最热评论
        // 在cell防止重用，if else 都要进行 hidden设置
        
        self.cmtToolView.hidden = NO;
        // 获取最热评论的内容
        NSDictionary *cmtDic = topicModel.top_cmt[0];
        
        // 获取用户名
        NSString *userName = cmtDic[@"user"][@"username"];
        
        // 评论的内容
        NSString *cmtText = cmtDic[@"content"];
        
        self.hotCommetLabel.text = [NSString stringWithFormat:@"%@ : %@",userName,cmtText];
        
    }else{
        self.cmtToolView.hidden = YES;
    }
     */
    
    // 方式二： 使用模型中 转出模型对数据进行处理最热评论
    if (topicModel.topCmt) { // 不为空，表示有最热评论
        self.cmtToolView.hidden = NO;
        // 获取用户名
        
        NSString *userName = topicModel.topCmt.userModel.username;
        // 最热评论的内容
        NSString *cmtText = topicModel.topCmt.content;
        self.hotCommetLabel.text = [NSString stringWithFormat:@"%@ : %@",userName,cmtText];
        
    }else{
        self.cmtToolView.hidden =YES;
    }
    
    
    // 方式三：还是用数组的参数，但告诉数组中装的模型是 MeeHotCmtModel
    /*
    if (topicModel.hotTopCmtModels.count) {  // 不为 0 ，表示有最热评论
        self.cmtToolView.hidden = NO;
        
        MeeHotCmtModel *hotCmtModel = topicModel.hotTopCmtModels[0];
        // 用户名
        NSString *userName = hotCmtModel.userModel.username;
        // 评论内容
        NSString *cmtText = hotCmtModel.content;
        self.hotCommetLabel.text = [NSString stringWithFormat:@"%@ : %@",userName,cmtText];
    }else{
        self.cmtToolView.hidden = YES;
    }
     */
    
    
    // 处理 工具条上 点赞 分享 上面的数组
    /*
    if(topicModel.cai >= 10000.0){
        [self.caiBtn setTitle:[NSString stringWithFormat:@"%0.1f万",topicModel.cai / 10000.0] forState:UIControlStateNormal];
    }else if(topicModel.cai == 0){
        [self.caiBtn setTitle:@"踩" forState:UIControlStateNormal];
    }else{
        [self.caiBtn setTitle:[NSString stringWithFormat:@"%zd",topicModel.cai] forState:UIControlStateNormal];
    }
     */
    [self setButtonTitle:self.dingBtn andTitle:@"顶" andCount:topicModel.ding];
    [self setButtonTitle:self.caiBtn andTitle:@"踩" andCount:topicModel.cai];
    [self setButtonTitle:self.shareBtn andTitle:@"分享" andCount:topicModel.repost];
    [self setButtonTitle:self.pinglunBtn andTitle:@"评论" andCount:topicModel.comment];
    
    
    
    // 帖子中间的 控制器处理
    if (topicModel.type == MeeTopicTypePicture) {
        // 图片帖子
        // 设置中间 控件的 frame
        self.picView.hidden = NO;
        self.picView.topicModel = topicModel;
        self.picView.frame = topicModel.centerViewFrame;
        
    }else if(topicModel.type == MeeTopicTypeVideo){
        // 视频帖子
        self.picView.hidden = YES;
    }else if (topicModel.type == MeeTopicTypeVoice){
        // 声音帖子
        self.picView.hidden = YES;
    }else{
        // 文字帖子
        self.picView.hidden = YES;
    }
    
}


// 对按钮上 的数字处理，单独抽方法进行封装
- (void)setButtonTitle:(UIButton *)btn andTitle:(NSString *)title andCount:(NSInteger)count
{
    if(count >= 10000.0){
        [btn setTitle:[NSString stringWithFormat:@"%0.1f万",count / 10000.0] forState:UIControlStateNormal];
    }else if(count == 0){
        [btn setTitle:title forState:UIControlStateNormal];
    }else{
        [btn setTitle:[NSString stringWithFormat:@"%zd",count] forState:UIControlStateNormal];
    }
}



// 当帖子的类型是 - 《图片》
// 懒加载创建 图片的view ，添加到 MeeTopicCell中
#pragma mark - 创建图片的view
// 在cell中使用懒加载 - 减少重复创建和销毁，提供性能
- (MeeTopicPictureView *)picView
{
    //   弱引用，会被销毁,这样懒加载不器作用 _pictureView 还是会为空的
    //  _pictureView = [MeeTopicPictureView pictureView];
    //   MeeTopicPictureView *pictureView 局部强引用指向创建的对象

    if (_picView == nil) {
        // 图片的 view 是通过 xib创建，所以要通过 沙盒 找到 xib 加载
        MeeTopicPictureView *pictureView  = [MeeTopicPictureView pictureView];
        _picView = pictureView;
        // 添加
        [self.contentView addSubview:_picView];
    }
    return _picView;
}









// 重写setFrame
// 当封装一些控件时，不想外界改变控件的大小，可以在这个位置，直接设置固定尺寸。因为外界改变尺寸，最终会来到这个方法，被拦截了，进行重写设置
// 重写setFrame方法：拦截cell对frame设置
// 只要cell的尺寸和位置改变，都会调用这个方法进行设置
// 重写这个方法可以设置：cell与屏幕两端的距离
// 可以再调用父类之前修改高度，设置cell之间的分割线
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    [super setFrame:frame];
   
}


@end
