//
//  MeeUserModel.h
//  MeeBS
//
//  Created by 扬帆起航 on 15/12/18.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeeUserModel : NSObject

// 服务 fans_count是NSString 类型，但是实际应用需要 NSInteger，所以在模型中直接用NSInteger类型，MJExtension会自动转换的
@property (nonatomic, assign) NSInteger fans_count; /**< 粉丝数 */
@property (nonatomic, copy) NSString *header; /**< 头像的链接 */
@property (nonatomic, copy) NSString *screen_name; /**<名称 */

@end
