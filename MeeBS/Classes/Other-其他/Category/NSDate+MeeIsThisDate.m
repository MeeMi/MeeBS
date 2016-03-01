//
//  NSObject+MeeIsThisDate.m
//  MeeBS
//
//  Created by liwei on 16/3/1.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "NSDate+MeeIsThisDate.h"

@implementation NSDate (MeeIsThisDate)

- (BOOL)isThisYear
{
    // 获取日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 获取当前的系统时间
    NSDate *currentDate = [NSDate date];
    
    // 获取年份
    NSInteger currentYear = [calendar component:NSCalendarUnitYear fromDate:currentDate];
    
    NSInteger creatAtYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return currentYear == creatAtYear;
}


/** 判断是不是今天*/
- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *currentDate = [NSDate date];
    
    // 时间单元
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    // 比较两个日期之间的相差
    NSDateComponents *comp = [calendar components:unit fromDate:self toDate:currentDate options:0 ];
    
    return comp.year == 0 && comp.month == 0 && comp.day == 0;
}

- (BOOL)isYesterday
{
    // 2015-04-01 10:10:10 -> 2015-04-01 00:00:00
    // 2015-03-31 23:50:40 -> 2015-03-31 00:00:00
    // 将事件转换成 年月日的格式，值比较天数
    
    // 初始化时间格式
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"YYYY-MM-dd";
    
    // 先转成字符串，再转换成 NSDate
    // 系统时间
    NSString *currentDateStr = [fmt stringFromDate:[NSDate date]];
    NSDate *currentDate = [fmt dateFromString:currentDateStr];
    
    // 发表的时间
    NSString *creatAtStr = [fmt stringFromDate:self];
    NSDate *selfDate = [fmt dateFromString:creatAtStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comp = [calendar components:unit fromDate:selfDate toDate:currentDate options:0];
    return comp.year == 0 && comp.month == 0 && comp.day == 1;
}

/** 明天*/
- (BOOL)isTomorrow
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"YYYY-MM-dd";
    
    // 系统时间
    NSString *currentDateStr = [fmt stringFromDate:[NSDate date]];
    NSDate *currentDate = [fmt dateFromString:currentDateStr];
    
    // 发表的时间
    NSString *creatAtStr = [fmt stringFromDate:self];
    NSDate *selfDate = [fmt dateFromString:creatAtStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comps = [calendar components:unit fromDate:selfDate toDate:currentDate options:0];
    return comps.year == 0 && comps.month == 0 && comps.day == -1;
}

@end
