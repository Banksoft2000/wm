//
//  YYProductManagerCell.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/20.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYProductManagerCell.h"

@implementation YYProductManagerCell

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setShopProduct:(YYOnSell *)shopProduct{

    //把有|的字符串截取出来
    NSString *a=[NSString stringWithFormat:@"%@",shopProduct.icon];
    NSArray *b=[a componentsSeparatedByString:@"|"];
    NSString *a1=[b objectAtIndex:0];
    
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,a1]] placeholderImage:[UIImage imageNamed:@"default_picture_icon"]];
    
    //店铺名称
    self.name.text=[NSString stringWithFormat:@"%@",shopProduct.name];
    
    self.price.text=[NSString stringWithFormat:@"%@",shopProduct.price];
    
    self.count.text=[NSString stringWithFormat:@"%ld",(long)shopProduct.sales];

    
}

@end
