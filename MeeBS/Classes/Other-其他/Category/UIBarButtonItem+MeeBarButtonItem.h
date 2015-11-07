//
//  UIBarButtonItem+MeeBarButtonItem.h
//  MeeBS
//
//  Created by 扬帆起航 on 15/11/7.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MeeBarButtonItem)

+ (UIBarButtonItem *) barItemWithImage:(NSString *)image andSelectImage:(NSString *)selectImage action:(SEL)action andTarget:(id)target;

@end
