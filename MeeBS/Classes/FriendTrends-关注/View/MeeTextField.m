//
//  MeeTextField.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/12/13.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeTextField.h"
#import "UITextField+MeeExtensionPlaceholderColor.h"

NSString * const MeePlaceholderLabelColor = @"placeholderLabel.textColor";
@implementation MeeTextField


/**
 *  因为 有个四个个UITextField，需要修改placeHolder（占位文字的属性），所以就自定义 UITextField，然后在storyBorad中修改UITextField为 自定义MeTextField
 */


// 因为是从 storyBoard中创建的 UITextField，说有就在 awakeFromNib进行初始化
- (void)awakeFromNib
{
    // 设置光标的颜色
    self.tintColor = [UIColor redColor];
    // 设置文本文字
    self.textColor = [UIColor whiteColor];
    
    // 修改 placeHolder占位文字的属性
    // 方式一 ： 用富文本的方式
    // [self setMutableAttr];
    // 方式二：通过 KVC 修改内部属性
    // [self setValue:[UIFont systemFontOfSize:15] forKeyPath:@"placeholderLabel.font"];
    // [self setValue:[UIColor grayColor] forKeyPath:@"placeholderLabel.textColor"];
    // 直接将上面的方法封装到分类中
    self.placeHolderColor = [UIColor grayColor];
    self.placeHolderFont = [UIFont systemFontOfSize:15];
    
    //监听一个控件的行为 ：
    // 1. 代理 （希望别的类成为代理，自己成为自己代理很危险（不建议这样做）因为很容易被覆盖掉）
    // 2. 通知
    // 3. addTargert
    
    //这里使用： addTargert (有几个UITextField的监听事件)
    [self addTarget:self action:@selector(beginEditingText) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(endEditingText) forControlEvents:UIControlEventEditingDidEnd];
}

#pragma mark - 动态改变占位文字颜色
// 当文本没有成为第一响应，placeHolder 文字颜色为灰色，成为第一响应为白色
// 方式一： 重写父类的方法
/*
// 成为第一响应
- (BOOL)becomeFirstResponder
{
    [self setValue:[UIColor whiteColor] forKeyPath:MeePlaceholderLabelColor];
    return [super becomeFirstResponder];
}
// 失去第一响应
- (BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:MeePlaceholderLabelColor];
    return [super resignFirstResponder];
}
*/

// 方式二： addTargert
- (void)beginEditingText
{
    // [self setValue:[UIColor whiteColor] forKeyPath:MeePlaceholderLabelColor];
    self.placeHolderColor = [UIColor whiteColor];
}

- (void)endEditingText
{
    // [self setValue:[UIColor grayColor] forKeyPath:MeePlaceholderLabelColor];
    self.placeHolderColor = [UIColor grayColor];
}




#pragma mark - 富文本修改占位文字颜色
// 富文本的方式，修该占位文字的 颜色和大小
- (void)setMutableAttr
{
    NSMutableDictionary *attrDic = [NSMutableDictionary dictionary];
    attrDic[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    attrDic[NSForegroundColorAttributeName] = [UIColor whiteColor];
    self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeholder attributes:attrDic];
}

@end
