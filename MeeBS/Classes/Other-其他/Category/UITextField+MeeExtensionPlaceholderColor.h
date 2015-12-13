//
//  UITextField+MeeExtensionPlaceholderColor.h
//  MeeBS
//
//  Created by 扬帆起航 on 15/12/13.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (MeeExtensionPlaceholderColor)

// 给UITextField 创建分类，增加设置占位文字的颜色和大小的功能

// @property在类中功能:会自动生成get,set方法的声明和实现,和_成员属性.

// @property在分类功能:只会生成get,set方法的声明
@property (nonatomic, strong) UIColor *placeHolderColor; /**< 占位文字颜色 */
@property (nonatomic, strong) UIFont *placeHolderFont; /**< 占位文字的大小 */

@end
