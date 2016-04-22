//
//  YYMember.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/30.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYMember.h"

@implementation YYMember

/**
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.id forKey:@"ID"];
    [encoder encodeObject:self.account forKey:@"UserName"];
    [encoder encodeObject:self.imageFile forKey:@"imageFile"];
    [encoder encodeObject:self.password forKey:@"password"];
    [encoder encodeObject:self.email forKey:@"email"];
    [encoder encodeObject:self.telephone forKey:@"telephone"];
    [encoder encodeDouble:self.balance forKey:@"balance"];
    [encoder encodeInteger:self.memberPoint forKey:@"memberPoint"];
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
        self.account = [decoder decodeObjectForKey:@"UserName"];
        self.password = [decoder decodeObjectForKey:@"PassWord"];
        self.imageFile = [decoder decodeObjectForKey:@"imageFile"];
        self.email=[decoder decodeObjectForKey:@"email"];
        self.telephone=[decoder decodeObjectForKey:@"telephone"];
        self.memberPoint=[decoder decodeIntegerForKey:@"memberPoint"];
        self.balance=[decoder decodeDoubleForKey:@"balance"];

       
    }
    return self;
}

@end






