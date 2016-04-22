//
//  YYThemeTableView.m
//  xinchengShop
//
//  Created by harry_robin on 16/3/31.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYThemeTableView.h"
#import "YYThemeTableViewCell.h"
#import "YYDetailViewController.h"
@implementation YYThemeTableView

- (void)initDetails {
    
    
}

- (void)setDataArr:(NSArray *)dataArr {
    
    _dataArr = dataArr;
    
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static  NSString *themeCell = @"theme";
    
    YYThemeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:themeCell];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYThemeTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_dataArr.count >= 1) {
        
        cell.model = _dataArr[indexPath.row];
    }

    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (_dataArr) {
        
        YYDetailViewController *detailVC = [[YYDetailViewController alloc] init];
        
        
        YYClearanceModel *model = _dataArr[indexPath.row];
        
        detailVC.url = model.id;
        
        [self.viewController.navigationController pushViewController:detailVC animated:YES];
    }
   
    
}


@end
