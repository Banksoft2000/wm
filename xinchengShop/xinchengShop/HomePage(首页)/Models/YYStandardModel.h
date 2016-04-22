//
//  YYStandardModel.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/3.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "BaseModel.h"

@interface YYStandardModel : BaseModel

/**
 *  list里面的格式为
 {
 name: 颜色
 id: 526684857afe47e7997a078cc219184c
 type: image
 },
 
 没有使用单独的model
 */

@property (strong, nonatomic) NSArray *list;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *type;

@end
