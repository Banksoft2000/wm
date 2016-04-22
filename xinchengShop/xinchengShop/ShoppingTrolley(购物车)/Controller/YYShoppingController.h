//
//  YYShoppingController.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/22.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYEditView.h"
#import "YYShoppingTableViewCell.h"
@interface YYShoppingController : UIViewController<UITableViewDataSource,UITableViewDelegate,EditDelegate,CellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@end
