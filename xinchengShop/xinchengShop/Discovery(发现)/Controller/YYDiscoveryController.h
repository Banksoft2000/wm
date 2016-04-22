//
//  YYDiscoveryController.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/22.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYProductType.h"
#import "YYProduct.h"

@interface YYDiscoveryController : UIViewController

//分类数据
@property(nonatomic,strong) NSMutableArray *disCoverDatas;

@property (strong, nonatomic) UITableView *myTableView;

//右边列表的过滤数据源
@property (nonatomic, strong) NSMutableArray *rightdataList;
//右边列表
@property (nonatomic, strong) UICollectionView *myCollectionView;

//当前被选中的ID值
@property(strong,nonatomic)YYProductType *curSelectModel;

//是否保持右边滚动时位置
@property(assign,nonatomic) BOOL isKeepScrollState;
@property(assign,nonatomic) BOOL isReturnLastOffset;
@property (nonatomic, assign) NSInteger selectIndex;


-(void)loadData:(NSMutableArray *) datas;
@end
