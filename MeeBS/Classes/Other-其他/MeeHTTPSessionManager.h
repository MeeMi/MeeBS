//
//  MeeHTTPSessionManager.h
//  MeeBS
//
//  Created by 扬帆起航 on 15/11/14.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface MeeHTTPSessionManager : AFHTTPSessionManager

+ (instancetype)shareManger;

@end
