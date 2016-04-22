//
//  YYMyOrderDetail.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/8.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYMyOrderDetail.h"

@implementation YYMyOrderDetail

/**
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.id forKey:@"ID"];
    [encoder encodeObject:self.productName forKey:@"productName"];
    [encoder encodeInteger:self.price forKey:@"price"];
    [encoder encodeInteger:self.num forKey:@"num"];
    [encoder encodeInteger:self.totalMoney forKey:@"totalMoney"];
    
    //    [encoder ];
}

/**
 *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
 *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.id = [decoder decodeObjectForKey:@"ID"];
        self.productName = [decoder decodeObjectForKey:@"productName"];
        self.price = [decoder decodeIntegerForKey:@"price"];
        self.num = [decoder decodeIntegerForKey:@"num"];
        self.totalMoney=[decoder decodeIntegerForKey:@"totalMoney"];
        
    }
    return self;
}


@end
