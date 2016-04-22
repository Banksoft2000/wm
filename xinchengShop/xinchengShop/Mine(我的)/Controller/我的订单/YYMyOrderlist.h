//
//  YYMyOrderlist.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/8.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "BaseModel.h"


@interface YYMyOrderlist : BaseModel<NSCoding>

@property (nonatomic, assign) NSInteger cashCouponMoney;

@property (nonatomic, copy) NSString *orderType;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, assign) NSInteger changePrice;

@property (nonatomic, assign) NSInteger memberScore;

@property (nonatomic, assign) long long payTime;

@property (nonatomic, assign) long long dispatchTime;

@property (nonatomic, assign) NSInteger overTime;

@property (nonatomic, copy) NSString *memberName;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *telephone;

@property (nonatomic, assign) NSInteger productCount;

@property (nonatomic, copy) NSString *dispatchStatus;

@property (nonatomic, copy) NSString *dispatchId;

@property (nonatomic, assign) NSInteger successTime;

@property (nonatomic, copy) NSString *payType;

@property (nonatomic, copy) NSString *no;

@property (nonatomic, copy) NSString *shopAccount;

@property (nonatomic, copy) NSString *shopNo;

@property (nonatomic, copy) NSString *areaNo;

@property (nonatomic, assign) long long timeLimit;

@property (nonatomic, assign) BOOL memberAssess;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *memberId;

@property (nonatomic, copy) NSString *shopName;

@property (nonatomic, assign) NSInteger totalMoney;

@property (nonatomic, copy) NSString *postcode;

@property (nonatomic, assign) BOOL express;

@property (nonatomic, assign) long long createTime;

@property (nonatomic, copy) NSString *expressType;

@property (nonatomic, assign) NSInteger expressMoney;

@property (nonatomic, copy) NSString *siteId;

@property (nonatomic, assign) BOOL shopAssess;

@property (nonatomic, assign) NSInteger orderTime;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *shopId;

@end


