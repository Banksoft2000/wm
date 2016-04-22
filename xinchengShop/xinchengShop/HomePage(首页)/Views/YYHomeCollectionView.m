//
//  YYHomeCollectionView.m
//  xinchengShop
//
//  Created by harry_robin on 16/3/30.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYHomeCollectionView.h"
#import "YYHeaderView.h"

#define CELLZEROHEIGHT  300
#define THEMECELL       @"themeCell"
#define SECTIONTITLE    @"sectionTitle"
@implementation YYHomeCollectionView

{
    YYHeaderView *_headerV;
}

- (id)initWithFrame:(CGRect)frame {
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.minimumInteritemSpacing = 10;
    flow.minimumLineSpacing = 10;
    
    if (self = [super initWithFrame:frame collectionViewLayout:flow]) {
        
        
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:THEMECELL];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SECTIONTITLE];
        
    }
    
    return self;
}

//获取数据
- (void)setHeaderArr:(NSArray *)headerArr {
    
    
    _headerArr = headerArr;
    _headerV.headerArr = (NSMutableArray *)_headerArr;
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    switch (section) {
        case 0:
            
            return 1;
            break;
        case 1:
            
            return 13;
            break;
        case 2:
            
            return 10;
            break;
            
        default:
            break;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = cell = [collectionView dequeueReusableCellWithReuseIdentifier:SECTIONTITLE forIndexPath:indexPath];
    

    

    if (indexPath.section == 0) {
        
        cell = [[UICollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, 400)];
        //头视图
        _headerV = [[YYHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 400)];
        [cell.contentView addSubview:_headerV];
        
    }else {
        
        
        cell.backgroundColor = ARCOLOR;
    }
    
    return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return CGSizeMake(SCREEN_HEIGHT, 400);
    }else if (indexPath.section == 1) {
        
        
        return CGSizeMake(100, 100);
    }else if (indexPath.section == 2) {
        
        
        return CGSizeMake(100, 100);
    }
    
    
    return CGSizeZero;
    
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        UICollectionReusableView *reusable = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SECTIONTITLE forIndexPath:indexPath];
        
        UILabel *label = [UILabel new];

        if (indexPath.section == 0) {
            
            label.text = @"主题街";
        }else {
            
            label.text = @"第二分组";
        }
        [reusable addSubview:label];

        
        return reusable;
    }
    
    
    
    return nil;
}



@end
