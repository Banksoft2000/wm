//
//  YYMyScoreViewCell.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/13.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYMyScoreList.h"
@interface YYMyScoreViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *category;

@property (weak, nonatomic) IBOutlet UILabel *addOrjian;

@property (weak, nonatomic) IBOutlet UILabel *creatTime;

@property (weak, nonatomic) IBOutlet UILabel *score;


//包含的积分订单

@property (nonatomic, strong) YYMyScoreList *scoreList;

@end
