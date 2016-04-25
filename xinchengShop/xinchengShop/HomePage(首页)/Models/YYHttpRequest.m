//
//  YYHttpRequest.m
//  xinchengShop
//
//  Created by harry_robin on 16/3/29.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYHttpRequest.h"
#import <AFNetworking.h>
#import "AFNetworking.h"


@implementation YYHttpRequest

//返回key1=value1&key2=value2 格式的字符串
+ (NSString *)paramsStringWithParams:(NSDictionary *)params withHead:(NSString *)head {
    
    NSMutableString *paramsString = [[NSMutableString alloc] init];
    
    //key1=value1&key2=value2
    
    for (NSString *key in params) {
        
        if (head != nil) {
            
            [paramsString appendFormat:@"%@.%@=%@",head,key,[params objectForKey:key]];
        }else {
            
            [paramsString appendFormat:@"%@=%@",key,[params objectForKey:key]];
        }
        
        
        
        if (key != [[params allKeys] lastObject]) {
            
            [paramsString appendString:@"&"];
        }
    }
    
    return paramsString;
}

+ (NSDictionary *)changeParame:(NSDictionary *)dic withHead:(NSString *)head {
    
    NSMutableDictionary *parame= [[NSMutableDictionary alloc] init];
    for (NSString *key in dic) {
        
        if (head != nil) {
            
            NSString *newKey = [NSString stringWithFormat:@"%@.%@",head,key];
            
            [parame setObject:dic[key] forKey:newKey];
        }else {
            
            return dic;
        }
        
    }
    
    return parame;
}

#pragma GET
+ (void)httpGetRequest:(NSString *)url success:(void(^)(id responseObjc))succeedBlock failBlock:(void(^)(NSHTTPURLResponse *responseObjc))failBlock {

    //1.
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    //2.
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    //3.
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
//        NSLog(@"---%@",downloadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //解析接送数据
        id responsObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//
        succeedBlock(responsObj);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"HTTP出现错误");
        
    }];
}


+ (void)getRequest:(NSString *)url withParam:(NSDictionary *)param success:(void(^)(id responseObjc))succeedBlock failBlock:(void(^)(NSHTTPURLResponse *responseObjc))failBlock {
    
    //1.
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //2.
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    //3.
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //解析接送数据
        id responsObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        //
        succeedBlock(responsObj);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"HTTP出现错误");
        
    }];
    
}


#pragma POST---json
+ (void)httpPostRequest:(NSString *)url withParam:(NSDictionary *)param withHead:(NSString *)head success:(void(^)(id responseObjc))succeedBlock failBlock:(void(^)(NSHTTPURLResponse *responseObjc))failBlock {
    
    
    //1.
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //2.
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    //3.
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary *dic = [self changeParame:param withHead:head];
  
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        succeedBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
  
        NSLog(@"URL:%@ 出错了---%@",url,error);
    }];
  
}




@end
