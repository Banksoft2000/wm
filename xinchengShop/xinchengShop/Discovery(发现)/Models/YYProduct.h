//
//  YYCategory.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/26.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YYProduct : BaseModel<NSCoding>

@property (nonatomic, copy) NSString *id;

@property (nonatomic, assign) BOOL leaf;

@property (nonatomic, copy) NSString *keyword;

@property (nonatomic, copy) NSString *description;

@property (nonatomic, assign) BOOL status;

@property (nonatomic, assign) BOOL recommend;

@property (nonatomic, copy) NSString *productModelId;

@property (nonatomic, assign) BOOL inherit;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, assign) BOOL root;

@property (nonatomic, copy) NSString *no;

@property (nonatomic, assign) NSInteger sort;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger grade;


@end

