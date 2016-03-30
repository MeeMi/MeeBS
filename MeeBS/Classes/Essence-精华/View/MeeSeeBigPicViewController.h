//
//  MeeSeeBigPicViewController.h
//  MeeBS
//
//  Created by liwei on 16/3/30.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeeTopicModel.h"

@interface MeeSeeBigPicViewController : UIViewController

// 直接接受传递过来的模型,就可以直接拿到 图片的 url和 原始的宽高
@property (nonatomic, strong)  MeeTopicModel  *topicModel;

@end
