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

// 其实 tablView中提供了 cell选中和取消的代理方法
// 但是 更加单一原则,cell的选中状态修改配置,应该在cell内部中完成
// 所以比建议将cell选中,修改cell的配置在 控制器中的代理方法

// 系统提供的方法,只要cell的选中状态改变,可以可以再这个里面进行相关View的设置
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if(selected){
        self.nameLabel.textColor = [UIColor redColor];
        self.redViewIndicator.hidden = NO;
    }else{
        self.nameLabel.textColor = [UIColor blackColor];
        self.redViewIndicator.hidden = YES;
    }
 
}

- (void)setCategoryModel:(MeeCategoryModel *)categoryModel
{
    _categoryModel = categoryModel;
    self.nameLabel.text = categoryModel.name;
}

@end
