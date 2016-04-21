//
//  YYGuideController.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/22.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYGuideController.h"
#import "UIView+Extension.h"
#import "YYMainTabBarController.h"
#define  NewfeatureCount 3

@interface YYGuideController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation YYGuideController



static NSString * const reuseIdentifier = @"guide_cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [scrollView setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    //2.添加图片到ScrollView
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    for(int i = 0 ; i < NewfeatureCount; i++){
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.x = i * scrollW;
        imageView.y = 0;
        //显示图片
        NSString *name = [NSString stringWithFormat:@"教学_%d",i+1];
        imageView.image =[UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        if(i == NewfeatureCount - 1){
            [self setLastImageView:imageView];
        }
        
    }
    
    
    scrollView.contentSize = CGSizeMake(NewfeatureCount * scrollW, 0);
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = NewfeatureCount;
    pageControl.backgroundColor = [UIColor whiteColor];
    
//    (253, 98, 42);
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:1.0];
    pageControl.centerX = scrollW * 0.5;
    pageControl.centerY = scrollH - 20;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;

    
}

//设置最后一张图片
-(void) setLastImageView:(UIImageView *) image
{   image.userInteractionEnabled = YES;
    
    UIButton *startbtn = [[UIButton alloc] init];
    [startbtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startbtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    startbtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [startbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    startbtn.size = startbtn.currentBackgroundImage.size;
    startbtn.centerX = image.width * 0.5;
    startbtn.centerY = image.height * 0.90;
    [startbtn setTitle:@"立即开始" forState:UIControlStateNormal];
    [startbtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [image addSubview:startbtn];
    
}
- (void) startClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[YYMainTabBarController alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x/ scrollView.width;
    self.pageControl.currentPage = (int)(page + 0.5);
}




//隐藏状态栏
-(BOOL)prefersStatusBarHidden{

    return YES;
}




@end
