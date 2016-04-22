//
//  YYDetailImgViewController.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/2.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYDetailImgViewController.h"

#import "PhotoScrollView.h"
@interface YYDetailImgViewController ()
{
    NSInteger preIndex;
}

@end

@implementation YYDetailImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];

    
}

- (void)initNavigationBar {
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(0, 0, 30, 30);
    
    [back setImage:[UIImage imageNamed:@"title_back_icon"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];
    
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)back:(UIButton *)sender {
    
    if (_indexBlock) {
        
        _indexBlock(_index);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addBlock:(IndexBlock)block {
    
    
    _indexBlock = block;
}

- (void)setImageArr:(NSArray *)imageArr {
    
    _imageArr = imageArr;
    
    [self initScrollView];
    [self addScrollViewItem];
    
    _imageScr.contentSize = CGSizeMake(SCREEN_WIDTH * _imageArr.count, SCREEN_HEIGHT);
}

- (void)setIndex:(int)index {

    _index = index;

    //设置偏移量
    _imageScr.contentOffset = CGPointMake(SCREEN_WIDTH*_index, 0);
}

- (void)initScrollView {
    
    //创建一个滚动视图
    _imageScr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,  SCREEN_WIDTH,SCREEN_HEIGHT)];
    [self.view addSubview:_imageScr];
 
    _imageScr.backgroundColor = [UIColor blackColor];
    
    //设置其滚动状态为分页状态
    _imageScr.pagingEnabled = YES;
    _imageScr.bounces = NO;
    
    //设置代理
    _imageScr.delegate = self;
  
}

- (void)addScrollViewItem {
 
    for (int i = 0; i < _imageArr.count; i ++) {

        PhotoScrollView *photoSV = [[PhotoScrollView alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,_imageArr[i]];
        [photoSV.imageView sd_setImageWithURL:[NSURL URLWithString:url]];
        
        [_imageScr addSubview:photoSV];
        photoSV.tag = 200 + i;
    }
    //设置上一次页面的位置
    preIndex = 0;
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //获取当前图片的位置
    NSInteger nowIndex = scrollView.contentOffset.x/SCREEN_WIDTH;
    
    
    //对返回值进行处理
    if (nowIndex > preIndex) {
        
        _index ++;
    }else {
        
        _index --;
    }
    
    
    //对进行缩放处理的图片还原
    if (nowIndex != preIndex) {
        //利用tag值进行页面的获取
        PhotoScrollView *photoSV = (PhotoScrollView*)[scrollView viewWithTag:preIndex+200];
        //手动将缩放值改为1；
        photoSV.zoomScale = 1;
        preIndex = nowIndex;
    }
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
