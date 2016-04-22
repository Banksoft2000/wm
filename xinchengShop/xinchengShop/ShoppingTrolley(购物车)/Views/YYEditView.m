//
//  YYEditView.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/9.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYEditView.h"
#import "YYMyData.h"
#import "YYShoppingController.h"

@implementation YYEditView
{
    
    UILabel *_numLab;                       //购买数量Label
//    UIButton *_addBtn;
//    UIButton *_subtract;

}

#pragma mark - 购买数量
//购买数量
- (IBAction)deleteData:(UIButton *)sender {
    

    //手动设置number== 0
    _model.number = @"0";

    [self.editDelegate productModel:_model withSection:_section withRow:_row];
  

}
- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    _delegate.backgroundColor = SHOPPING_DELETE_BG;
}

- (void)initNumberView {
   
    
    UIButton *subtract = [UIButton buttonWithType:UIButtonTypeCustom];
    subtract.frame = CGRectMake(0, 0, 27, 27);
    [subtract addTarget:self action:@selector(subtractAction:) forControlEvents:UIControlEventTouchUpInside];
    [subtract setImage:[UIImage imageNamed:@"pd_style_release"] forState:UIControlStateNormal];
    [_numberView addSubview:subtract];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:[UIImage imageNamed:@"pd_style_add"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [_numberView addSubview:addBtn];
    
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_numberView.mas_right);
        make.width.equalTo(@27);
        make.height.equalTo(@27);
        make.centerY.equalTo(_numberView.mas_centerY);
    }];
    
    _numLab = [[UILabel alloc] init];
    [_numberView addSubview:_numLab];
    
    _numLab.textAlignment = NSTextAlignmentCenter;
    _numLab.layer.borderColor = [MYGRAYCOLOR CGColor];
    _numLab.layer.borderWidth = 1;
    
    _numLab.font = [UIFont systemFontOfSize:13];
    _numLab.clipsToBounds = YES;
    
    [_numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(addBtn.mas_left);
        make.left.equalTo(subtract.mas_right);
        make.height.equalTo(@30);
        make.centerY.equalTo(_numberView.mas_centerY);
        
    }];
    
    _numberView.clipsToBounds = YES;
    _numberView.layer.borderColor = [MYGRAYCOLOR CGColor];
    _numberView.layer.borderWidth = 1;
    _numberView.layer.cornerRadius = 3;
    
}

- (void)setBuyNum:(int)buyNum {
    
    _buyNum = buyNum;
    _numLab.text = [NSString stringWithFormat:@"%d",_buyNum];
}

- (void)subtractAction:(UIButton *)sender {
    
    if (_buyNum > 1) {
        
        _buyNum --;
        
    }else {
        
        _buyNum = 1;
    }
    
    [self changeModelValue];
}

- (void)addAction:(UIButton *)sender {
    
    //对i 进行判断
    _buyNum ++;
    
    [self changeModelValue];
}

- (void)changeModelValue {
    
    _numLab.text = [NSString stringWithFormat:@"%d",_buyNum];
    _model.number = [NSString stringWithFormat:@"%d",_buyNum];
    
    YYMyData *data = [[YYMyData alloc] init];
    [data changeData:_model];
}

@end
