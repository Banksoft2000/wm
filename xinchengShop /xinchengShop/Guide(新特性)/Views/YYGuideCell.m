//
//  YYGuideCell.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/22.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYGuideCell.h"
#import "YYMainTabBarController.h"

@interface YYGuideCell ()
@property (nonatomic, strong) UIImageView *imgViewBg;
@property (nonatomic, strong) UIButton *startBtn;

@end

@implementation YYGuideCell

- (void)setCellCount:(int)count currentCellIndex:(int)idx {
    if (idx == count - 1) {
        self.startBtn.hidden = NO;
    } else {
        self.startBtn.hidden = YES;
    }
}


-(void)setImage:(UIImage *)image{

    _image = image;
    
    self.imgViewBg.image = image;
}
- (UIImageView *)imgViewBg {
    if (_imgViewBg == nil) {
        _imgViewBg = [[UIImageView alloc] init];
        [self.contentView addSubview:_imgViewBg];
    }
    return _imgViewBg;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imgViewBg.frame = self.bounds;
    
//    self.startBtn.frame = self.bounds;
    //设置立即体验的按钮大小
    
    CGFloat w = 161;
    CGFloat h = 40;
    CGFloat y = self.bounds.size.height * 0.9;
    CGFloat x = (self.bounds.size.width - w) * 0.5;
    self.startBtn.frame = CGRectMake(x, y, w, h);

}

-(UIButton *)startBtn{

    if (_startBtn==nil) {
        _startBtn = [[UIButton alloc]init];
        
        [_startBtn setBackgroundImage:[UIImage imageNamed:@"guideStart"] forState:UIControlStateNormal];
        
        [self.contentView addSubview:_startBtn];
        //为按钮添加点击事件
        [_startBtn addTarget:self action:@selector(didClickStartBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _startBtn;
}

// 点击"立即体验"按钮
- (void)didClickStartBtn:(UIButton *)sender {
    // 1. 创建一个主控制器
    YYMainTabBarController *mainVc = [[YYMainTabBarController alloc] init];
    
    // 2. 让当前window的根控制器跳转到主控制器
    [UIApplication sharedApplication].keyWindow.rootViewController = mainVc;
}




@end
