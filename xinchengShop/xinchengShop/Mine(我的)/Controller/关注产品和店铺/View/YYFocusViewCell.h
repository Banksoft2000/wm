//
//  YYFocusViewCell.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/12.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYShopList.h"
#import "YYProductList.h"

@interface YYFocusViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *sales;

@property (weak, nonatomic) IBOutlet UILabel *yuan;
@property (weak, nonatomic) IBOutlet UILabel *saled;

//店铺
@property (nonatomic, strong) YYShopList *shop;

//商品

@property (nonatomic, strong) YYProductList *product;

@end
