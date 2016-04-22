//
//  YYShoppingTableViewCell.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/7.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYShoppingTableViewCell.h"

@implementation YYShoppingTableViewCell

- (void)awakeFromNib {

    _select.width =_select.height;
//    _select.layer.borderColor = [[UIColor grayColor] CGColor];
//    _select.layer.borderWidth = 1;
    _select.layer.cornerRadius = _select.width/2;
    _select.clipsToBounds = YES;
 
}

- (void)setModel:(YYShoppingModel *)model {
    
    _model = model;
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,model.icon];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default_picture_icon"]];
    
    _name.text = model.name;
    _staic.text = model.staic;
    _number.text = [NSString stringWithFormat:@"x%@",model.number];
    _price.text = model.price;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (IBAction)select:(UIButton *)sender {
    
    [self.cellDelegate cellWithSection:_section withRow:_row];
    
    
}
@end
