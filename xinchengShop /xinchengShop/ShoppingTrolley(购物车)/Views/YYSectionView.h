//
//  YYSectionView.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/7.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYShoppingModel.h"

@interface YYSectionView : UIView

@property (strong, nonatomic) YYShoppingModel *model;

//选择按钮
@property (strong, nonatomic) IBOutlet UIButton *select;

@property (strong, nonatomic) IBOutlet UIImageView *icon;

@property (strong, nonatomic) IBOutlet UILabel *name;

@property (strong, nonatomic) IBOutlet UIImageView *leftImg;


@property (strong, nonatomic) IBOutlet UIButton *sectionBgButton;

@property (strong, nonatomic) IBOutlet UIButton *editBtn;

- (IBAction)editBtn:(UIButton *)sender;



@end
