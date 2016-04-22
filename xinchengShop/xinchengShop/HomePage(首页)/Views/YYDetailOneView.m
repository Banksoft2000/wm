//
//  YYDetailOneView.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/1.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYDetailOneView.h"

@implementation YYDetailOneView

- (void)setModel:(YYDetailModel *)model {
    
    _model = model;
    
    _commodity.layer.borderWidth = 1;
    _commodity.layer.borderColor = [MYGRAYCOLOR CGColor];
    _commodity.layer.cornerRadius = 2;
    _commodity.clipsToBounds = YES;

    _store.layer.borderWidth = 1;
    _store.layer.borderColor = [MYGRAYCOLOR CGColor];
    _store.layer.cornerRadius = 2;
    _store.clipsToBounds = YES;
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,_model.shopImg];
    [_shopImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:DEFA_IMAGE];
    
    _shopName.text = _model.shopName;
    
    _matchScore.text = [NSString stringWithFormat:@"描述相符:%.1f",_model.matchScore];
    _serviceScore.text = [NSString stringWithFormat:@"服务态度:%.1f",_model.serviceScore];
    _dispatchScore.text = [NSString stringWithFormat:@"发货速度:%.1f",_model.dispatchScore];
    
    
}

- (IBAction)commodity:(UIButton *)sender {
    
    
}

- (IBAction)store:(UIButton *)sender {
    
    
    
}
@end
