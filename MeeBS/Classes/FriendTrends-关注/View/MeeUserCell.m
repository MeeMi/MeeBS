//
//  MeeUserCell.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/12/19.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeUserCell.h"


@interface MeeUserCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerImgeView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation MeeUserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUserModel:(MeeUserModel *)userModel
{
    _userModel = userModel;
    
    [self.headerImgeView setHeaderImage:userModel.header];
    self.userNameLabel.text = userModel.screen_name;
    if(userModel.fans_count >= 10000.0){
        self.fansCountLabel.text = [NSString stringWithFormat:@"%.1f万人",userModel.fans_count / 10000.0];
    }else{
        self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人",userModel.fans_count];
    }
    
}
@end
