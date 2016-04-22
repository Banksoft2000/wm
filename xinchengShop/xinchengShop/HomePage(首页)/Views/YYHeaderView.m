//
//  YYHeaderView.m
//  xinchengShop
//
//  Created by harry_robin on 16/3/29.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYHeaderView.h"
#import "YYCarouselModel.h"
#import "YYCarouseViewController.h"
#import "YYXCViewController.h"

#define SELECTCELL @"selectCell"
#define ITEMIMGWIDTH cell.width*5/10




@implementation YYHeaderView
{

    //轮播图
//    UIScrollView *_scrollView;
//    UIPageControl *_pageControl;
    int _page;
    
    //collectionView数据
    NSArray *_selectImgArr;
    NSArray *_selectNameArr;
    
    NSString *_downImgStr;
    UIImageView *_downImg;
    
    NSTimer *_timer;
    
    //遮盖视图
    UIImageView *_imageV;
    
}


- (id)initWithFrame:(CGRect)frame {
    
    
    if (self = [super initWithFrame:frame]) {
        
        [self initDetail];
        
    }
    return self;
}

- (void)initDetail {
    
    _selectImgArr = @[@"xc_w_m",
                      @"xc_t_g",
                      @"xc_qing_cang",
                      @"xc_local_service",
                      @"xc_wei_fang_t_c",
                      @"xc_ji_feng",
                      @"xc_shop",
                      @"xc_my"];
    
    _selectNameArr = @[@"美食外卖",
                       @"精品热卖",
                       @"清仓甩卖",
                       @"本地服务",
                       @"潍坊特产",
                       @"积分商城",
                       @"鑫城超市",
                       @"我的"];
    
    
    [self addScrollView];
    [self addTimer];
    
    [self selectCollection];
    [self downView];
}

#pragma mark - downView
- (void)downView {
    
    _downImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, _selectColl.height + _scrollView.height + 10, SCREEN_WIDTH, _scrollView.height- 15)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _downImg.image = DEFA_IMAGE;
    
    btn.frame = _downImg.bounds;

    [self addSubview:_downImg];
    [_downImg addSubview:btn];
    
}

#pragma mark - CollectionView
- (void)selectCollection {
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];

    flow.itemSize = CGSizeMake(SCREEN_WIDTH/4, 60);
    
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    _selectColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _scrollView.height+5, SCREEN_WIDTH, 120)collectionViewLayout:flow];
    _selectColl.tag = 1100;
    _selectColl.contentSize = CGSizeMake(SCREEN_WIDTH, 120);
    [_selectColl registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:SELECTCELL];
    _selectColl.dataSource = self;
    _selectColl.delegate = self;
    [self addSubview:_selectColl];
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SELECTCELL forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake((cell.width - ITEMIMGWIDTH)/2, 0, ITEMIMGWIDTH,ITEMIMGWIDTH)];
    imageV.userInteractionEnabled = YES;
    imageV.image = [UIImage imageNamed:_selectImgArr[indexPath.row]];
    [cell addSubview:imageV];

    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, imageV.height, cell.width, 17)];
    nameLab.userInteractionEnabled = YES;
    nameLab.text = _selectNameArr[indexPath.row];
    nameLab.font = [UIFont systemFontOfSize:11];
    nameLab.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:nameLab];
    
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView.tag == 1100) {
        
        YYXCViewController *xcVC = [[YYXCViewController alloc] init];
        
        [self.viewController.navigationController pushViewController:xcVC animated:YES];
        
    }

}


#pragma mark - ScrollView
- (void)setHeaderArr:(NSMutableArray *)headerArr {
    
    _headerArr = headerArr;

    //获取数组的最后一个数据
    YYCarouselModel *model = [_headerArr lastObject];

    _downImgStr = [NSString stringWithFormat:@"%@%@",BASE_URL, model.imageUrl];

    [_downImg sd_setImageWithURL:[NSURL URLWithString:_downImgStr] placeholderImage:[UIImage imageNamed:@"default_picture_icon"]];
    [_headerArr removeLastObject];

    _pageControl.numberOfPages = _headerArr.count;

    _scrollView.contentSize = CGSizeMake((_headerArr.count + 2) * SCREEN_WIDTH, SCREEN_WIDTH*4/10);

    [self addScrollImage];

}



//轮播图
- (void)addScrollView {
    
    //轮播图
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*4/10)];
    _scrollView.tag = 1000;
    _scrollView.bounces = YES;
    [_scrollView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_scrollView];
    CGFloat scrollW = _scrollView.width;
    CGFloat scrollH = _scrollView.height;
 
    _scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    
    _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*4/10)];
    [_scrollView addSubview:_imageV];
    _imageV.image = DEFA_IMAGE;
 
    //pageController
    _pageControl = [[UIPageControl alloc] init];
    
    //    (253, 98, 42);
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:1.0];
    _pageControl.centerX = scrollW * 0.5;
    _pageControl.centerY = scrollH - 20;

    [self insertSubview:_pageControl aboveSubview:_scrollView];
    
    
}

//首页进入
- (void)addScrollImage {

    for(int i = 0 ; i < _headerArr.count + 2; i++){
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, _scrollView.height)];
        [_scrollView addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        //添加图片
        YYCarouselModel *model;
        if (i == 0) {
            model = _headerArr[_headerArr.count - 1];
        }else if (i == _headerArr.count + 1) {
            model = _headerArr[0];
        }else {
            model = _headerArr[i - 1];
        }
        NSString *url = [NSString stringWithFormat:@"http://xinchengguangchang.com%@",model.imageUrl];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default_picture_icon"]];        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = imageView.bounds;
        [btn addTarget:self action:@selector(carouselAct:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //移除遮盖视图
    [_imageV removeFromSuperview];
    
}



//轮播图点击事件
- (void)carouselAct:(UIButton *)sender {
  
    YYCarouseViewController *carouseVC = [[YYCarouseViewController alloc] init];
    
    YYCarouselModel *model = _headerArr[_page];
    
    carouseVC.url = model.url;
    
    if (model.url == nil) {
        
        return;
    }
    
    [self.viewController.navigationController pushViewController:carouseVC animated:YES];
    
}

#pragma mark - ScrollViewDelegate
-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    if (scrollView.tag == 1000) {
        
        //获取当前位置
        _page = scrollView.contentOffset.x/ scrollView.width;
        
        if (_page == _headerArr.count + 1) {
            
            //返回第一个
            [UIView animateWithDuration:.35 animations:^{
                
                scrollView.contentOffset = CGPointMake(scrollView.width, 0);
                
            }];

            _pageControl.currentPage = 0;
            
        }else if (_page == 0) {
            //返回最后一个
            [UIView animateWithDuration:.35 animations:^{
                
                scrollView.contentOffset = CGPointMake(_headerArr.count * SCREEN_WIDTH, 0);
                
            }];
            
            _pageControl.currentPage = _headerArr.count;
            
        }else {
            
            
            _pageControl.currentPage = _page - 1;
            
        }
        
        
    }else {
        
        
        
    }
}
#pragma mark - ADDTIMER
- (void)addTimer {
    
  _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changeScrollCont) userInfo:nil repeats:YES];
    
}

- (void)changeScrollCont {
    
    if (_page == 0) {
        
        _page = 1;
    }
    
    [UIView animateWithDuration:.35 animations:^{
        
        _scrollView.contentOffset = CGPointMake((_page+1)*SCREEN_WIDTH, 0);

    }];
//
}


@end
