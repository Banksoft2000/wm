//
//  YYMyScoreViewCell.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/13.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYMyScoreViewCell.h"

@implementation YYMyScoreViewCell

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

//把model的数据赋值给cell

-(void)setScoreList:(YYMyScoreList *)scoreList{

    if ([scoreList.type isEqualToString:@"LOGIN"]) {
        
        self.category.text=@"系统";
    }else if ([scoreList.type isEqualToString:@"BUY"]){
    
        self.category.text=@"买入";
    }
    
    if ([scoreList.changeType isEqualToString:@"ADD"]) {
        self.addOrjian.text=@"增加";
    }
    
    self.creatTime.text=[NSString stringWithFormat:@"%lld",scoreList.createTime];
    
    self.score.text=[NSString stringWithFormat:@"%ld",(long)scoreList.score];
}



@end
