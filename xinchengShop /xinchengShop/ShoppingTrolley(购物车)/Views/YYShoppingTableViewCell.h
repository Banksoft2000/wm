//
//  YYShoppingTableViewCell.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/7.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYShoppingModel.h"

@protocol CellDelegate <NSObject>


- (void)cellWithSection:(NSInteger)section withRow:(NSInteger)row;

@end

@interface YYShoppingTableViewCell : UITableViewCell


@property (weak, nonatomic) id<CellDelegate> cellDelegate;
@property (strong, nonatomic) YYShoppingModel *model;

@property (assign, nonatomic) NSInteger section;
@property (assign, nonatomic) NSInteger row;

@property (strong, nonatomic) IBOutlet UIButton *select;

@property (strong, nonatomic) IBOutlet UIImageView *icon;

@property (strong, nonatomic) IBOutlet UILabel *staic;

@property (strong, nonatomic) IBOutlet UILabel *price;

@property (strong, nonatomic) IBOutlet UILabel *number;

@property (strong, nonatomic) IBOutlet UILabel *name;


- (IBAction)select:(UIButton *)sender;


@end
