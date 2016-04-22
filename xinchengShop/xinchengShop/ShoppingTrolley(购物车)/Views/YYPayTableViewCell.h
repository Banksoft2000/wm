//
//  YYPayTableViewCell.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/11.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YYShoppingModel.h"

@interface YYPayTableViewCell : UITableViewCell

@property (strong, nonatomic) YYShoppingModel *model;

@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UILabel *name;


@property (strong, nonatomic) IBOutlet UILabel *staic;
@property (strong, nonatomic) IBOutlet UILabel *price;

@property (strong, nonatomic) IBOutlet UILabel *number;

@end
