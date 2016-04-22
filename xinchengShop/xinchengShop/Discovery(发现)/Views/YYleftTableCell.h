//
//  YYleftTableCell.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/25.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYProductType.h"
#import <Masonry.h>

@interface YYleftTableCell : UITableViewCell



@property (nonatomic, strong) YYProductType *curLeftTagModel;
//是否被选中
@property (nonatomic, assign) BOOL hasBeenSelected;


@end
