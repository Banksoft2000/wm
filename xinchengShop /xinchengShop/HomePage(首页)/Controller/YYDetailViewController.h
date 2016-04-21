//
//  YYDetailViewController.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/1.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYDetailTableView.h"
#import "YYBuyView.h"
@interface YYDetailViewController : UIViewController<BuyDelegate,DetailTableDelegate>


@property (strong, nonatomic) YYDetailTableView *detailTableView;

@property (copy, nonatomic) NSString *url;
@end
