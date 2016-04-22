//
//  YYBaseModel.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/28.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YYBaseModel : NSObject

//json转换成对象
+(instancetype) jsonObject:(NSString *) json;
//json转换成字典
+(NSDictionary *) dictionaryWithJsonString:(NSString *) jsonString;

@end
