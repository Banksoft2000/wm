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


- (NSMutableArray *)province;
- (NSMutableArray *)city;
- (NSMutableArray *)county;


@end
