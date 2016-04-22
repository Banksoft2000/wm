//
//  YYrightCollectionViewCell.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/25.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "YYProduct.h"
#import <Masonry.h>

@interface YYrightCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) YYProduct *curNoHeadRightModel;

+(CGSize)ccellSize;
@end
