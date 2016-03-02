//
//  MeeUserModel.h
//  MeeBS
//
//  Created by liwei on 16/3/2.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeeHotUserModel : NSObject

// 最热评轮的用户的数据模型

@property (nonatomic, copy) NSString *sex; /**< 用户的性别 */
@property (nonatomic, copy) NSString *username; /**< 用户的名称 */
@property (nonatomic, copy) NSString *profile_image; /**< 用户头🐘 */


@end
