//
//  YYPayViewController.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/11.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYPayViewController.h"
#import "YYPayTabView.h"

#import "YYMyData.h"
#import "YYPaymentViewController.h"

@interface YYPayViewController ()
{
    
    YYPayTabView *_payTabView;
    UIView *_downView;
    NSDictionary *diction;
    NSMutableArray *_productArr;
    
}

@end

@implementation YYPayViewController

//刷新数据
- (void)viewWillAppear:(BOOL)animated {
 
    [super viewWillAppear:animated];
    
    if (_payTabView) {
        
//        [self initData];
        [_payTabView reloadData];
    }
    
}

+ (YYPayViewController *)payViewController {
    
    static YYPayViewController  *vc = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        vc = [[YYPayViewController alloc] init];
        
    });
    
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if (!diction) {
        diction = [[NSDictionary alloc] init];
    }
    
    [self initTableView];
    [self initDownView];
//    [self initData];
    [self initAddressData];
    
}
/*
#pragma mark - 获取数据
- (void)initData {
    
    YYMyData *data = [[YYMyData alloc] init];
    
    _productArr = [[NSMutableArray alloc] init];
    _shopArr = [[NSMutableArray alloc] init];
    
    NSArray *dataArr =[data getData];
    
    for (NSArray *productArr in dataArr) {
        
        //productArr----店铺
        //dic ---- 产品
        for (NSDictionary *dic in productArr) {
            
            YYShoppingModel *model = [[YYShoppingModel alloc] initWithDictionary:dic];
            
            [_productArr addObject:model];
            
        }
        //数据
        [_shopArr addObject:_productArr];
        
    }
    
    if (_payTabView) {
        
        _payTabView.dataArr = _shopArr;
        [_payTabView reloadData];
    }
}
*/
- (void)setShopArr:(NSMutableArray *)shopArr {
    
    _shopArr = shopArr;
    
    if (_payTabView) {
        
        _payTabView.dataArr = _shopArr;
        [_payTabView reloadData];
    }
}

- (void)setModel:(YYAddressModel *)model {
    
    _model = model;
    
    _payTabView.model = model;
    
    [_payTabView reloadData];
    
}

- (void)initAddressData {
    
    NSMutableArray *addressArr = [[NSMutableArray alloc] init];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,@"/app/memberAddress_list"];
    
    NSDictionary *dic = @{@"memberId":MEMBERID_VALUE};
    
    [YYNetWorking postwithURL:url withParam:dic withHeader:nil success:^(id responsObjc) {
        
        NSArray *data = responsObjc[@"data"];
        
        for (NSDictionary *dic in data) {
            
            YYAddressModel *model = [[YYAddressModel alloc] initWithDictionary:dic];
            if (model.status == YES) {
                
                _payTabView.model = model;
            }
            
            [addressArr addObject:model];
            
        }
        
        if (_payTabView.model == nil) {
            
            YYAddressModel *model = addressArr[0];
            
            _payTabView.model = model;
        }
    
    }];
    

    
}

- (void)initDownView {
    
    _downView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-64-50, SCREEN_WIDTH, 50)];
    _downView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"top_line_50"]];
    [self.view addSubview:_downView];
    
    
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_downView addSubview:okBtn];
    
    okBtn.backgroundColor = SHOPPING_DELETE_BG;
    [okBtn setTitle:@"确认" forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(pushYYPaymentVC) forControlEvents:UIControlEventTouchUpInside];
    [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(_downView.mas_height);
        make.bottom.equalTo(_downView.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.width.equalTo(@100);
        
    }];
    
    UILabel *price = [[UILabel alloc] init];
    [_downView addSubview:price];
    price.textAlignment = NSTextAlignmentCenter;
    [price mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(_downView.mas_height);
        make.bottom.equalTo(_downView.mas_bottom);
        make.right.equalTo(okBtn.mas_left);
        make.width.equalTo(@200);
        
    }];

    NSString *moneyStr = [NSString stringWithFormat:@"合计：￥%ld元",_money];
    NSInteger length = [moneyStr length];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:moneyStr attributes:@{NSFontAttributeName:BUTTON_FONT}];
    [attStr addAttribute:NSForegroundColorAttributeName value:PRICE_TEXT_RED range:NSMakeRange(3, length - 4)];
    [price setAttributedText:attStr];
  
}

- (void)pushYYPaymentVC {
    
    YYPaymentViewController *pay = [[YYPaymentViewController alloc] initWithNibName:@"YYPaymentViewController" bundle:nil];

    [self.navigationController pushViewController:pay animated:YES];
    
}

- (void)initTableView {
    
    _payTabView = [[YYPayTabView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50-64) style:UITableViewStyleGrouped];
    
    _payTabView.dataArr = _shopArr;
    [self.view addSubview:_payTabView];
    
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
