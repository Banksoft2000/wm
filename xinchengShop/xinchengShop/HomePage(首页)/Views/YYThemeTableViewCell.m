//
//  YYThemeTableViewCell.m
//  xinchengShop
//
//  Created by harry_robin on 16/3/31.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYThemeTableViewCell.h"

@implementation YYThemeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(YYClearanceModel *)model {
    
    _model = model;
    
    NSArray *images = [_model.icon componentsSeparatedByString:@"|"];
    
     NSString *url =[NSString stringWithFormat:@"http://xinchengguangchang.com%@",[images firstObject]];
 
    [_icon sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default_picture_icon"]];
    
    _name.text = _model.name;
   
    _salePrice.textColor = PRICE_TEXT_RED;
    _salePrice.text = [NSString stringWithFormat:@"%@元",_model.salePrice];
    _sales.text = [NSString stringWithFormat:@"已销售:%d",_model.sales];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
