//
//  YYDetailTwoView.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/2.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYDetailTwoView.h"
#import "SegmentView.h"

@implementation YYDetailTwoView
{
    
    UIScrollView *_scroll;
}

- (id)initWithFrame:(CGRect)frame {
    
    
    if (self = [super initWithFrame:frame]) {
        
        
        
    }
    return self;
}


- (void)initSegment {
    
    SegmentView *seg = [[SegmentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    
    [self addSubview:seg];
    

    
}

- (void)initScrollView {
    
    //创建一个滚动视图
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,  SCREEN_WIDTH,SCREEN_HEIGHT)];
    [self addSubview:_scroll];
    
    _scroll.backgroundColor = [UIColor blackColor];
    
    //设置其滚动状态为分页状态
    _scroll.pagingEnabled = YES;
    _scroll.bounces = NO;
    
    //设置代理
    _scroll.delegate = self;
    
    
}










@end
