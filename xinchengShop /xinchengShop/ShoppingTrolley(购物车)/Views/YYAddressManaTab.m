//
//  YYAddressManaTab.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/12.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYAddressManaTab.h"
#import "YYAddressManaTableViewCell.h"

#import "YYSelectAddViewController.h"
#import "YYChangeAdressViewController.h"
#import "YYAdressViewController.h"
#import "YYPayViewController.h"

@implementation YYAddressManaTab

- (void)setDataArr:(NSMutableArray *)dataArr {
    
    _dataArr = dataArr;
    
    [self reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    YYAddressManaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"manaCell"];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYAddressManaTableViewCell" owner:nil options:nil] lastObject];
    }
    
    if (indexPath.row == 0) {
        

    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _dataArr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if ([self.viewController isKindOfClass:[YYSelectAddViewController class]]) {
        
        YYPayViewController *pay = [YYPayViewController payViewController];
        
        pay.model = _dataArr[indexPath.row];
        
        
        [self.viewController.navigationController popViewControllerAnimated:YES];
        
    }else {
        
        YYAddressModel *model = _dataArr[indexPath.row];
        
        YYAdressViewController *vc = [YYAdressViewController aderssViewController];
        
        vc.isAdd = NO;
        vc.model = model;
        [self.viewController.navigationController pushViewController:vc animated:YES];
        
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.viewController isKindOfClass:[YYChangeAdressViewController class]]) {
        
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.viewController isKindOfClass:[YYChangeAdressViewController class]]) {
        
        editingStyle = UITableViewCellEditingStyleDelete;
        
        [self initData:indexPath.row];        
    }
    
}

//删除
- (void)initData:(NSInteger)index {
    
    YYAddressModel *model = _dataArr[index];

    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,@"/app/memberAddress_delete"];
    
    NSDictionary *dic = @{@"id":model.id};
    
    [YYNetWorking postwithURL:url withParam:dic withHeader:nil success:^(id responsObjc) {
        
        if (responsObjc[@"success"]) {
            
            [_dataArr removeObjectAtIndex:index];
        }
        
        [self reloadData];
        
    }];
}

@end
