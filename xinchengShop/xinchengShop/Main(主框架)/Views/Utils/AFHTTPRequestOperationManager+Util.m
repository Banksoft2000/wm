//
//  AFHTTPRequestOperationManager+Util.m
//  iosapp
//
//  Created by AeternChan on 6/18/15.
//  Copyright (c) 2015 oschina. All rights reserved.
//

#import "AFHTTPRequestOperationManager+Util.h"

#import <UIKit/UIKit.h>

@implementation AFHTTPRequestOperationManager (Util)

+ (instancetype)OSCManager
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
   manager.responseSerializer = [AFCompoundResponseSerializer serializer];//使用这个得到的是json数据
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"text/html", nil];
    
    // 设置请求格式
    //manager.requestSerializer = [AFHTTPRequestSerializer serializer];//二进制请求格式

//    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    //[manager.requestSerializer setValue:[self generateUserAgent] forHTTPHeaderField:@"User-Agent"];
    
    return manager;
}

+(instancetype) OSCJasonManager
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//使用这个得到的是json数据
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"text/html", nil];
    
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//json制请求格式
    return manager;
}


@end
