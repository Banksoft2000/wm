//
//  YYGuideCell.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/22.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYGuideCell : UICollectionViewCell
@property (nonatomic, strong) UIImage *image;

- (void)setCellCount:(int)count currentCellIndex:(int)idx;

@end
