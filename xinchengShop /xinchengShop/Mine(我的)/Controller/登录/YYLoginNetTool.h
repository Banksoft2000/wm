//
//  YYLoginNetTool.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/31.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYLoginNetTool : NSObject

+ (void)logInWithURL:(NSString *)url :(void(^)(id responsObjc))block;


@end
