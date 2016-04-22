//
//  YYWithDrawList.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/13.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "BaseModel.h"


@interface YYWithDrawList : BaseModel


@property (nonatomic, copy) NSString *id;

@property (nonatomic, assign) NSInteger money;

@property (nonatomic, copy) NSString *siteId;

@property (nonatomic, copy) NSString *withdrawRateName;

@property (nonatomic, copy) NSString *withdrawSubBank;

@property (nonatomic, copy) NSString *withdrawName;

@property (nonatomic, assign) NSInteger withdrawRate;

@property (nonatomic, assign) NSInteger withdrawMoney;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *payType;

@property (nonatomic, copy) NSString *memberId;

@property (nonatomic, assign) long long createTime;

@property (nonatomic, copy) NSString *agreeStatus;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *no;

@property (nonatomic, assign) BOOL status;

@end

