//
//  YYCityViewController.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/12.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYCityViewController.h"
#import "YYCountyViewController.h"
#import "YYChinaModel.h"
@interface YYCityViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    YYBaseTableView *_tableView;
    
    UILabel *_zeroCell;
}
@end

@implementation YYCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initTableView];

}

-(void)setCity:(NSArray *)city {
    
    _city = city;

    [_tableView reloadData];

}

- (void)initTableView {
    
    _tableView = [[YYBaseTableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _city.count;
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
        
        YYChinaModel *model = _city[indexPath.row-1];
        cell.textLabel.text = model.name;
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YYChinaModel *model = _city[indexPath.row-1];
    
    _zeroCell.text = model.name;
    
    
    NSArray *county = _county[indexPath.row-1];
    
    YYCountyViewController *vc = [[YYCountyViewController alloc] init];

    vc.county = county;
    
    vc.adress = [[NSMutableString alloc] initWithFormat:@"%@ %@",_adress,model.name ];

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
