//
//  PhotoScrollView.m
//  scroll_相册
//
//  Created by mac on 15/7/14.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "PhotoScrollView.h"

@implementation PhotoScrollView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
 
        [self addSubview:_imageView];
        
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.showsHorizontalScrollIndicator = NO;
        
        self.maximumZoomScale = 2.0;
        self.minimumZoomScale = 1;
        
        self.delegate = self;
        
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    
    return self;
}


-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return _imageView;
}



@end
