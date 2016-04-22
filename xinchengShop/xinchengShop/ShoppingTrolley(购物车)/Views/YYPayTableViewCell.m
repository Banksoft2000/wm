//
//  YYPayTableViewCell.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/11.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYPayTableViewCell.h"

@implementation YYPayTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(YYShoppingModel *)model {
    
    _model = model;
    
    _name.text =  _model.name;
    _staic.text = _model.staic;
    _number.text = [NSString stringWithFormat:@"x %@",_model.number];

    NSString *oldPrice = [NSString stringWithFormat:@"￥%@",_model.price];

    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice attributes:@{NSForegroundColorAttributeName:PRICE_TEXT_RED}];
    
    [_price setAttributedText:attri];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,_model.icon];
    [_icon sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:DEFA_IMAGE];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
