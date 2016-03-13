//
//  MeeTopicModel.m
//  MeeBS
//
//  Created by 扬帆起航 on 16/2/24.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "MeeTopicModel.h"
#import <MJExtension.h>
#import "MeeHotUserModel.h"

@implementation MeeTopicModel

// 对数据处理

#pragma mark - 对发布时间处理

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
             }else if(comps.minute >= 1){
                return [NSString stringWithFormat:@"%zd分钟前",comps.minute];
             }else{
                return @"刚刚";
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
    _created_at = @"2016-03-01 17:38:50";
    
    
    // 将服务器上的发表的时间 由 字符串 转化成 NSDate
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    NSDate *creatAtDate = [fmt dateFromString:_created_at];
    
    if([creatAtDate isThisYear] == YES){ // 今年
        if ([creatAtDate isToday]) {
            // 今天
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSCalendarUnit unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *comps = [calendar components:unit fromDate:creatAtDate toDate:[NSDate date] options:0];
            
            if(comps.hour >= 1){
                // 几小时前
                return [NSString stringWithFormat:@"%zd小时前",comps.hour];
            }else if(comps.minute >= 1){
                return [NSString stringWithFormat:@"%zd分钟前",comps.minute];
                
            }else{
                return @"刚刚";
            }
            
        }else if([creatAtDate isYesterday]){
            // 昨天
            // 昨天 17:56:34
            // fmt.dateFormat = @"HH:mm:ss";
            // return [NSString stringWithFormat:@"昨天 %@",[fmt dateFromString:_created_at]];
            
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:creatAtDate];
            
        }else{
            // 其他
            // 07-06 19:47:57
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:creatAtDate];
        }
    }else{
        // 非今年
        return _created_at;
    }
}


#pragma mark - 计算中间(图片,声音,视频)的frame
// 把计算中间view 的 frame留在 模型中计算，而不是在添加中间部分计算原因：
// 计算中间部分 frame 。 其他属性（如帖子的内容）
- (CGRect)centerViewFrame
{
    if(_centerViewFrame.size.width) return _centerViewFrame;
    
    CGFloat centerViewX = MeeMargin;
    
    // 帖子的文字内容
    CGFloat textY = 55;
    // 文字内容的 宽度是固定的，通过 固定宽度 - 计算高度
    CGFloat textW = MeeScreenW - 2 * centerViewX;
    CGFloat textH = [self.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
    CGFloat centerViewY = textY + textH + MeeMargin;
    // 中间控件的高度(可以通过模型属性获取)
    // 因为获取到的尺寸很大,所以进行等比缩放
    CGFloat centerViewW = textW;
    CGFloat centerViewH = centerViewW / self.width * self.height;
    
    // 如果处理后的高度，任然大于 屏幕高度。设置高度 为固定值。同时可以认定 图片为大图
    if (centerViewH > MeeScreenH) {
        self.bigPicture = YES;
        centerViewH = 200;
    }

    return  _centerViewFrame = CGRectMake(centerViewX, centerViewY, centerViewW, centerViewH);
 }

#pragma mark - 计算cell的高度
- (CGFloat)cellHeight
{
    if (_cellHeight) return _cellHeight;
    // 文字
    CGFloat textY = 55;
    CGFloat textW = MeeScreenW - 2 * MeeMargin;
    CGFloat textH = [self.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
    
    // 没有中间控件时
    _cellHeight = textY + textH + MeeMargin;
    
    // 有中间控件的时候，计算中间控件的高度
    if(self.type != MeeTopicTypeWord){
        _cellHeight = CGRectGetMaxY(self.centerViewFrame) + MeeMargin;
    }
    
    // 有最热评论
    if(self.topCmt){
        // 标题高度
        CGFloat titleHeight = 20;
        // 计算内容的高度
        NSString *contentStr = [NSString stringWithFormat: @"%@ : %@",self.topCmt.userModel.username,self.topCmt.content];
        CGFloat contentHeight = [contentStr boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
        _cellHeight += titleHeight + contentHeight + MeeMargin;
    }
    
    // 底部工具条的高度
    CGFloat bottomToolViewHeight = 35;
    _cellHeight += bottomToolViewHeight + MeeMargin;
    
    return _cellHeight;
}





#pragma mark - 对数据转模型进行设置
// 对MJ框架的配置可以单独抽取一个类进行配置

// 用自己定义的属性名，替换掉字典中的【key】
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    // 将字典数组中 - 第一个字典数组 - 转换成MeeHotCmtModel模型
    return @{@"topCmt":@"top_cmt[0]",  // 方式二
             @"hotTopCmtModels" : @"top_cmt",// 方式三
             
             // 对图片属性 进行更名
             @"smallImage" : @"image0",
             @"middleImage" : @"image2",
             @"largeImage" : @"image1"
             };
}

// 告诉框架 ， 数组中存放的是什么 模型
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"hotTopCmtModels" : @"MeeHotCmtModel"};
}


@end
