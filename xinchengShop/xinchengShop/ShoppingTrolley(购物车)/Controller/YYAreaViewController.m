//
//  YYAreaViewController.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/12.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYAreaViewController.h"

#import "YYCityViewController.h"
#import "YYAreaData.h"
#import "YYChinaModel.h"
@interface YYAreaViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    YYBaseTableView *_tableView;
    
    NSArray *_province;
    NSArray *_city;
    NSArray *_county;
    
    UILabel *_zeroCell;
}

@end

@implementation YYAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initData];
    
    [self initTableView];
    
}
- (void)initData {
    
    YYAreaData *data = [[YYAreaData alloc] init];
    
    [data startParser];
    
    _province = [data province];
    

    _city = [data city];

    _county = [data county];
}

- (void)initTableView {
    
    _tableView = [[YYBaseTableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _province.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        _zeroCell = [[UILabel alloc] initWithFrame:cell.bounds];
        _zeroCell.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:_zeroCell];
        
        return cell;
        
    }else {
        
        static NSString *identy = @"province";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
        }
        
        YYChinaModel *model = _province[indexPath.row-1];
        cell.textLabel.text = model.name;
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YYChinaModel *model = _province[indexPath.row-1];

    _zeroCell.text = model.name;
    
    NSArray *city = _city[indexPath.row-1];
    NSArray *county = _county[indexPath.row-1];
    
    YYCityViewController *vc = [[YYCityViewController alloc] init];
   
    vc.city = city;
    vc.county = county;
    vc.adress = (NSMutableString *)model.name;
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
