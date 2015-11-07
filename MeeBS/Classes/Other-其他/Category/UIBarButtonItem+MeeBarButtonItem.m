//
//  UIBarButtonItem+MeeBarButtonItem.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/11/7.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "UIBarButtonItem+MeeBarButtonItem.h"

@implementation UIBarButtonItem (MeeBarButtonItem)

+ (UIBarButtonItem *) barItemWithImage:(NSString *)image andSelectImage:(NSString *)selectImage action:(SEL)action andTarget:(id)target
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateHighlighted];
    // 设置按钮的尺寸，否则无法显示
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

@end
