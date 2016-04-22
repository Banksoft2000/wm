
//
//  YYHomePageController.h
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/22.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//
#import "UIView+UIViewController.h"
@implementation UIView (UIViewController)

- (UIViewController *)viewController {
   
    UIResponder *next = self.nextResponder;
    
    do {
        
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
        
    }while(next != nil);
    
    return nil;
}

@end
