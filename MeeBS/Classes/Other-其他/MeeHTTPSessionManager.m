//
//  MeeHTTPSessionManager.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/11/14.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeHTTPSessionManager.h"

// 对AFN的使用最好是用子类继承使用
// 1.这样可以对一些属性统一设置
// 2.如果AFN框架中代码改变，以后用到AFN网络请求的地方只需要修改这个子类的

@implementation MeeHTTPSessionManager

// 创建单例使用
+ (instancetype)shareManger
{
    static id instance_;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 可以再这个位置传入一个公共url ，以后使用这个当时，直接拼接其他连接部分
        instance_ = [[self alloc]initWithBaseURL:nil];
        // 官方：推荐使用AFN 通过继承
        // 通过继承，好处，可以退网络访问进行统一属性设置
        // 以XML形式解析服务器返回的数据
        // manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
        // 设置请求超时的时间
        // manager.requestSerializer setTimeoutInterval:(NSTimeInterval)
    });
    
    return instance_;
}

// 创建单例
//+ (instancetype)manager
//{
//    MeeHTTPSessionManager *manager = [super manager];
//    return manager;
//}

@end
