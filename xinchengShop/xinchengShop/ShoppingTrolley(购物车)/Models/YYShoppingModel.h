//
//  YYShoppingModel.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/8.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "BaseModel.h"

@interface YYShoppingModel : BaseModel

/*
 
 dataList[0].active=0&
 dataList[0].imageFile=/upload/20160124/1453600878751.jpg|&
 dataList[0].productId=fdb43d6bb3fe46519d5969020aee9d2f&
 dataList[0].productName=步步高家教机smart2 学习机S2小学中学英语课本同步学生平板电脑 &
 dataList[0].shopId=a8ca27abc15740788b7c137805a951cf&
 dataList[0].shopNo=test001&
 dataList[0].goodsNum=1&-----------------------购买数量
 dataList[0].price=3488.0&

 areaNo=120223&

dataList[0].total=3488.0&&
 */

@property (nonatomic, copy) NSString *shopNO;

@property (nonatomic, copy) NSString *active;

@property (nonatomic, copy) NSString *shopId;

@property (nonatomic, copy) NSString *shopImg;

@property (nonatomic, copy) NSString *shopName;

@property (nonatomic, copy) NSString *productId;

//imagefile
@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *number;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *ids;



@property (nonatomic, copy) NSString *staic;
//库存
@property (nonatomic, copy) NSString *stock;

@property (nonatomic, copy) NSString *areaNo;
@end
