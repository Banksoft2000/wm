//
//  YYHeadView.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/11.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYHeadView.h"
//#import "YYAddressData.h"

#import "YYAdressViewController.h"
#import "YYSelectAddViewController.h"

@implementation YYHeadView
{
    
    UIButton *add;
}

-(void)awakeFromNib {
    
    [super awakeFromNib];
    
   
}

- (void)setModel:(YYAddressModel *)model {
    
    _model = model;
    
    
    if ([_model.userName isEqual:nil]) {
        
        add = [UIButton buttonWithType:UIButtonTypeCustom];
        add.frame = self.bounds;
        [self addSubview:add];
        
        add.backgroundColor = [UIColor whiteColor];
        [add setImage:[UIImage imageNamed:@"round_plus_press"] forState:UIControlStateNormal];
        [add setTitle:@"请添加地址" forState:UIControlStateNormal];
        [add setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [add addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    }else {
        
        if (add) {
            
            [add removeFromSuperview];
        }
        _name.text = [NSString stringWithFormat:@"联系人:%@",_model.userName];
        _tel.text = [NSString stringWithFormat:@"联系方式:%@",_model.telephone];
        _adress.text = [NSString stringWithFormat:@"收货地址:%@ %@ %@ %@",_model.province,_model.city,_model.county,_model.address];
    }
    
}


- (void)addAction:(UIButton *)sender {
 
    YYAdressViewController *vc = [YYAdressViewController aderssViewController];
    vc.isAdd = YES;
    [self.viewController.navigationController pushViewController:vc animated:YES];

}


- (IBAction)changeAdress:(UIButton *)sender {
    
    YYSelectAddViewController *vc = [[YYSelectAddViewController alloc] init];
   
    [self.viewController.navigationController pushViewController:vc animated:YES];
    
}
@end
