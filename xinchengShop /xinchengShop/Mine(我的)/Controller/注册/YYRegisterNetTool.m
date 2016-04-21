//
//  YYRegisterNetTool.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/1.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYRegisterNetTool.h"
#import "YYHttpRequest.h"

@implementation YYRegisterNetTool

+(void)registerWithURL:(NSString *)url :(void (^)(id))block{

    
    [YYHttpRequest httpGetRequest:url success:^(id responseObjc) {
        
        block(responseObjc);
    } failBlock:^(NSHTTPURLResponse *responseObjc) {
        
        NSLog(@"数据请求出错");
        
        
    }];
}

@end
