//
//  YYChangeAdressViewController.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/12.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYChangeAdressViewController.h"
#import "YYAddressManaTab.h"
#import "YYAdressViewController.h"
//#import "YYAddressData.h"

@interface YYChangeAdressViewController ()
{
    
    YYAddressManaTab *_tableView;
}

@end

@implementation YYChangeAdressViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if (_tableView) {
        
        [self initData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"收货地址管理";
    
    [self initTableView];
    [self initNavigationBar];
    
}
- (void)initData {
    
    if (!_dataArr) {
        
        _dataArr = [[NSMutableArray alloc] init];
        
    }else {
        
        [_dataArr removeAllObjects];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,@"/app/memberAddress_list"];
    
    NSDictionary *dic = @{@"memberId":MEMBERID_VALUE};
    
    [YYNetWorking postwithURL:url withParam:dic withHeader:nil success:^(id responsObjc) {
        
        NSArray *data = responsObjc[@"data"];
        
        for (NSDictionary *dic in data) {
            
            YYAddressModel *model = [[YYAddressModel alloc] initWithDictionary:dic];
            
            [_dataArr addObject:model];
            
        }
        _tableView.dataArr = _dataArr;
        
    }];
    
    
    
}


#pragma mark - NavigationBar
- (void)initNavigationBar {
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    
    right.frame =CGRectMake(0, 0, 50, 30);
    [right setTitle:@"新增" forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
    [right addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    
    right.backgroundColor = SHOPPING_DELETE_BG;
    
}

- (void)addAddress {
    
    YYAdressViewController *vc = [YYAdressViewController aderssViewController];
    vc.isAdd = YES;

    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - TableView
- (void)initTableView {
    
    _tableView = [[YYAddressManaTab alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    _tableView.dataArr = _dataArr;
    [self.view addSubview:_tableView];
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
