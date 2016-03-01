//
//  MeeTopicModel.m
//  MeeBS
//
//  Created by 扬帆起航 on 16/2/24.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "MeeTopicModel.h"

@implementation MeeTopicModel

// 对数据处理

// 对发布时间处理

/*
 1.今年
 1> 今天
 1) 时间间隔 >= 1个小时 -> 5小时前
 2) 1个小时 > 时间间隔 >= 1分钟 -> 25分钟前
 3) 时间间隔 < 1分钟 -> 刚刚
 
 2> 昨天 -> 昨天 17:56:34
 
 3> 其他 -> 07-06 19:47:57
 
 2.非今年 -> 2014-08-06 19:47:57
 */


// 最原始的时间处理方式
/*
- (NSString *)created_at
{
//     _created_at = @"2014-08-06 19:47:57";
     _created_at = @"2016-02-29 22:43:00";
    
    // 1.created_at 是服务器返回字符串时间，需要转换成NSDate
    // 创建一个日期格式
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *creatAtDate = [fmt dateFromString:_created_at];
    
    // 获取系统当前的时间
    NSDate *currentDate = [NSDate date];
    
    // 获取日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 当前时间的年份
    NSInteger currentYear = [calendar component:NSCalendarUnitYear fromDate:currentDate];
    // 要处理时间的年份
    NSInteger creatAtYear = [calendar component:NSCalendarUnitYear fromDate:creatAtDate];
    
    // 判断是不是今年
    if(creatAtYear == currentYear){
        // 今年
        // 判断是不是今天
        if ([calendar isDateInToday:creatAtDate]) { // 今天
            // 时间间隔
            // 创建时间单元
            NSCalendarUnit unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *comp = [calendar components:unit fromDate:creatAtDate toDate:currentDate options:0 ];
            if (comp.hour >= 1) {
                return [NSString stringWithFormat:@"%zd小时前",comp.hour];
            }else if(comp.second < 60){
                return @"刚刚";
            }else{
                return [NSString stringWithFormat:@"%zd分钟前",comp.minute];
            }
            
        }else if([calendar isDateInYesterday:creatAtDate]){ // 昨天
            fmt.dateFormat = @"HH:mm:ss";
            return [NSString stringWithFormat:@"昨天 %@",[fmt stringFromDate:creatAtDate]];
        }else{ // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:creatAtDate];
        }

    }else{
        // 非今年
        return _created_at;
        
    }
    return nil;
}
*/

// 时间处理方式二：
/** 写一个时间的分类，判断日期是今年、今天、明天、昨天*/
- (NSString *)created_at
{
    return nil;
}




@end
