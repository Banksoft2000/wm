//
//  YYAddressData.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/11.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYManaModel.h"
@interface YYAddressData : NSObject

//插入
- (BOOL)insertDataWithDic:(NSDictionary *)dic;

//获取到数据
- (NSArray *)getData;

//修改
- (void)changeData:(YYManaModel *)model oldModel:(YYManaModel *)oldModel;
@end
