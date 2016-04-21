//
//  YYBaseModel.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/28.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYBaseModel.h"

@implementation YYBaseModel



///  json数据转换成字典
///
///  @param jsonString JSON格式的字符串
///
///  @return 返回字典
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{

    if (jsonString == nil) {
        return nil;
    }
    
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
    
}
@end
