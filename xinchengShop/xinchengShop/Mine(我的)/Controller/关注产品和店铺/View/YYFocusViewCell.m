//
//  YYFocusViewCell.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/12.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYFocusViewCell.h"

@implementation YYFocusViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



//把Productmodel的值赋给 xib

-(void)setProduct:(YYProductList *)product{
    
    //把有|的字符串截取出来
    NSString *a=[NSString stringWithFormat:@"%@",product.productImage];
    NSArray *b=[a componentsSeparatedByString:@"|"];
    NSString *a1=[b objectAtIndex:0];


     [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,a1]] placeholderImage:[UIImage imageNamed:@"default_picture_icon"]];

    self.titleName.text=product.productName;
    self.price.text=product.productPrice;
    
    self.sales.text=[NSString stringWithFormat:@"%ld",(long)product.sales];
}

//把shopModel的值赋给xib

-(void)setShop:(YYShopList *)shop{

    //把有|的字符串截取出来
    NSString *a=[NSString stringWithFormat:@"%@",shop.shopLogo];
    NSArray *b=[a componentsSeparatedByString:@"|"];
    NSString *a1=[b objectAtIndex:0];
    
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,a1]] placeholderImage:[UIImage imageNamed:@"default_picture_icon"]];

    
}



@end
