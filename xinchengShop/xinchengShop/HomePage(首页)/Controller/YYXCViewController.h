//
//  YYXCViewController.h
//  xinchengShop
//
//  Created by harry_robin on 16/3/30.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYXCViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, copy) NSString *url;

//外部传入数据请求参数----需要在外部拼接成 key=value 格式
@property (nonatomic, copy) NSString *key;

@end
