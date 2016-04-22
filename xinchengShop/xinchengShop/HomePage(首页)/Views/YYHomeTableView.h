//
//  YYHomeTableView.h
//  xinchengShop
//
//  Created by harry_robin on 16/3/28.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface YYHomeTableView : YYBaseTableView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *headerArr;

@property (nonatomic, strong) NSArray *themeArr;

@property (nonatomic, strong) NSArray *detailArr;
@end
