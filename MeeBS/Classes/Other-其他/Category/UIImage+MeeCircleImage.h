//
//  UIImageView+MeeCircleImage.h
//  MeeBS
//
//  Created by 扬帆起航 on 15/11/15.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MeeCircleImage)

// 方法一：对象方法
- (instancetype)circleImage;

// 类方法需要
+ (instancetype)circleImageName:(NSString*)imageName;

@end
