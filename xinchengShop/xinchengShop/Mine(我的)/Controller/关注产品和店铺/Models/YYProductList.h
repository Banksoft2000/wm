//
//  YYProductList.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/12.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "BaseModel.h"


@interface YYProductList : BaseModel

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *productId;

@property (nonatomic, copy) NSString *shopAccount;

@property (nonatomic, copy) NSString *shopAli;

@property (nonatomic, assign) NSInteger collections;

@property (nonatomic, copy) NSString *productName;

@property (nonatomic, copy) NSString *shopNo;

@property (nonatomic, copy) NSString *productImage;

@property (nonatomic, copy) NSString *shopQQ;

@property (nonatomic, assign) NSInteger assesses;

@property (nonatomic, copy) NSString *productPrice;

@property (nonatomic, assign) long long createTime;

@property (nonatomic, copy) NSString *shopId;

@property (nonatomic, assign) NSInteger sales;

@property (nonatomic, copy) NSString *shopName;

@end

