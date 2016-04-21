//
//  YYAddressModel.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/15.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "BaseModel.h"

@interface YYAddressModel : BaseModel


@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *postcode;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *memberId;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *county;

@property (nonatomic, copy) NSString *no;

@property (nonatomic, assign) long long createTime;

@property (nonatomic, copy) NSString *telephone;

@property (nonatomic, assign) BOOL status;


@end
