//
//  YYShop.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/11.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "BaseModel.h"


@interface YYShop : BaseModel<NSCoding>





@property (nonatomic, assign) NSInteger dispatchPrice;

@property (nonatomic, copy) NSString *ali;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *grade;

@property (nonatomic, assign) BOOL workTime;

@property (nonatomic, copy) NSString *no;

@property (nonatomic, strong) NSArray *shopTimeSetting;

@property (nonatomic, assign) BOOL recommend;

@property (nonatomic, assign) NSInteger serviceScore;

@property (nonatomic, assign) NSInteger productCount;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, assign) BOOL deposit;

@property (nonatomic, assign) BOOL auditStatus;

@property (nonatomic, assign) BOOL rent;

@property (nonatomic, copy) NSString *imageFile;

@property (nonatomic, assign) BOOL status;

@property (nonatomic, assign) BOOL realName;

@property (nonatomic, copy) NSString *description;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *county;

@property (nonatomic, assign) BOOL realShop;

@property (nonatomic, assign) NSInteger pointLng;

@property (nonatomic, copy) NSString *gradeType;

@property (nonatomic, copy) NSString *business;

@property (nonatomic, copy) NSString *siteId;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *qq;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger sumProduct;

@property (nonatomic, copy) NSString *xinchengPoint;

@property (nonatomic, assign) NSInteger distance;

@property (nonatomic, assign) NSInteger matchScore;

@property (nonatomic, assign) NSInteger expressPrice;

@property (nonatomic, assign) NSInteger orderCount;

@property (nonatomic, assign) NSInteger perPrice;

@property (nonatomic, copy) NSString *beginTime;

@property (nonatomic, assign) BOOL showShop;

@property (nonatomic, copy) NSString *district;

@property (nonatomic, assign) NSInteger startTime;

@property (nonatomic, assign) NSInteger dispatchScore;

@property (nonatomic, copy) NSString *telephone;

@property (nonatomic, assign) NSInteger goodCount;

@property (nonatomic, assign) NSInteger pointLat;

@property (nonatomic, assign) NSInteger rate;

@property (nonatomic, assign) NSInteger closeTime;

@property (nonatomic, copy) NSString *shopServerType;

@property (nonatomic, assign) NSInteger collectionCount;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *idCard;

@property (nonatomic, assign) BOOL ship;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, assign) NSInteger commentCount;

@property (nonatomic, assign) BOOL xincheng;

@property (nonatomic, copy) NSString *shopType;

@property (nonatomic, copy) NSString *account;

@end




