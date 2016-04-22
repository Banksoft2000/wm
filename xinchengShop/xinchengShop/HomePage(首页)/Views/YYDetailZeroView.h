//
//  YYDetailZeroView.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/1.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYDetailModel.h"

@interface YYDetailZeroView : UITableViewCell

@property (strong, nonatomic) YYDetailModel *model;
//产品名称
@property (strong, nonatomic) IBOutlet UILabel *name;
//价格
@property (strong, nonatomic) IBOutlet UILabel *price;
//以前的价格
@property (strong, nonatomic) IBOutlet UILabel *salePrice;
//所在地
@property (strong, nonatomic) IBOutlet UILabel *address;


@end
