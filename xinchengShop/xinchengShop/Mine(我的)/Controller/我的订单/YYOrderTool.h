//
//  YYOrderTool.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/10.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYMyOrderlist.h"
#import "YYMyOrderDetail.h"
@interface YYOrderTool : NSObject

//存储 订单信息
+(void) saveOrderList:(YYMyOrderlist *) orderList;

+(YYMyOrderlist *) orderList;


//存储订单详情的信息
+(void)saveOrderDetail:(YYMyOrderDetail *)myOrderDetail;
+(YYMyOrderDetail *)myOrderDetail;

@end
