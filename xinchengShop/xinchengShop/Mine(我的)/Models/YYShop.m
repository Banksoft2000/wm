//
//  YYShop.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/11.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYShop.h"

@interface YYShop ()



@end

@implementation YYShop


/**
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 */
- (void)encodeWithCoder:(NSCoder *)encoder


{
    
//    self.str=[[NSNumber numberWithInteger:self.status] stringValue];
    
    [encoder encodeObject:self.id forKey:@"ID"];
//    [encoder encodeInteger:self.status forKey:@"status"];
    [encoder encodeObject:self.status forKey:@"status"];
    
//    [encoder encodeObject:self.auditStatus forKey:@"auditStatus"];
    [encoder encodeObject:self.account forKey:@"account"];
    [encoder encodeObject:self.no forKey:@"no"];
    [encoder encodeObject:self.telephone forKey:@"telephone"];


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
        self.account = [decoder decodeObjectForKey:@"account"];
//        self.str = [decoder decodeObjectForKey:@"status"];
        self.status=[decoder decodeObjectForKey: @"status"];
        
        
        self.imageFile = [decoder decodeObjectForKey:@"imageFile"];
//        self.auditStatus=[decoder decodeObjectForKey:@"auditStatus"];
        self.telephone=[decoder decodeObjectForKey:@"telephone"];
        self.no=[decoder decodeObjectForKey:@"no"];

        
        
    }
    return self;
}


@end


