//
//  YYDetailImgViewController.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/2.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^IndexBlock)(int index);
@interface YYDetailImgViewController : UIViewController<UIScrollViewDelegate>

//------产品详情图片的大图浏览-----------

@property (strong, nonatomic) IndexBlock indexBlock;

@property (strong, nonatomic) UIScrollView *imageScr;

//图片数组
@property (strong, nonatomic) NSArray *imageArr;

//传入的当前图片的位置----方便确定位移
@property (assign, nonatomic) int index;


- (void)addBlock:(IndexBlock)block;

@end
