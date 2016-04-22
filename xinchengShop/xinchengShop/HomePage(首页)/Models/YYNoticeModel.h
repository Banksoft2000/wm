//
//  YYNoticeModel.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/20.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "BaseModel.h"

@interface YYNoticeModel : BaseModel

@property (nonatomic, copy) NSString *typeNo;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) NSInteger sort;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *modifyTime;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL status;

@property (nonatomic, copy) NSString *typeName;

@property (nonatomic, assign) NSInteger createTime;

@property (nonatomic, copy) NSString *url;

@end
