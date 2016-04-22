//
//  YYqq.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/6.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYsanfangModel.h"

@implementation YYsanfangModel

/**
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{

    [encoder encodeObject:self.userName forKey:@"UserName"];
    [encoder encodeObject:self.icon forKey:@"imageFile"];
    
    [encoder encodeObject:self.type forKey:@"type"];
    [encoder encodeObject:self.openId forKey:@"openId"];

}

/**
 *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
 *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {

        self.userName = [decoder decodeObjectForKey:@"UserName"];
        self.icon = [decoder decodeObjectForKey:@"imageFile"];
        self.type = [decoder decodeObjectForKey:@"type"];

        self.openId=[decoder decodeObjectForKey:@"openId"];
    }
    return self;
}


@end
