//
//  YYAddressManaTableViewCell.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/12.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYAddressModel.h"
@interface YYAddressManaTableViewCell : UITableViewCell

@property (strong, nonatomic) YYAddressModel *model;

@property (strong, nonatomic) IBOutlet UILabel *tel;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *name;

@end
