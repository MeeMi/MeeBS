//
//  MeeConst.h
//  MeeBS
//
//  Created by 扬帆起航 on 15/11/14.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeeConst : NSObject

// 对这个系统的常量进行设置

// extern NSString *consnt MeeBaseUrl ;

// 模仿苹果官方的 引用常量的写法
// 最好导入,如果要到框架中定义的数据类型 如：CGFloat
// UIKIT_EXTERN

// 添加引用
UIKIT_EXTERN NSString * const MeeBaseUrl;

UIKIT_EXTERN NSInteger const MeeMargin;

UIKIT_EXTERN NSInteger const MeeNavHeight;

@end
