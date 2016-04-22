//
//  YYAccountViewCell.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/12.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYAccountViewCell.h"

@implementation YYAccountViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}


//把model的数值赋值给这个cell

-(void)setAccountList:(YYAccountList *)accountList{

    self.remark.text=accountList.remark;
    self.balance.text=[NSString stringWithFormat:@"%f",accountList.balance];
    self.changeBalance.text=[NSString stringWithFormat:@"%f",accountList.changeBalance];
    self.createTime.text=[NSString stringWithFormat:@"%lld",accountList.createTime];
//    NSString *addstatus=[NSString stringWithFormat:@"%@",accountList.addStatus];
    
    
    
//    if ( ]) {
//        
//        [self.addOrjian setImage:[UIImage imageNamed:@"pd_style_add"]];
//    }
//    else{
//    
//        [self.addOrjian setImage:[UIImage imageNamed:@"pd_style_release"]];
//    }
}

//把提现记录赋值给这个cell

-(void)setWithDrawList:(YYWithDrawList *)withDrawList{

    self.remark.text=withDrawList.remark;
    self.yuE.text=@"金额";
    self.balance.text=[NSString stringWithFormat:@"%ld",(long)withDrawList.withdrawMoney];
    
    self.createTime.text=[NSString stringWithFormat:@"%lld",withDrawList.createTime];
    self.addOrjian.hidden=YES;
    self.changeBalance.text=withDrawList.withdrawName;
    
}

@end
