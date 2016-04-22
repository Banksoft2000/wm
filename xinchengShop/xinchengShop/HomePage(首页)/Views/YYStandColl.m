//
//  YYStandColl.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/6.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYStandColl.h"
#import "YYImageModel.h"
#import "YYTextModel.h"

@implementation YYStandColl

{
    
    NSArray *_dataArr;
    NSString *_identity;
    UIImageView *_imageV;
    UILabel *_sizeLab;
    NSString  *_titleText;
    
    int _itemHeight;
}


/**
 *  返回一个collectionView
 *
 *  @param frame      frame
 *  @param array      展示的数据
 *  @param itemHeight item的高度
 *  @param identity   item的标志
 *
 *  @return <#return value description#>
 */

- (id)initWithFrame:(CGRect)frame withArray:(NSArray *)array withHeitht:(int)itemHeight withIndectity:(NSString *)identity withTitleText:(NSString *)text {
 
     UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
     
    if ([identity isEqualToString:@"image"]) {
        
        flow.itemSize = CGSizeMake(itemHeight, itemHeight);
 
    }else {
        
        flow.itemSize = CGSizeMake(itemHeight + 20, itemHeight);

    }
    
    
     flow.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 25);
     
     if (self = [super initWithFrame:frame collectionViewLayout:flow]) {
     
         //初始化数组和item标志
         _dataArr = [[NSArray alloc] init];
         _dataArr = array;
         _identity = identity;
         _titleText = text;
     
         //判断是否超出屏宽
         int count = (array.count*itemHeight)/SCREEN_WIDTH + 1;
         
         self.contentSize = CGSizeMake(SCREEN_WIDTH - 20, count *itemHeight + 10);
         
         [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identity];
         [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
         
         self.dataSource = self;
         self.delegate = self;

         self.backgroundColor = [UIColor whiteColor];
 
     }

    return self;
}
//- (void)collection:(UICollectionView *)collection withArray:(NSArray *)array withIdentity:(NSString *)identity {
//  
//    _dataArr = array;
//    _identity = identity;
//   
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if ([_identity isEqual:@"image"]) {
        
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"image" forIndexPath:indexPath];
        _imageV = [[UIImageView alloc] initWithFrame:cell.bounds];
        
        _imageV.layer.borderColor = [[UIColor grayColor] CGColor];
        _imageV.layer.borderWidth = 1;
        _imageV.layer.cornerRadius = 5;
        _imageV.clipsToBounds = YES;
        _imageV.tag = 1600 + indexPath.row;
        _imageV.userInteractionEnabled = YES;
        [cell.contentView addSubview:_imageV];
        
        YYImageModel *color = _dataArr[indexPath.row];
        NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,color.image];
        [_imageV sd_setImageWithURL:[NSURL URLWithString:url]];
        
        return cell;

    }else if ([_identity isEqualToString:@"text"]){
  
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"text" forIndexPath:indexPath];
        _sizeLab = [[UILabel alloc] initWithFrame:cell.bounds];
        
        _sizeLab.textAlignment = NSTextAlignmentCenter;
        _sizeLab.font = [UIFont systemFontOfSize:11];
        _sizeLab.layer.borderColor = [[UIColor grayColor] CGColor];
        _sizeLab.layer.borderWidth = 1;
        _sizeLab.layer.cornerRadius = 5;
        _sizeLab.clipsToBounds = YES;
        
        YYTextModel *sizeModle = _dataArr[indexPath.row];
        _sizeLab.text = sizeModle.value;
        _sizeLab.tag = 1700 + indexPath.row;
        [cell.contentView addSubview:_sizeLab];
        
        return cell;
   
    }
    
    return nil;
    
    
}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    
//    return CGSizeMake(<#CGFloat width#>, <#CGFloat height#>)
//}

#pragma mark - UICollectionViewDataSource

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    //更改选中状态----边框颜色的改变
    if ([_identity isEqualToString:@"image"]) {
        
        for (int i = 0; i < collectionView.subviews.count; i ++) {
            
            UIImageView *imageView = [collectionView viewWithTag:i + 1600];
            imageView.layer.borderColor = [[UIColor grayColor] CGColor];
            
        }
        UIImageView *imageView = [collectionView viewWithTag:indexPath.row +1600];
        
        imageView.layer.borderColor = [[UIColor orangeColor] CGColor];
        
    }else {
        
        for (int i = 0; i < collectionView.subviews.count; i ++) {
            
            UILabel *label = [collectionView viewWithTag:i + 1700];
            label.layer.borderColor = [[UIColor grayColor] CGColor];
            
        }
        UILabel *label = [collectionView viewWithTag:indexPath.row +1700];
        
        label.layer.borderColor = [[UIColor orangeColor] CGColor];
        
    }
    
    //获取到传输的数值
    NSString *text = nil;
    NSString *ids = nil;
    NSString *imageStr = nil;
    if ([_identity isEqualToString:@"image"]) {
        
        YYImageModel *model = _dataArr[indexPath.row];
        
        text = model.value;
        ids = model.id;
        imageStr = model.image;
        
    }else {
        
        YYTextModel *model = _dataArr[indexPath.row];
        
        text = model.value;
        ids = model.id;
    }
  
    //代理的实现
    [self.standDelegate getCollectionView:self withSelectText:text withTitleText:_titleText withIndex:indexPath.row withId:ids withIcon:imageStr];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 25)];
        
        label.text = _titleText;
        [view addSubview:label];
        
        return view;
  
        
    }else
        return nil;
}

@end
