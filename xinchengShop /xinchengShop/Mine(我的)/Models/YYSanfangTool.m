//
//  YYQQTool.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/6.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYSanfangTool.h"

@implementation YYsanfangTool

#define MemberDataPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"sanfang.plist"]

+(void)saveModel:(YYsanfangModel *)sanfang
{
    
    
    
    [NSKeyedArchiver archiveRootObject:sanfang toFile:MemberDataPath];
    
    
}

+(id)sanfang
{
    // 加载模型
     YYsanfangModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:MemberDataPath];
    return model;
}


@end
