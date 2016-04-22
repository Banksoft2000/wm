//
//  YYAccountViewCell.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/12.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYAccountList.h"
#import "YYWithDrawList.h"

@interface YYAccountViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *remark;

@property (weak, nonatomic) IBOutlet UILabel *balance;
@property (weak, nonatomic) IBOutlet UILabel *changeBalance;

@property (weak, nonatomic) IBOutlet UIImageView *addOrjian;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UILabel *yuE;

//设置账户信息
@property (nonatomic, strong) YYAccountList *accountList;
//设置提现记录

@property (nonatomic, strong) YYWithDrawList *withDrawList;

@end
