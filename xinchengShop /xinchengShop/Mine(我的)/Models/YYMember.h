//
//  YYMember.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/30.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YYMember :BaseModel<NSCoding>

@property (nonatomic, copy) NSString *account;

@property (nonatomic, assign) NSInteger birthday;

@property (nonatomic, assign) BOOL status;

@property (nonatomic, copy) NSString *siteId;

@property (nonatomic, assign) NSInteger freezeBalance;

@property (nonatomic, assign) long long lastLogin;

@property (nonatomic, copy) NSString *telephone;

@property (nonatomic, copy) NSString *trueName;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, copy) NSString *lastIp;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) CGFloat balance;

@property (nonatomic, copy) NSString *gradeType;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *imageFile;

@property (nonatomic, copy) NSString *grade;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, assign) NSInteger memberPoint;

@property (nonatomic, copy) NSString *ali;

@property (nonatomic, assign) BOOL stayStatus;

@property (nonatomic, assign) long long createTime;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, assign) BOOL buyStatus;

@property (nonatomic, copy) NSString *qq;

@property (nonatomic, assign) NSInteger loginNum;

@end

