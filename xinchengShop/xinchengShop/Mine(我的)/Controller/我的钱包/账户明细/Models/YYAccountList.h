//
//  YYAccountList.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/12.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "BaseModel.h"


@interface YYAccountList : BaseModel

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *siteId;

@property (nonatomic, assign) CGFloat changeBalance;

@property (nonatomic, assign) BOOL addStatus;

@property (nonatomic, assign) CGFloat balance;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *memberAccount;

@property (nonatomic, copy) NSString *adminAccount;

@property (nonatomic, copy) NSString *memberId;

@property (nonatomic, assign) long long createTime;

@property (nonatomic, copy) NSString *balanceType;

@property (nonatomic, copy) NSString *remark;

@end

