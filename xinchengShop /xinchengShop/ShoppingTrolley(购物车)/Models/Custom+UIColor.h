
//
//  Custom+UIColor.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/8.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//




#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UIColor(Custom)
+ (UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor*) colorWithHex:(NSInteger)hexValue;
+ (NSString *) hexFromUIColor: (UIColor*) color;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end
