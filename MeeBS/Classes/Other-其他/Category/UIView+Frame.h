//
//  UIView+Frame.h
//  彩票
//
//  Created by 扬帆起航 on 15/8/29.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

// @property在类中功能:会自动生成get,set方法的声明和实现,和_成员属性.

// @property在分类功能:只会生成get,set方法的声明

@property (nonatomic, assign) CGFloat x;/**< <#注释#> */
@property (nonatomic, assign) CGFloat y;/**< <#注释#> */
@property (nonatomic, assign) CGFloat width;/**< <#注释#> */
@property (nonatomic, assign) CGFloat height;/**< <#注释#> */

@property (nonatomic, assign) CGFloat centerX;/**< <#注释#> */
@property (nonatomic, assign) CGFloat centerY;/**< <#注释#> */

@end
