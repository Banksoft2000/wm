//
//  YYCountyViewController.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/12.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DetailDelegate <NSObject>


- (void)cityDetail:(NSString *)area;

@end

//县
@interface YYCountyViewController : UIViewController

@property (nonatomic, weak) id<DetailDelegate> areaDelegate;
@property (nonatomic, strong) NSArray *county;
@property (nonatomic, copy) NSMutableString *adress;





@end
