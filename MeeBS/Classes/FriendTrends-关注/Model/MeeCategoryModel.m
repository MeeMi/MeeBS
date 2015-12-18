//
//  MeeCategoryModel.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/12/18.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeCategoryModel.h"
#import <MJExtension.h>

@implementation MeeCategoryModel

// 声明模型属性的中 对应字典中【key】
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"categoryID" : @"id"};
}


@end
