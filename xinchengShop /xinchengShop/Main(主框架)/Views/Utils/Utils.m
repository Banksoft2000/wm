//
//  Utils.m
//  qqershou
//
//  Created by harry_robin on 15/11/18.
//  Copyright © 2015年 banksoft. All rights reserved.
//

#import "Utils.h"
#import <MBProgressHUD.h>
@implementation Utils

+(MBProgressHUD *) createHUB
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithWindow:window];
    HUD.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
    [window addSubview:HUD];
    [HUD show:YES];
    //[HUD addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:HUD action:@selector(hide:)]];
    
    return HUD;
}
/**
 HUD = [[MBProgressHUD alloc] initWithView:self.view];
 [self.view addSubview:HUD];
 HUD.labelText = @"操作成功";
 HUD.mode = MBProgressHUDModeText;
 
 //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
 //    HUD.yOffset = 150.0f;
 //    HUD.xOffset = 100.0f;
 
 [HUD showAnimated:YES whileExecutingBlock:^{
 sleep(2);
 } completionBlock:^{
 [HUD removeFromSuperview];
 [HUD release];
 HUD = nil;
 }];
 */
+(void)createAllTextHUB:(NSString *)alert
{
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithWindow:window];
    HUD.labelText = alert;
    HUD.mode = MBProgressHUDModeText;

    
    //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
        HUD.yOffset = 200.0f;
        [window addSubview:HUD];
    
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        [HUD removeFromSuperview];
    }];
}

+(NSString *) getMd5_32Bit:(NSString *)inputStr{
    
    const char *cStr = [inputStr UTF8String];//转换成utf-8
    
    unsigned char result[16];//开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    
    CC_MD5( cStr, strlen(cStr), result);
    
    /*
     
     extern unsigned char *CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
     
     把cStr字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了result这个空间中
     
     */
    
    return [NSString stringWithFormat:
            
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            
            result[0], result[1], result[2], result[3],
            
            result[4], result[5], result[6], result[7],
            
            result[8], result[9], result[10], result[11],
            
            result[12], result[13], result[14], result[15]];
}

+(void) toTelphone:(NSString *)telphoneNum andParentView:(UIView *)parentView
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",telphoneNum];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [parentView addSubview:callWebview];
}

+(void) toMessage:(NSString *)telphoneNum andParentView:(UIView *)parentView andBody:(id)messageBody
{
    

}


//利用正则表达式验证
+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


@end


