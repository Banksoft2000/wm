//
//  YYSelectAddViewController.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/12.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYSelectAddViewController.h"
#import "YYAddressManaTab.h"
#import "YYChangeAdressViewController.h"
#import "YYAddressModel.h"


//#import "YYAddressData.h"
#import "YYAddressModel.h"

#define DOWNVIEW_HEIGHT 44
@interface YYSelectAddViewController ()
{
    YYAddressManaTab *_tableView;
    NSMutableArray *_dataArr;
}

@end

@implementation YYSelectAddViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    if (_tableView) {
        
        [self initData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"选择收货地址";
    self.view.backgroundColor = BG_GRAY;

    [self initTableView];
    [self initDownView];

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

#pragma mark - DownView
- (void)initDownView {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake( 8,_tableView.height +8, SCREEN_WIDTH - 16, DOWNVIEW_HEIGHT);
    
    [self.view addSubview:button];
    
    [button setBackgroundColor:SHOPPING_DELETE_BG];
    [button setTitle:@"收货地址管理" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(changeAddress) forControlEvents:UIControlEventTouchUpInside];
    
    button.layer.cornerRadius = 10;
}

- (void)changeAddress {
    
    YYChangeAdressViewController *vc = [[YYChangeAdressViewController alloc] init];
    
    vc.dataArr = _dataArr;
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark - TableView
- (void)initTableView {
    
    _tableView = [[YYAddressManaTab alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - DOWNVIEW_HEIGHT - 16)];
    
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
