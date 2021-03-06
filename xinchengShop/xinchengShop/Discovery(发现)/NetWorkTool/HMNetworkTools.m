//
//  HMNetworkTools.m
//  01-网易新闻
//
//  Created by Apple on 15/10/28.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMNetworkTools.h"

@implementation HMNetworkTools
+ (instancetype)sharedManager {
    static HMNetworkTools *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //http://c.m.163.com/nc/ad/headline/0-4.html
        NSURL *baseURL = [NSURL URLWithString:@"http://www.xinchengguangchang.com"];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        //配置超时时长
        config.timeoutIntervalForRequest = 30;
        
        instance = [[self alloc] initWithBaseURL:baseURL sessionConfiguration:config];
        
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json", @"text/javascript", nil];
    });
    
    return instance;
}
@end
