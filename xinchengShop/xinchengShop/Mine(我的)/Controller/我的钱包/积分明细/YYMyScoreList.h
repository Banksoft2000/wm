//
//  YYMyScoreList.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/13.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "BaseModel.h"


@interface YYMyScoreList : BaseModel


@property (nonatomic, copy) NSString *siteId;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *memberId;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, assign) long long createTime;

@property (nonatomic, copy) NSString *changeType;

@end

