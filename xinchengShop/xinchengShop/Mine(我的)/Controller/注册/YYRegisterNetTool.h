//
//  YYRegisterNetTool.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/1.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYRegisterNetTool : NSObject

+ (void)registerWithURL:(NSString *)url :(void(^)(id responsObjc))block;


@end
