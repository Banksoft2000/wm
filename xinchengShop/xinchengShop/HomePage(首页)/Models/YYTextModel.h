//
//  YYSizeModel.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/3.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "BaseModel.h"

@interface YYTextModel : BaseModel

//当规格中的type == text的时候使用本model

@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *value;


@end
