//
//  YYPayTabView.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/11.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYBaseTableView.h"
#import "YYAddressModel.h"

@interface YYPayTabView : YYBaseTableView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) YYAddressModel *model;

@property (strong, nonatomic) NSArray *dataArr;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;
@end
