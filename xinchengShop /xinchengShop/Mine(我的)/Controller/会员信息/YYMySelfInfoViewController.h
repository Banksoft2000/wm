//
//  YYMySelfInfoViewController.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/30.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYMember.h"

@interface YYMySelfInfoViewController : UIViewController


@property (nonatomic, strong) YYMember *member;

-(void)setMyInfoView;
@end
