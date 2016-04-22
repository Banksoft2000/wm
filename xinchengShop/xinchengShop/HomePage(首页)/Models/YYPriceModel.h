//
//  YYPriceModel.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/3.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "BaseModel.h"

@interface YYPriceModel : BaseModel


//库存
@property (nonatomic, assign) NSInteger stock;

@property (nonatomic, assign) BOOL success;

@property (nonatomic, assign) NSInteger price;

//颜色和规格的拼接
@property (nonatomic, copy) NSString *ids;

@end
