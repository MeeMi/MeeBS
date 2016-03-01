//
//  NSObject+MeeIsThisDate.h
//  MeeBS
//
//  Created by liwei on 16/3/1.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MeeIsThisDate)

/** 判断是不是今年 */
- (BOOL)isThisYear;

/** 判断是不是今天 */
- (BOOL)isToday;

/** 判断是不是昨天 */
- (BOOL)isYesterday;

/** 判断是否是明天 */
- (BOOL)isTomorrow;

@end
