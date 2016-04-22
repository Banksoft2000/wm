//
//  YYDetailHeadView.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/2.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYDetailHeadView.h"
#import "YYDetailImgViewController.h"

@implementation YYDetailHeadView

{
    UIScrollView *_scrollView;
    YYDetailImgViewController *imgVC;
    

}

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self initScrollView];
        
    
    }
    
    return self;
}

- (void)setHeaderArr:(NSArray *)headerArr {
    
    _headerArr = headerArr;

    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*_headerArr.count, self.height);
    
    [self addScrollViewItem];
}

- (void)initScrollView {
    
    
    //轮播图
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = self.bounds;

    _scrollView.bounces = YES;
    [_scrollView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_scrollView];

    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    
}

- (void)addScrollViewItem {

    for(int i = 0 ; i < _headerArr.count; i++){
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, _scrollView.height)];
        [_scrollView addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        
        //添加图片
        NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,_headerArr[i]];
        [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default_picture_icon"]];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = imageView.bounds;
        [btn addTarget:self action:@selector(carouselAct:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:btn];
        
        btn.tag = 1400 + i;
    }
 
}

//item的点击事件---进入大图浏览界面
- (void)carouselAct:(UIButton *)sender {
  
    
    imgVC = [[YYDetailImgViewController alloc] init];

    imgVC.imageArr = _headerArr;
    imgVC.index = (int)sender.tag - 1400;
    
    [self.viewController.navigationController pushViewController:imgVC animated:YES];  
}

@end
