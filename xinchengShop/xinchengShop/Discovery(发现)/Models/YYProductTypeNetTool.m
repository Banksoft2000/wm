//
//  YYProductTypeNetTool.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/29.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYProductTypeNetTool.h"

#define MemberDataPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"productType.plist"]

@implementation YYProductTypeNetTool

//把分类的数据存储到本地

+(void)saveProductType:(YYProductType *)productType{

    [NSKeyedArchiver archiveRootObject:productType toFile:MemberDataPath];
}


+(YYProductType *)productType{

    // 加载模型
    YYProductType *model = [NSKeyedUnarchiver unarchiveObjectWithFile:MemberDataPath];
    return model;

}

@end
