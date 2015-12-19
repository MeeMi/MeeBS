//
//  MeeCategoryCell.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/12/19.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeCategoryCell.h"

@interface MeeCategoryCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *redViewIndicator; /**< 红色指示器 */

@end


@implementation MeeCategoryCell

- (void)awakeFromNib {
   
}

// 系统提供的方法,只要cell的选中状态改变,可以可以再这个里面进行相关View的设置
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    NSLog(@"--是否-->%d",selected);
}

- (void)setCategoryModel:(MeeCategoryModel *)categoryModel
{
    _categoryModel = categoryModel;
    self.nameLabel.text = categoryModel.name;
}

@end
