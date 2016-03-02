//
//  MeeHotCmtModel.h
//  MeeBS
//
//  Created by liwei on 16/3/2.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MeeHotUserModel;

@interface MeeHotCmtModel : NSObject

// 最热评论的数据模型

// 分析，将最热评理创建一个模型 存放 content 和 user ，因为最热评理只需这个两个属性
// user 是以字典形式存在，存放用户的多个信息。将user创建存模型

// 最热评论内容
@property (nonatomic, copy)  NSString  *content;
@property (nonatomic, strong)  MeeHotUserModel  *userModel; // userModel 替换 user属性名


@end
