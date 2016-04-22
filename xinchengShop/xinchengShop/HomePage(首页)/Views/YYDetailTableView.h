//
//  YYDetailTableView.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/1.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailTableDelegate <NSObject>

//传递需要保存的数据---shopid  shopimg  shopName  productID
- (void)productWithDic:(NSDictionary *)dictionary;

@end

@interface YYDetailTableView : YYBaseTableView<UIWebViewDelegate>

@property (weak, nonatomic) id<DetailTableDelegate> detailDelegate;

@property (copy, nonatomic) NSString *describe;

@property (strong, nonatomic) NSArray *dataArr;

@property (copy, nonatomic) NSString *url;

@end
