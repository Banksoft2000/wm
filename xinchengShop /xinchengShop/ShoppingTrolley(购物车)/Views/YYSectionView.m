//
//  YYSectionView.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/7.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYSectionView.h"

@implementation YYSectionView

- (void)awakeFromNib {
    
    _select.width =_select.height;
//    _select.layer.borderColor = [[UIColor grayColor] CGColor];
//    _select.layer.borderWidth = 1;
    _select.layer.cornerRadius = _select.width/2;
    _select.clipsToBounds = YES;
//
    
}

- (void)setModel:(YYShoppingModel *)model {
    
    _model = model;
    
    _name.text = _model.shopName;

    _name.text = @"你是我的小伙伴";

    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,model.shopImg ];
    
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default_picture_icon"]];

    [self setNeedsLayout];
}

//更改——leftImg 的位置
- (void)layoutSubviews {
    
    [super layoutSubviews];
    CGSize size = [_name.text sizeWithAttributes:@{NSFontAttributeName:_name.font}];
    _name.width = size.width;
    
    _leftImg.center = CGPointMake(_name.centerX+ _name.width/2+8, _name.centerY);
  
}



- (IBAction)editBtn:(UIButton *)sender {
    
    
}
@end
