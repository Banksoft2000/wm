//
//  YYDetailZeroView.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/1.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYDetailZeroView.h"

@implementation YYDetailZeroView


- (void)setModel:(YYDetailModel *)model {
    
    _model = model;
    
    _name.text = _model.name;
    _price.text = [NSString stringWithFormat:@"￥%@",_model.price];

    _price.textColor = PRICE_TEXT_RED;
    

    
    //以前的价格
    NSString *oldPrice = [NSString stringWithFormat:@"原价：￥%@",_model.salePrice];
    NSUInteger length = [oldPrice length];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice attributes:@{NSForegroundColorAttributeName:MYGRAYCOLOR}];
    
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(4, length-4)];
    
    [attri addAttribute:NSStrikethroughColorAttributeName value:MYGRAYCOLOR range:NSMakeRange(4, length-4)];
    
    [_salePrice setAttributedText:attri];
}

@end
