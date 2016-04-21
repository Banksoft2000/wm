//
//  YYCollectionViewCell.h
//  xinchengShop
//
//  Created by harry_robin on 16/3/30.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYClearanceModel.h"

@interface YYCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) YYClearanceModel *model;
@property (strong, nonatomic) IBOutlet UIImageView *imageV;

@property (strong, nonatomic) IBOutlet UILabel *name;

@property (strong, nonatomic) IBOutlet UILabel *salePrice;

@property (strong, nonatomic) IBOutlet UILabel *price;


@end
