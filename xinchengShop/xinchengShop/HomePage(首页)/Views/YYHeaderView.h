//
//  YYHeaderView.h
//  xinchengShop
//
//  Created by harry_robin on 16/3/29.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYHeaderView : UIView<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *headerArr;

@property (nonatomic,strong) NSArray *detailHeadArr;

//轮播视图
@property (strong, nonatomic) UIScrollView *scrollView;

//page视图
@property (strong, nonatomic) UIPageControl *pageControl;


@property (strong, nonatomic) UICollectionView *selectColl;


@end
