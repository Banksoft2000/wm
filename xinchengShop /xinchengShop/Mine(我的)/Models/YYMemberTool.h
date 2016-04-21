//
//  YYMemberTool.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/31.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYMember.h"
#import "YYShop.h"

@interface  YYMemberTool : NSObject

+(void) saveMember:(YYMember *) member;

+(YYMember *) member;


//保存店铺信息

+(void)saveShop:(YYShop *)shop;
+(YYShop *)shop;

@end
