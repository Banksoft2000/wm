//
//  YYProductType.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/25.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYProductType.h"


@implementation YYProductType


/**
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.name forKey:@"name"];
//    [encoder encodeObject:self.icon forKey:@"icon"];
    
}

/**
 *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
 *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.name = [decoder decodeObjectForKey:@"name"];
//        self.icon = [decoder decodeObjectForKey:@"icon"];
    }
    return self;
}

@end


