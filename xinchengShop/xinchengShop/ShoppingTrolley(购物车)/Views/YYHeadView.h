//
//  YYHeadView.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/11.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYAddressModel.h"
@interface YYHeadView : UIView

@property (strong, nonatomic) YYAddressModel *model;
@property (strong, nonatomic) IBOutlet UILabel *name;

@property (strong, nonatomic) IBOutlet UILabel *tel;
@property (strong, nonatomic) IBOutlet UILabel *adress;
@property (strong, nonatomic) IBOutlet UIButton *changeAdress;
- (IBAction)changeAdress:(UIButton *)sender;

@end
