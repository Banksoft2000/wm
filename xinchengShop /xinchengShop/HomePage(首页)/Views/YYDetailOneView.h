//
//  YYDetailOneView.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/1.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYDetailModel.h"

@interface YYDetailOneView : UITableViewCell

@property (strong, nonatomic) YYDetailModel *model;

@property (strong, nonatomic) IBOutlet UIImageView *shopImg;

@property (strong, nonatomic) IBOutlet UILabel *shopName;

//发货速度
@property (strong, nonatomic) IBOutlet UILabel *dispatchScore;

//服务态度
@property (strong, nonatomic) IBOutlet UILabel *serviceScore;

//描述相符
@property (strong, nonatomic) IBOutlet UILabel *matchScore;

//全部商品
@property (strong, nonatomic) IBOutlet UIButton *commodity;

//进入店铺
@property (strong, nonatomic) IBOutlet UIButton *store;



//全部商品
- (IBAction)commodity:(UIButton *)sender;

//进入店铺
- (IBAction)store:(UIButton *)sender;



@end
