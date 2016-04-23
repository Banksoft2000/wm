//
//  YYClearanceModel.h
//  xinchengShop
//
//  Created by harry_robin on 16/3/31.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "BaseModel.h"

@interface YYClearanceModel : BaseModel



//---------------甩卖---精品热卖-------

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *shopNO;

@property (nonatomic, copy) NSString *freight;

@property (nonatomic, assign) NSInteger hasStandard;

@property (nonatomic, copy) NSString *salePrice;

@property (nonatomic, assign) NSInteger shopMatchScore;

@property (nonatomic, assign) NSInteger goodCount;

@property (nonatomic, assign) BOOL hot;

@property (nonatomic, copy) NSString *description;

@property (nonatomic, assign) NSInteger virtualClear;

@property (nonatomic, assign) BOOL fashion;

@property (nonatomic, assign) NSInteger virtualGroup;

@property (nonatomic, assign) int sales;

@property (nonatomic, assign) NSInteger collections;

@property (nonatomic, copy) NSString *no;

@property (nonatomic, assign) NSInteger virtualSale;

@property (nonatomic, copy) NSString *signProductId;

@property (nonatomic, copy) NSString *brand;

@property (nonatomic, copy) NSString *areaNo;

@property (nonatomic, copy) NSString *typeNo;

@property (nonatomic, assign) NSInteger views;

@property (nonatomic, assign) NSInteger assesses;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *typeName;

@property (nonatomic, assign) NSInteger shopScore;

@property (nonatomic, copy) NSString *shopProTypeId;

@property (nonatomic, copy) NSString *auditStatus;

@property (nonatomic, assign) BOOL status;

@property (nonatomic, copy) NSString *active;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *shopName;

@property (nonatomic, assign) BOOL recommend;

@property (nonatomic, copy) NSString *seoKeyword;

@property (nonatomic, assign) BOOL special;

@property (nonatomic, copy) NSString *stockNum;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *qq;

@property (nonatomic, copy) NSString *siteId;

@property (nonatomic, copy) NSString *modifyTime;

@property (nonatomic, copy) NSString *shopId;

@property (nonatomic, assign) NSInteger groupSale;

@property (nonatomic, copy) NSString *expressModelId;

@property (nonatomic, assign) NSInteger clearSale;

@property (nonatomic, copy) NSString *typeId;


@end
