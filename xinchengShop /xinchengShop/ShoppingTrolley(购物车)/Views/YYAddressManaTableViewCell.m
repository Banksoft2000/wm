//
//  YYAddressManaTableViewCell.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/12.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYAddressManaTableViewCell.h"

@implementation YYAddressManaTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(YYAddressModel *)model {
    
    _model = model;
    
    _name.text = [NSString stringWithFormat:@"联系人:%@",_model.userName];
    _tel.text = [NSString stringWithFormat:@"联系电话:%@",_model.telephone];
    

    _address.text = [NSString stringWithFormat:@"收货地址:%@ %@ %@ %@",_model.province,_model.city,_model.county,_model.address];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
