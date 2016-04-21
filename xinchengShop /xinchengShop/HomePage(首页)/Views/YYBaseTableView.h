//
//  YYBaseTableView.h
//  xinchengShop
//
//  Created by harry_robin on 16/3/28.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYBaseTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

- (id)initWithFrame:(CGRect)frame;
- (void)initDetails;
@end
