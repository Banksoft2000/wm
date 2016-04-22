//
//  YYCollectionViewCell.m
//  xinchengShop
//
//  Created by harry_robin on 16/3/30.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYCollectionViewCell.h"

@implementation YYCollectionViewCell

- (void)awakeFromNib {

    self.backgroundColor = MYGRAYCOLOR;
}

- (void)setModel:(YYClearanceModel *)model {
    
    
    _model = model;
    
    NSString *imageStr = model.icon;
    NSArray *images = [imageStr componentsSeparatedByString:@"|"];

    NSString *url = [NSString stringWithFormat:@"http://xinchengguangchang.com%@",[images firstObject]];
    [_imageV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default_picture_icon"]];    
    _name.text = [NSString stringWithFormat:@"  %@",model.name];
    
    _price.text = [NSString stringWithFormat:@"￥%@",_model.price];
    _price.textColor = PRICE_TEXT_RED;
    
    //以前的价格
    NSString *oldPrice = [NSString stringWithFormat:@"￥%@",_model.salePrice];
    NSUInteger length = [oldPrice length];

    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice attributes:@{NSForegroundColorAttributeName:MYGRAYCOLOR}];
    
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(1, length-1)];

    [attri addAttribute:NSStrikethroughColorAttributeName value:MYGRAYCOLOR range:NSMakeRange(1, length-1)];
    
    [_salePrice setAttributedText:attri];
}

@end
