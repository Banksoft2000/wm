//
//  YYOrderTool.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/10.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYOrderTool.h"

#define orderListPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"orderList.archive"]
#define orderDetailPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"orderDetail.archive"]

@implementation YYOrderTool

//存储到沙盒订单数据
+(void)saveOrderList:(YYMyOrderlist *)orderList{

    [NSKeyedArchiver archiveRootObject:orderList toFile:orderListPath];
}


//从沙盒中取出数据订单数据
+(YYMyOrderlist *)orderList{

    YYMyOrderlist *orderList = [NSKeyedUnarchiver unarchiveObjectWithFile:orderListPath];
    return orderList;
}


//以下是订单详情的信息

+(void)saveOrderDetail:(YYMyOrderDetail *)myOrderDetail{

    [NSKeyedArchiver archiveRootObject:myOrderDetail toFile:orderDetailPath];
    
}

+(YYMyOrderDetail *)myOrderDetail{

    YYMyOrderDetail *ordeDetail=[NSKeyedUnarchiver unarchiveObjectWithFile:orderDetailPath];
    
    return ordeDetail;
}
@end
