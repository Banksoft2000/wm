//
//  YYProductManagerCell.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/20.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYOnSell.h"

@interface YYProductManagerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *count;


//给cell设置model的数据

@property (nonatomic, strong) YYOnSell *shopProduct;
@end
