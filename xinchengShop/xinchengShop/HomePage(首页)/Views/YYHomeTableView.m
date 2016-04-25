//
//  YYHomeTableView.m
//  xinchengShop
//
//  Created by harry_robin on 16/3/28.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYHomeTableView.h"
#import "YYHeaderView.h"
#import "YYDetailViewController.h"
#import "YYCarouseViewController.h"     //轮播图
#import "YYCollectionViewCell.h"        //甩卖
#import "YYXCViewController.h"          //主题街

#import "YYCarouselModel.h"             //轮播数据
#import "YYCXHomeModel.h"               //主题数据


#define THEMECELL       @"themeCell"
#define TWOCELL         @"twoCell"
//section0cell的高度
#define CELLZEROHEIGHT  505
#define ITEMHEIGHT      SCREEN_WIDTH/2*6/5-1
//section1cell的高度
#define CELLONEHEIGHT   (SCREEN_WIDTH/2*6/5-1)*5+5

@implementation YYHomeTableView
{
    YYHeaderView *_headerV;
    
    //详情
    NSMutableArray *_dataList;
}

- (void)initDetails {
    
    self.backgroundColor = [UIColor whiteColor];
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
    //头视图
    _headerV = [[YYHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_WIDTH*8/10+110)];
    self.tableHeaderView = _headerV;
    
}
#pragma mark - 获取数据
//获取数据
- (void)setHeaderArr:(NSArray *)headerArr {
 
    _headerArr = headerArr;
    
    _headerV.headerArr = (NSMutableArray *)_headerArr;

}

- (void)setThemeArr:(NSArray *)themeArr {
    
    
    _themeArr = themeArr;
    
}

- (void)setDetailArr:(NSArray *)detailArr {
    
    _detailArr = detailArr;
    
    _dataList = [[NSMutableArray alloc] initWithArray:_detailArr];

    [self reloadData];

}

#pragma mark - 第一组里边cell的布局
- (UICollectionView *)cellZero {
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];


    flow.minimumLineSpacing = 1;
    flow.minimumInteritemSpacing = 1;
    UICollectionView *themeColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CELLZEROHEIGHT) collectionViewLayout:flow];
    themeColl.contentSize = CGSizeMake(SCREEN_WIDTH, CELLZEROHEIGHT);
    themeColl.directionalLockEnabled = YES;
    themeColl.backgroundColor = MYGRAYCOLOR;
    themeColl.tag = 1200;
    themeColl.dataSource = self;
    themeColl.delegate = self;
    
    [themeColl registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:THEMECELL];
    
    return themeColl;
}

#pragma mark --第二组cell的布局
- (UICollectionView *)cellOne {
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    
    flow.minimumLineSpacing = 1;
    flow.minimumInteritemSpacing = 1;
    UICollectionView *themeColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CELLONEHEIGHT) collectionViewLayout:flow];
    themeColl.contentSize = CGSizeMake(SCREEN_WIDTH, CELLONEHEIGHT);
    themeColl.directionalLockEnabled = YES;
    themeColl.backgroundColor = MYGRAYCOLOR;
    themeColl.tag = 1300;
    themeColl.dataSource = self;
    themeColl.delegate = self;

    [themeColl registerClass:[YYCollectionViewCell class] forCellWithReuseIdentifier:TWOCELL];
    
    return themeColl;
    
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (collectionView.tag) {
        case 1200:
            return 13;
            break;
        case 1300:
            return 10;
            break;
            
        default:
            break;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //主题
    if (collectionView.tag == 1200) {
        
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:THEMECELL forIndexPath:indexPath];
        //添加imageview
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:cell.bounds];
        [cell.contentView addSubview:imageV];
        imageV.userInteractionEnabled = YES;
        imageV.image = DEFA_IMAGE;
        if (_themeArr.count != 0) {
  
            YYCXHomeModel *model = _themeArr[indexPath.row];
            NSString *url = [NSString stringWithFormat:@"http://xinchengguangchang.com%@",model.icon];
            [imageV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default_picture_icon"]];
        }
        
        return cell;
        
    }else if (collectionView.tag == 1300) {
        
        UINib *nib = [UINib nibWithNibName:@"YYCollectionViewCell" bundle:[NSBundle mainBundle]];
        [collectionView registerNib:nib forCellWithReuseIdentifier:TWOCELL];
        YYCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:TWOCELL forIndexPath:indexPath];
        
        if (_detailArr.count != 0) {
            
            YYClearanceModel *model = _detailArr[indexPath.row];

            cell.model = model;
        }
        
        return cell;
    }

    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView.tag == 1200) {
        
        if (indexPath.row == 0 || indexPath.row == 8) {
            
            return CGSizeMake(SCREEN_WIDTH/3*2-0.5, 100);
            
        }else {
            
            return CGSizeMake(SCREEN_WIDTH/3 - 1, 100);
        }
        
    }else if (collectionView.tag == 1300) {
        
        return CGSizeMake(SCREEN_WIDTH/2-0.5, ITEMHEIGHT);
    }
  
    return CGSizeZero;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 1200) {
        
        YYCXHomeModel *model = _themeArr[indexPath.row];
        NSString *url = [NSString stringWithFormat:@"no=%@",model.no];
        
        //主题街页面
        YYXCViewController *vc = [[YYXCViewController alloc] init];
        
        vc.title = model.name;
        vc.url = url;
        
        [self.viewController.navigationController pushViewController:vc animated:YES];
        
    }else {
        
        YYDetailViewController *vc = [[YYDetailViewController alloc] init];
        
        YYClearanceModel *model = _detailArr[indexPath.row];
        
        vc.url = model.id;
        
        [self.viewController.navigationController pushViewController:vc animated:YES];
        
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
            
        default:
            break;
    }
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    if (indexPath.section == 0) {

        [cell.contentView addSubview:[self cellZero]];
        
    }else if (indexPath.section == 1) {
        
        [cell.contentView addSubview:[self cellOne]];
    }
    
    cell.backgroundColor = ARCOLOR;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return CELLZEROHEIGHT;
        
    }else if (indexPath.section == 1) {
        
        return CELLONEHEIGHT;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    title.font = [UIFont systemFontOfSize:11];
    title.backgroundColor = [UIColor whiteColor];
    title.textColor = PRICE_TEXT_RED;

    if (section == 0) {
        
        title.text = @"   主题街";
        
    }else {
        
        title.text = @"   清仓甩卖";
        
    }
    return title;
}


@end
