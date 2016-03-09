//
//  MeeTopicPictureView.h
//  MeeBS
//
//  Created by liwei on 16/3/4.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeeTopicModel.h"

@interface MeeTopicPictureView : UIView

@property (nonatomic, strong) MeeTopicModel *topic; /**< 数据模型 */


+ (instancetype)pictureView;

@end
