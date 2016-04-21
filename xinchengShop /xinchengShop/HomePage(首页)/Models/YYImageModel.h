//
//  YYColorModel.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/3.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "BaseModel.h"

@interface YYImageModel : BaseModel

//------当规格的type == image的时候使用本model

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *value;

@property (nonatomic, copy) NSString *image;


@end
