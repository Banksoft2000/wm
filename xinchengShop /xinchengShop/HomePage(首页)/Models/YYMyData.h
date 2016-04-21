//
//  YYMyData.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/8.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYShoppingModel.h"
@interface YYMyData : NSObject

//插入数据
- (void)insertDataWithDic:(NSDictionary *)dic;

//获取数据
- (NSArray *)getData;

//修改或者删除
- (void)changeData:(YYShoppingModel *)model;
@end
