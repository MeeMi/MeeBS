//
//  MeeTopicModel.h
//  MeeBS
//
//  Created by 扬帆起航 on 16/2/24.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MeeHotCmtModel.h"

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


// 创建帖子类型的枚举
typedef enum{
    /**< 全部 */
    MeeTopicAll = 1,
    /**< 图片帖子 */
    MeeTopicTypePicture = 10,
    /**< 声音帖子 */
    MeeTopicTypeVoice = 31,
    /**< 文字帖子 */
    MeeTopicTypeWord = 29,
    /**< 视频帖子 */
    MeeTopicTypeVideo = 41
}MeeTopicType;

// 帖子类型的参数
@property (nonatomic, assign) MeeTopicType type;


// 最热评论
/** 方式一 ： 直接用最原始的 NSArray */
// @property (nonatomic, strong) NSArray *top_cmt;

/** 方式二 */
/** 将数组中的内容最终转换成 数据模型（MeeHotCmtModel） */
// 直接让数组中只有一个字典，之间取出数组中的第一元素为 MeeHotCommentModel
// 声明 【模型属性名】，对应的[字典key] @"topCmt" : @"top_cmt[0]"
// 需要在 .m文件中对【数据转模型进行设置】

// 将字典数组中 - 第一个字典数组 - 转换成MeeHotCmtModel模型
@property (nonatomic, strong)   MeeHotCmtModel *topCmt;

/** 方式三 */
// 告诉数组中装的 模型
@property (nonatomic, strong)  NSArray  * hotTopCmtModels;


/** 显示图片 */
// 需要进行 声明 【模型属性名】对应[字典key]
@property (nonatomic, copy) NSString *smallImage; /**< image0 */
@property (nonatomic, copy) NSString *middleImage; /**< image2 */
@property (nonatomic, copy) NSString *largeImage; /**< image1 */

// 判断是不是gif图片
@property (nonatomic, assign, getter=isGif) BOOL gif;


/**< 辅助属性 */
// 在计算图片frame时,如果图片高度超过一定的值,设置为大图
@property (nonatomic, assign ,getter=isBigPicture) BOOL bigPicture; /**< 是否是大图 */
@property (nonatomic, assign) CGRect centerViewFrame; /**<中间控件的尺寸*/ 


@property (nonatomic, assign) CGFloat height; /**<高度 */
@property (nonatomic, assign) CGFloat width; /**<宽度 */



@end
