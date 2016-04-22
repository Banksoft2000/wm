//
//  YYLoginNetTool.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/31.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYLoginNetTool.h"
#import "YYHttpRequest.h"

@implementation YYLoginNetTool

+(void)logInWithURL:(NSString *)url :(void (^)(id))block{

    [YYHttpRequest httpGetRequest:url success:^(id responseObjc) {
        
        block(responseObjc);
    } failBlock:^(NSHTTPURLResponse *responseObjc) {
        
        NSLog(@"数据请求出错");
        
        
    }];

    
}

@end
