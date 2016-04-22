//
//  YYProductReleaseController.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/20.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYProductReleaseController.h"

@interface YYProductReleaseController ()

@end

@implementation YYProductReleaseController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"商品发布";
    NSLog(@"dfada ");
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

//显示tableview的下划线长度足够长
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
@end
