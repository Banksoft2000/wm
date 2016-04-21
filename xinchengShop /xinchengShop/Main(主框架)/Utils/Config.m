//
//  Config.m
//  qqershou
//
//  Created by harry_robin on 15/11/18.
//  Copyright © 2015年 banksoft. All rights reserved.
//

#import "Config.h"

@implementation Config

+(void)saveOwnAccount:(NSString *)account andPassword:(NSString *)password
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:account forKey:account];
    [defaults setObject:password forKey:password];
    [defaults synchronize];
}
@end
