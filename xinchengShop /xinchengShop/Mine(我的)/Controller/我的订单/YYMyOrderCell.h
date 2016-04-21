//
//  YYMyOrderCell.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/8.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYMyOrderlist.h"
#import "YYMyOrderDetail.h"

@interface YYMyOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UIImageView *imageFile;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UILabel *totalNum;
@property (weak, nonatomic) IBOutlet UILabel *totalMoney;
@property (weak, nonatomic) IBOutlet UIButton *confiBtn;
@property (weak, nonatomic) IBOutlet UIButton *checkAdd;
@property (weak, nonatomic) IBOutlet UIButton *prolong;
//订单标题的view
@property (weak, nonatomic) IBOutlet UIView *titleView;

//点击cell中的跳转到详情的View
@property (weak, nonatomic) IBOutlet UIView *clickView;


//订单
@property (nonatomic, strong) YYMyOrderlist *orderModel;
//订单详情
@property (nonatomic, strong) YYMyOrderDetail *orderDetail;
@end
