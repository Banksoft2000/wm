//
//  YYStandColl.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/6.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StandDelegate <NSObject>

/**
 *  <#Description#>
 *
 *  @param collectionView self
 *  @param text           传输的数据--value
 *  @param titleText      titleText
 *  @param index          点击的位置
 *  @param ids            传输的数据--id
 */
- (void)getCollectionView:(UICollectionView *)collectionView withSelectText:(NSString *)text withTitleText:(NSString *)titleText withIndex:(NSInteger)index withId:(NSString *)ids withIcon:(NSString *)icon;

@end

@interface YYStandColl : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@property (nonatomic, weak) id<StandDelegate> standDelegate;

- (id)initWithFrame:(CGRect)frame withArray:(NSArray *)array withHeitht:(int)itemHeight withIndectity:(NSString *)identity withTitleText:(NSString *)text;



@end
