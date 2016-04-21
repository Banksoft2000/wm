//
//  SegmentView.m
//  SegmentView
//
//  Created by Mac on 15-10-24.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "SegmentView.h"


@interface SegmentView ()
@property (nonatomic, strong) UIButton *btn;
@end

@implementation SegmentView
#define Width self.frame.size.width/_titleList.count
#define Height self.frame.size.height

#define kButtonTagBase 800

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
}



- (void)setTitleList:(NSArray *)titleList {
    
    
    _titleList = titleList;

    int index = 0;
    for (NSString *title in _titleList) {

        if ([title isEqualToString:@""]) {
            
            index ++;
            continue;
        }
      
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(index * Width, 0, Width, Height);
//        self.btn=button;
        
        _button.tag = kButtonTagBase + index;
        
        [_button setTitle:title forState:UIControlStateNormal];
        
        [_button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
 
        _button.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.btn=_button;
        
        [self addSubview:_button];

        index ++;
        
        
        if (index == 1) {
            
            _button.selected = YES;
            _button.titleLabel.font = [UIFont systemFontOfSize:15];
            
        }
    }
 
//    添加滑块
    _seletImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-5,Width , 2)];
    
    _seletImageView.backgroundColor = [UIColor redColor];
    
//    UIImageView *skateboardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_seletImageView.frame.size.width/2-20, 0, 40, 2)];
//    skateboardImageView.backgroundColor = [UIColor redColor];
//    [_seletImageView addSubview:skateboardImageView];
    
    [self addSubview:_seletImageView];
    
    
    
    
    
}

- (void)buttonAction:(UIButton *)sender {

    
    int index = (int)sender.tag - kButtonTagBase;
    
    [UIView animateWithDuration:.2 animations:^{
        
        _seletImageView.frame = CGRectMake(index * Width, self.frame.size.height-5, Width, 2);
    }];
    
    for (UIView *view in self.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            UIButton *button = (UIButton *)view;
            button.selected = NO;
            button.titleLabel.font = [UIFont systemFontOfSize:13];
        
        }
  
    }
    sender.selected = YES;
    sender.titleLabel.font = [UIFont systemFontOfSize:15];
 
    
    
    
    
    if (_segmentBlock) {
        
        _segmentBlock(index);
    }
 
}


- (void)addBlock:(SegmentbBlock)block {
    
    _segmentBlock = block;
}


//外部传入button 的index 值
- (void)setSelectIndex:(NSInteger)selectIndex {
    
    _selectIndex = selectIndex;
    
    UIButton *button = (UIButton *)[self viewWithTag:kButtonTagBase +_selectIndex];
    
    [self buttonAction:button];
}

//外部出入滑块的图片
-(void)setSelectImage:(NSString *)selectImage {
    
    _selectImage = selectImage;
    
    _seletImageView.image = [UIImage imageNamed:_selectImage];
    
}

@end

