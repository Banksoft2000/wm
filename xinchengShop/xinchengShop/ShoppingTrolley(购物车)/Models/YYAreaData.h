//
//  YYAreaData.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/12.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYAreaData : NSObject<NSXMLParserDelegate>


- (void)startParser;

//省份
- (NSMutableArray *)province;
//城市
- (NSMutableArray *)city;
//地区
- (NSMutableArray *)county;


@end
