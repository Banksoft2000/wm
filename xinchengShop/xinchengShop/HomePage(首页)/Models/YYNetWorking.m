//
//  YYNetWorking.m
//  xinchengShop
//
//  Created by harry_robin on 16/3/29.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYNetWorking.h"
#import "YYHttpRequest.h"

@implementation YYNetWorking


+ (void)homeHeaderWithURL:(NSString *)url :(void (^)(id))block {

    
    
    
    [YYHttpRequest httpGetRequest:url success:^(id responseObjc) {
        
        block(responseObjc);
    } failBlock:^(NSHTTPURLResponse *responseObjc) {
        
        NSLog(@"YYNetworking");

        
    }];

}

+ (void)getWithURL:(NSString *)url withParam:(NSDictionary *)dic :(void (^)(id responsObjc))block {

    [YYHttpRequest getRequest:url withParam:dic success:^(id responseObjc) {
        
        block(responseObjc);
    } failBlock:^(NSHTTPURLResponse *responseObjc) {
        
        
    }];
    
}

/**
 *  post 请求数据
 *
 *  @param url    URL
 *  @param param  传递的字典
 *  @param header 参数的拼接头
 *  @param block  成功回调
 */
+ (void)postwithURL:(NSString *)url withParam:(NSDictionary *)param withHeader:(NSString *)header success:(void(^)(id responsObjc))block{
    
    [YYHttpRequest httpPostRequest:url withParam:param withHead:header success:^(id responseObjc) {
        
        block(responseObjc);
       
    } failBlock:^(NSHTTPURLResponse *responseObjc) {}];
    

}


@end
