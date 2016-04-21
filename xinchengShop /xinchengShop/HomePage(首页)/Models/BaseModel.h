//
//  BaseModel.h
//  project1
//
//  Created by Mac on 15-7-22.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
-(id)initWithDictionary:(NSDictionary *)dic;
- (void)setAttribute:(NSDictionary *)dic;

/**
 *  方法说明： 获取解析后的字符串
 *
 *  @param sourceString 需要解析的字符串
 *
 *  @return NSString
 */
- (NSString *)getRegexWithString:(NSString *)sourceString;

/**
 *  模型转字典
 *
 *  @return 字典
 */
- (NSDictionary *)dictionaryFromModel;

@property(nonatomic,strong)NSDictionary *map;

@end
