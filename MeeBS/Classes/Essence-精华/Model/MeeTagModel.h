//
//  MeeTagModel.h
//  MeeBS
//
//  Created by 扬帆起航 on 15/11/14.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MeeTagModel : NSObject

@property (nonatomic, copy) NSString *theme_name; /**< 标题 */
@property (nonatomic, assign) NSInteger sub_number; /**< 订阅数 */
@property (nonatomic, copy) NSString *image_list; /**< 图像 */



@end
