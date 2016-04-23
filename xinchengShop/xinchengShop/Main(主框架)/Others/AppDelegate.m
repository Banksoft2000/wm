//
//  AppDelegate.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/22.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "AppDelegate.h"
#import "YYMainTabBarController.h"
#import "YYGuideController.h"

#import "UMSocial.h"
#import "WXApi.h"

#import "UMSocialQQHandler.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialWechatHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //1.创建window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    //2.设置window 为主窗口
//    self.window.backgroundColor = [UIColor redColor];
//    self.window.rootViewController = [[YYGuideController alloc]init];
    [self chooseStartViewController];
    [self.window makeKeyAndVisible];
    
    
    [UMSocialData  setAppKey: @"4230626533"];

    //qq登录
     [UMSocialQQHandler setQQWithAppId:@"1105307832" appKey:@"xWkj29O3F5OAZOll" url:@"http://www.umeng.com/social"];
 
    //微博登录
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
//    [UMSocialSinaHandler openSSOWithRedirectURL:nil];
    
    //微信登录
    [UMSocialWechatHandler setWXAppId:@"wxe4d53f58f26cd989" appSecret:@"9a5eaf0585b6bb69462d2c7e17dbfd7a" url:@"http://www.umeng.com/social"];
    
    //向微信注册
    [WXApi registerApp:@"wxe4d53f58f26cd989" withDescription:@""];
    
    return YES;
}

//支付的界面跳转
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    NSLog(@"1url = %@   [url host] = %@",url,[url host]);
    
    if(url != nil && [[url host] isEqualToString:@"pay"]){
        //微信支付
        NSLog(@"微信支付");
        return [WXApi handleOpenURL:url delegate:self];
    }
    else{
        //其他
        return YES;
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"2url = %@   [url host] = %@",url,[url host]);
    
    if(url != nil && [[url host] isEqualToString:@"pay"]){//微信支付
        
        NSLog(@"微信支付");
        return [WXApi handleOpenURL:url delegate:self];
    }
    else{//其他
        return YES;
    }
}
//收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
- (void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[PayResp class]])
    {
        
#warning 支付结果处理
        PayResp *response = (PayResp *)resp;
        
        //        NSLog(@"支付结果 %d===%@",response.errCode,response.errStr);
        
        switch (response.errCode) {
            case WXSuccess: {
                
                NSLog(@"支付成功");
                
                //...支付成功相应的处理，跳转界面等
                
                break;
            }
            case WXErrCodeUserCancel: {
                
                NSLog(@"用户取消支付");
                
                //...支付取消相应的处理
                
                break;
            }
            default: {
                
                NSLog(@"支付失败");
                
                //...做相应的处理，重新支付或删除支付
                
                break;
            }
        }
    }
    
}



#pragma mark 以下两个方法用于处理应用间跳转的

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{

    return [UMSocialSnsService handleOpenURL:url];
}


// 选择启动控制器
- (void)chooseStartViewController {
    // 1. 获取当前app的版本号
    NSString *current_ver = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    // 2. 获取保存在偏好设置中的版本号
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *app_ver = [userDefaults objectForKey:@"app_ver"];
    
    // 3. 比较偏好设置中保存的app的版本号是否和当前app的版本号一致
    // 如果版本号一致, 表示此app没有更新过
    // 如果版本号不一致, 表示此app是第一次使用或者是更新后的第一次使用
    if ([current_ver isEqualToString:app_ver]) {
        // 表示不是第一次启动，也不是更新以后的第一次启动
        // 2. 创建UITabBarController
        YYMainTabBarController *mainVc = [[YYMainTabBarController alloc] init];
        
        // 3. 设置UIWindow的根控制器
        self.window.rootViewController = mainVc;
        // NSLog(@"不是第一次启动");
    } else {
        
        YYGuideController *guideVc = [[YYGuideController alloc] init];
        // 3. 设置UIWindow的根控制器
        self.window.rootViewController = guideVc;
        // 表示是第一次启动，或者是更新以后的第一次启动
        // NSLog(@"是第一次启动");
    }
    
    // 4. 无论是否是第一次启动, 都要把当前版本号写入到"偏好设置"中
    [userDefaults setObject:current_ver forKey:@"app_ver"];
    [userDefaults synchronize];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
