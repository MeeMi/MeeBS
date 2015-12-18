//
//  MeeUserModel.h
//  MeeBS
//
//  Created by 扬帆起航 on 15/12/18.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeeUserModel : NSObject

@property (nonatomic, copy) NSString *fans_count; /**< 粉丝数 */
@property (nonatomic, copy) NSString *header; /**< 头像的链接 */
@property (nonatomic, copy) NSString *screen_name; /**<名称 */

@end
