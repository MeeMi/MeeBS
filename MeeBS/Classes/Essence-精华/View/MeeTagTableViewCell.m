//
//  MeeTagTableViewCell.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/11/14.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeTagTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MeeTagTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;


@end

@implementation MeeTagTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setTagModel:(MeeTagModel *)tagModel
{
    _tagModel = tagModel;

    
    self.titleLabel.text = tagModel.theme_name;
    
  
    if (tagModel.sub_number >= 10000.0) {
        self.likeCountLabel.text  = [NSString stringWithFormat:@"%.1f万人订阅",tagModel.sub_number / 10000.0];
    }else{
         self.likeCountLabel.text  = [NSString stringWithFormat:@"%zd人订阅",tagModel.sub_number];
    }
    
    
    
    // [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:tagModel.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    [self.headerImageView setHeaderImage:tagModel.image_list];

}

// 设置cell之间的间距
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}


@end
