//
//  YYThemeTableViewCell.h
//  xinchengShop
//
//  Created by harry_robin on 16/3/31.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYClearanceModel.h"

@interface YYThemeTableViewCell : UITableViewCell

@property (strong, nonatomic) YYClearanceModel *model;
@property (strong, nonatomic) IBOutlet UIImageView *icon;


@property (strong, nonatomic) IBOutlet UILabel *name;


@property (strong, nonatomic) IBOutlet UILabel *salePrice;

@property (strong, nonatomic) IBOutlet UILabel *sales;





@end
