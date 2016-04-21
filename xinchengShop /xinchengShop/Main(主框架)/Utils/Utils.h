//
//  Utils.h
//  qqershou
//
//  Created by harry_robin on 15/11/18.
//  Copyright © 2015年 banksoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager+Util.h"
#import <CommonCrypto/CommonDigest.h>
#import <MessageUI/MessageUI.h>

@class MBProgressHUD;

@interface Utils : NSObject<MFMessageComposeViewControllerDelegate>

#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
 
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)

+(MBProgressHUD *) createHUB;
+(void) createAllTextHUB:(NSString *) alert;
+(NSString *) getMd5_32Bit:(NSString *) inputStr;
+(void) toTelphone:(NSString *)telphoneNum andParentView:(UIView *) parentView;
+(void) toMessage:(NSString *) telphoneNum andParentView:(UIView *) parentView andBody:messageBody;


+(void) alertWithTitle:(NSString *) title andMsg:(NSString *) msg andParentViewController: (UIViewController *) parentViewController;

+(BOOL)isValidateEmail:(NSString *)email;

@end
