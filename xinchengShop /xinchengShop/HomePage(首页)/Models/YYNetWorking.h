//
//  YYNetWorking.h
//  xinchengShop
//
//  Created by harry_robin on 16/3/29.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYNetWorking : NSObject


+ (void)homeHeaderWithURL:(NSString *)url :(void(^)(id responsObjc))block;

/**
 *  post 请求数据
 *
 *  @param url    URL
 *  @param param  传递的字典
 *  @param header 参数的拼接头
 *  @param block  成功回调
 */
+ (void)postwithURL:(NSString *)url withParam:(NSDictionary *)param withHeader:(NSString *)header success:(void(^)(id responsObjc))block;



@end
