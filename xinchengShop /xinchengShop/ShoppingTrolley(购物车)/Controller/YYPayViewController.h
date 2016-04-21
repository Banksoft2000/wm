//
//  YYPayViewController.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/11.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYAddressModel.h"
@interface YYPayViewController : UIViewController

@property (nonatomic, strong) YYAddressModel *model;

//购买的产品的店铺集合
@property (nonatomic, strong) NSMutableArray *shopArr;

@property (nonatomic, assign) NSInteger money;

+ (YYPayViewController *)payViewController;
@end
