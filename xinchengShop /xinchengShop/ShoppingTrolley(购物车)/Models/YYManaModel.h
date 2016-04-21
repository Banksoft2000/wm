//
//  YYManaModel.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/12.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "BaseModel.h"

@interface YYManaModel : BaseModel

/*
 private String id;
 private String memberId;
 private String no;
 private String address;
 private String telephone;
 private String mobile;
 private String postcode;
 private String userName;
 private boolean status;
 private long createTime; //创建时间

 
 */

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *adress;

@property (nonatomic, copy) NSString *tel;

@property (nonatomic, copy) NSString *postcode;

@property (nonatomic, copy) NSString *defa;

@property (nonatomic, copy) NSString *detail;

@end
