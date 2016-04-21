//
//  YYDetailModel.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/2.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "BaseModel.h"

@interface YYDetailModel : BaseModel

//--------------产品详情-------------

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, assign) BOOL violation;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, assign) BOOL freight;

@property (nonatomic, copy) NSString *shopImg;

@property (nonatomic, copy) NSString *salePrice;

@property (nonatomic, assign) BOOL hot;

@property (nonatomic, copy) NSString *descrip;

@property (nonatomic, assign) NSInteger virtualClear;

@property (nonatomic, assign) BOOL fashion;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, assign) NSInteger sales;

@property (nonatomic, assign) NSInteger virtualGroup;

@property (nonatomic, copy) NSString *no;

@property (nonatomic, assign) NSInteger collections;

@property (nonatomic, copy) NSString *shopNo;

@property (nonatomic, assign) NSInteger virtualSale;

@property (nonatomic, assign) CGFloat serviceScore;

@property (nonatomic, copy) NSString *areaNo;

@property (nonatomic, copy) NSString *typeNo;

@property (nonatomic, assign) NSInteger views;

//商品评价次数
@property (nonatomic, assign) NSInteger assesses;

@property (nonatomic, copy) NSString *shopServerType;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *typeName;

@property (nonatomic, copy) NSString *inventoryChange;

@property (nonatomic, assign) BOOL auditStatus;

@property (nonatomic, assign) BOOL status;

@property (nonatomic, copy) NSString *active;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *shopName;

@property (nonatomic, assign) BOOL recommend;

@property (nonatomic, assign) CGFloat matchScore;

@property (nonatomic, assign) BOOL special;

@property (nonatomic, assign) NSInteger stockNum;

@property (nonatomic, copy) NSString *siteId;

@property (nonatomic, assign) CGFloat dispatchScore;

@property (nonatomic, copy) NSString *shopId;

@property (nonatomic, assign) NSInteger groupSale;

@property (nonatomic, copy) NSString *expressModelId;

@property (nonatomic, assign) NSInteger clearSale;

@property (nonatomic, copy) NSString *typeId;

@end
