//
//  YYAdressViewController.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/11.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "YYCountyViewController.h"
#import "YYAddressModel.h"

//新增/修改收获地址
@interface YYAdressViewController : UIViewController

//点击changeAddressViewcontroller的新增的时候传递的参数
@property (nonatomic, assign) BOOL isAdd;

//点击changeAddressViewcontroller的cell时传递的参数
@property (nonatomic, strong) YYAddressModel *model;

//地址的拼接字符串
@property (nonatomic, copy) NSString *adressStr;

//从countyVC中pop回来 和 payVc中push过来  调用的一个VC
+ (YYAdressViewController *)aderssViewController;


@end
