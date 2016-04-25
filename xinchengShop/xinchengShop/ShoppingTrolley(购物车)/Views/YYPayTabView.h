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

//产品的商店集合
@property (strong, nonatomic) NSArray *dataArr;

 //向后台传递的 配送方式 的数据
@property (strong, nonatomic) NSMutableArray *distriArr;

//向后台传递的   留言    的数据
@property (strong, nonatomic) NSMutableArray *messageArr;

@property (copy, nonatomic) NSString *addressId;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;

@end
