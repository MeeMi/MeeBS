//
//  MeeOtherCell.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/12/16.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeOtherCell.h"

@implementation MeeOtherCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 设置cell之间的间距
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
