//
//  UITextField+MeeExtensionPlaceholderColor.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/12/13.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "UITextField+MeeExtensionPlaceholderColor.h"

NSString * const MeePlaceHolderFont = @"placeholderLabel.font";
NSString * const MeePlaceHolderColor = @"placeholderLabel.textColor";

@implementation UITextField (MeeExtensionPlaceholderColor)

// 给UITextField增加分类，修改 placeholder的占位文文字的颜色和大小

#pragma mark - 设置占位文字的颜色
- (void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    // 设置占位文字的颜色有个个要求必须，先用占位文字，才能设置设置 占位文字的大小和颜色
    // 但是也要满足 ， 先设置占位文字的颜色，在有文字的情况，设置的颜色也是有效的
    BOOL change = NO;
    if(self.placeholder == nil){ // 当占位文字是空的情况的
        self.placeholder = @" "; // 将其值设置为 @“ ” 表示是空字符串
        change = YES;
    }
    // 如果颜色值为nil，设置默认颜色
    if (placeHolderColor == nil) {
         // 使用默认的颜色 70 %的灰色
         [self setValue:MeeGrayColor(255 * 0.7) forKeyPath:MeePlaceHolderColor];
    }else{
        // 在设置 占位文字的颜色
        [self setValue:placeHolderColor forKeyPath:MeePlaceHolderColor];
    }
    // 当为placeHolder == nil时，我将其值改为nil，同时再设置颜色，同时我们最好是将改变颜色后，设置回 nil
    if (change) {
        self.placeHolderColor = nil;
    }
}

- (UIColor *)placeHolderColor
{
    return [self valueForKeyPath:MeePlaceHolderColor];
}


#pragma mark - 设置占位文字的大小
- (void)setPlaceHolderFont:(UIFont *)placeHolderFont
{
    // 设置 占位文字的大小，同时也要先用占位才能生效
    if(placeHolderFont == nil){
        [self setValue:[UIFont systemFontOfSize:15] forKeyPath:MeePlaceHolderFont];
    }else{
        // 要满足，先设置大写，在设置占位文字，也能生效
        
        // 1.先保存占位文字的内容
        NSString *placeText = self.placeholder;
        // 2.不管placeholder是有值，还是 nil， 向将placeholder内容统一设置为 @“ ”
        self.placeholder = @" ";
        // 3.设置占位文字的大小
        [self setValue:placeHolderFont forKeyPath:MeePlaceHolderFont];
        // 4.将保存的文字大小还原
        self.placeholder = placeText;
    }
}

- (UIFont *)placeHolderFont
{
    return [self valueForKeyPath:MeePlaceHolderFont];
}

@end
