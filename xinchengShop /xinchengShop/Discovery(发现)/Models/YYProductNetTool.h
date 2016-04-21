//
//  YYProductNetTool.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/29.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYProduct.h"
@interface YYProductNetTool : NSObject
+(void) saveProduct:(YYProduct *) product;

+(YYProduct *) product;

@end
