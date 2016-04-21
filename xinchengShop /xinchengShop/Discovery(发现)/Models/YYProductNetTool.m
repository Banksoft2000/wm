//
//  YYProductNetTool.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/29.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYProductNetTool.h"

#define MemberDataPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"product.plist"]

@implementation YYProductNetTool

//把数据保存起来
+(void)saveProduct:(YYProduct *)product{

    [NSKeyedArchiver archiveRootObject:product toFile:MemberDataPath];

    
}
//把数据取出来
+(YYProduct *)product{
    
    // 加载模型
    YYProduct *model = [NSKeyedUnarchiver unarchiveObjectWithFile:MemberDataPath];
    return model;


}

@end
