//
//  YYShoppingDownView.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/7.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYShoppingDownView.h"

@implementation YYShoppingDownView

- (void)awakeFromNib {

    _select.userInteractionEnabled = YES;
    _payBtn.layer.cornerRadius = 8;
    _payBtn.clipsToBounds = YES;
    _payBtn.backgroundColor = UIBUTTON_ORANGE;
    
    _price.font = [UIFont boldSystemFontOfSize:15];
    _price.textColor = UIBUTTON_ORANGE;
    
}

@end
