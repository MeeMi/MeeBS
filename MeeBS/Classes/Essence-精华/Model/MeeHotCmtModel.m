//
//  MeeHotCmtModel.m
//  MeeBS
//
//  Created by liwei on 16/3/2.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "MeeHotCmtModel.h"
#import <MJExtension.h>

@implementation MeeHotCmtModel

// 告诉模型，要用那个 【属性名】替换 字典【key】
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"userModel" : @"user"};
}

@end
