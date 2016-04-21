//
//  YYProductTypeNetTool.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/29.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYProductType.h"

@interface YYProductTypeNetTool : NSObject

+(void) saveProductType:(YYProductType *) productType;

+(YYProductType *) productType;

@end
