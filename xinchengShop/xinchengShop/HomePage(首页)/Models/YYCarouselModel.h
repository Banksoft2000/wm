//
//  YYCarouselModel.h
//  xinchengShop
//
//  Created by harry_robin on 16/3/29.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "BaseModel.h"

@interface YYCarouselModel : BaseModel


//-------------首页(YYHomePageController)轮播图------

@property (nonatomic, copy) NSString *siteId;

@property (nonatomic, copy) NSString *position;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, assign) NSInteger endTime;

@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic, assign) NSInteger startTime;

@property (nonatomic, assign) NSInteger viewCount;

@property (nonatomic, copy) NSString *url;
@end
