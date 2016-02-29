//
//  MeeTopicModel.h
//  MeeBS
//
//  Created by 扬帆起航 on 16/2/24.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>


// 帖子的数据模型
@interface MeeTopicModel : NSObject

@property (nonatomic, copy) NSString *name; /**< 用户名 */

@property (nonatomic, copy) NSString *text; /**< 帖子内容  */

@property (nonatomic, copy) NSString *profile_image; /**< 头像 */

@property (nonatomic, copy) NSString *created_at; /**< 系统审核通过后创建帖子的时间
                                                   */

// 注意：  服务器返回的数据类型是 NSString 类型，但是运用第三方的框架，转换成定义的类型属性
@property (nonatomic, assign) NSInteger cai; /**< 踩 */

@property (nonatomic, assign) NSInteger ding; /**< 顶 */

@property (nonatomic, assign) NSInteger repost; /**< 转发 */

@property (nonatomic, assign) NSInteger comment; /**< 评论 */



// 计算cell的高度
@property (nonatomic, assign) CGFloat cellHeight; /**< cell的高度 */


@end
