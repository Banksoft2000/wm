//
//  YYMemberTool.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/31.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYMemberTool.h"

@implementation YYMemberTool
#define MemberDataPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]


#define shopPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"shop.archive"]


+(void) saveMember:(YYMember *)member
{
    
    
    
    [NSKeyedArchiver archiveRootObject:member toFile:MemberDataPath];

    
}

+(YYMember *) member
{
    // 加载模型
    YYMember *member = [NSKeyedUnarchiver unarchiveObjectWithFile:MemberDataPath];
    return member;
}



//把shop从沙盒存进沙盒 从沙盒中取出


+(void)saveShop:(YYShop *)shop{

    [NSKeyedArchiver archiveRootObject:shop toFile:shopPath];
}


+(YYShop *)shop{

    //加载模型
    YYShop *shop=[NSKeyedUnarchiver unarchiveObjectWithFile:shopPath];
    
    return shop;
}

@end
