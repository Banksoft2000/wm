//
//  ImageUtils.h
//  qqershou
//
//  Created by harry_robin on 16/1/29.
//  Copyright © 2016年 banksoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageUtils : NSObject
/**
 *POST 提交 并可以上传图片目前只支持单张
 */
+ (NSString *)postRequestWithURL: (NSString *)url  // IN
                      postParems: (NSMutableDictionary *)postParems // IN 提交参数据集合
                     picFilePath: (NSString *)picFilePath  // IN 上传图片路径
                     picFileName: (NSString *)picFileName;  // IN 上传图片名称

+ (NSString *)uploadAudioFile:(NSData *)data withParams:(NSDictionary *)params withFileName:(NSString *)fileName withFileType:(NSString *)fileType withUrl:(NSString *)url withKey:(NSString *)namekey;

/**
 * 修发图片大小
 */
+ (UIImage *) imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize) newSize;
/**
 * 保存图片
 */
+ (NSString *)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName;
/**
 * 生成GUID
 */
+ (NSString *)generateUuidString;
@end
