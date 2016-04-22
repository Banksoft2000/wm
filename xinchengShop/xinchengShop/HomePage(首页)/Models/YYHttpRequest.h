//
//  YYHttpRequest.h
//  xinchengShop
//
//  Created by harry_robin on 16/3/29.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYAddressModel.h"

@interface YYHttpRequest : NSObject

/**
 *  首页轮播图
 *
 *  @param urlString    API接口的绝对路径
 *  @param params       接口需要的参数
 *  @param method       网络请求的方法
 *  @param succeedBlock <#succeedBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
+ (void)httpGetRequest:(NSString *)url success:(void(^)(id responseObjc))succeedBlock failBlock:(void(^)(NSHTTPURLResponse *responseObjc))failBlock;

/**
 *  post 请求数据
 *
 *  @param url    URL
 *  @param param  传递的字典
 *  @param header 参数的拼接头
 *  @param block  成功回调
 */
+ (void)httpPostRequest:(NSString *)url withParam:(NSDictionary *)param withHead:(NSString *)head success:(void(^)(id responseObjc))succeedBlock failBlock:(void(^)(NSHTTPURLResponse *responseObjc))failBlock;

@end
