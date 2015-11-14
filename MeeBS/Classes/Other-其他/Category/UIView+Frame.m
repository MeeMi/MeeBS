//
//  UIView+Frame.m
//  彩票
//
//  Created by 扬帆起航 on 15/8/29.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

/**
 设置 x
 */

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

/**
 设置 y
 */

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(CGFloat)y
{
    return self.frame.origin.y;
}
/**
 设置 width
 */

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame =frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

/**
 设置 height
 */
- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame =frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

/**
 设置 centerX
 */
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint point = self.center;
    point.x = centerX;
    self.center = point;
}

- (CGFloat)centerX
{
    return self.center.x;
}

/**
 设置 centerY
 */
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint point = self.center;
    point.y = centerY;
    self.center = point;
}

- (CGFloat)centerY
{
    return self.center.y;
}


@end



















