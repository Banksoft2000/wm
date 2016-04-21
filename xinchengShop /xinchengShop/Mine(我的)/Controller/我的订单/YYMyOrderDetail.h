//
//  YYMyOrderDetail.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/8.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "BaseModel.h"

@interface YYMyOrderDetail : BaseModel



@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *productId;

@property (nonatomic, copy) NSString *active;

@property (nonatomic, assign) NSInteger totalMoney;

@property (nonatomic, copy) NSString *productName;

@property (nonatomic, copy) NSString *standardNames;

@property (nonatomic, copy) NSString *imageFile;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, copy) NSString *standardKeys;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, copy) NSString *orderId;

@property (nonatomic, copy) NSString *standardValues;

@property (nonatomic, copy) NSString *no;

@property (nonatomic, copy) NSString *standardIds;



@end
