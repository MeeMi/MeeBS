//
//  MeeCategoryModel.h
//  MeeBS
//
//  Created by 扬帆起航 on 15/12/18.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

// #import "MeeUserModel.h"
@class MeeUserModel;

@interface MeeCategoryModel : NSObject

// 属性
@property (nonatomic, strong) NSString *categoryID; /**< id */
@property (nonatomic, strong) NSString *name; /**< 标签的名称 */

@property (nonatomic, strong) NSArray<MeeUserModel *> *users; /**< 存放用户数据模型的数组 */

@end
