//
//  YYCXHomeModel.h
//  xinchengShop
//
//  Created by harry_robin on 16/3/29.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYCXHomeModel  : BaseModel

//---------------主题街----------------

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
