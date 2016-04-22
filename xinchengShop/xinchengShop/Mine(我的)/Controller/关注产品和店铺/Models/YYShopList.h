//
//  YYShopList.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/12.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "BaseModel.h"


@interface YYShopList : BaseModel

@property (nonatomic, copy) NSString *id;

@property (nonatomic, assign) NSInteger serverGoodsNum;

@property (nonatomic, copy) NSString *shopLogo;

@property (nonatomic, copy) NSString *shopServerType;

@property (nonatomic, assign) NSInteger collections;

@property (nonatomic, copy) NSString *shopNo;

@property (nonatomic, assign) NSInteger goodsNum;

@property (nonatomic, copy) NSString *area;

@property (nonatomic, assign) long long createTime;

@property (nonatomic, copy) NSString *shopId;

@property (nonatomic, copy) NSString *areaNo;

@property (nonatomic, copy) NSString *shopName;

@end

