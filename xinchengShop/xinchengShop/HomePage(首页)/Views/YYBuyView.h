//
//  YYBuyView.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/2.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYStandardModel.h"
#import "YYImageModel.h"
#import "YYTextModel.h"
#import "YYPriceModel.h"
#import "YYStandColl.h"


@protocol BuyDelegate <NSObject>

- (void)productDetail:(NSDictionary *)dic;
- (void)aaaaaaaaaaaaaa;

@end
@interface YYBuyView : UIView<StandDelegate>


@property (weak, nonatomic) id<BuyDelegate> buyDelegate;

@property (strong, nonatomic) NSArray *standArr;
@property (strong, nonatomic) NSArray *colorArr;
@property (strong, nonatomic) NSArray *sizeArr;
@property (strong, nonatomic) NSArray *priceArr;
@property (strong, nonatomic) NSArray *allData;


@property (strong, nonatomic) IBOutlet UIButton *close;
//产品图
@property (strong, nonatomic) IBOutlet UIImageView *icon;

//价格
@property (strong, nonatomic) IBOutlet UILabel *price;

//库存
@property (strong, nonatomic) IBOutlet UILabel *sale;

//选择规格之后显示用户选中的规格和库存---第三个label
@property (strong, nonatomic) IBOutlet UILabel *staic;

@property (strong, nonatomic) IBOutlet UIView *color;

@property (strong, nonatomic) IBOutlet UIView *size;

@property (strong, nonatomic) IBOutlet UIView *number;


@property (strong, nonatomic) IBOutlet UIButton *makeSure;

//规格 -----规格的数据不固定：大小 体积、样式等
@property (strong, nonatomic) IBOutlet UIView *standard;

///整个视图的装载视图-----目的：整体上移
@property (strong, nonatomic) IBOutlet UIView *standBgView;



@end
