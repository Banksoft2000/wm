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
    
    NSString *_addressId;
    
}

@end

@implementation YYPayViewController

//刷新数据
- (void)viewWillAppear:(BOOL)animated {
 
    [super viewWillAppear:animated];
    
    if (_payTabView) {
        
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
    [self initAddressData];
    
}

//产品数据
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

#pragma mark - 获取地址
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
                
                _payTabView.addressId = model.id;
            }
            
            [addressArr addObject:model];
            
        }
        
        if (_payTabView.model == nil) {
            
            YYAddressModel *model = addressArr[0];
            
            _payTabView.model = model;
            _payTabView.addressId = model.id;
            
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
    
    /**
     *  自己挖的坑自己跳
     *
     *  坑： 保存的数据与后台的数据格式不一样
     *  
     *  原因： 前期不知道后台需要什么格式的数据
     *
     *  为什么不将存储的数据与后台的数据保持一致
     *
     *  时间不允许修改 且 其他地方需要本地保存的数据格式
     *
     *  后期修改原则  将数据保存为后台需要的数据
     */
    //产品的数量
    int m = 0;
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
    NSMutableString *shopId = [[NSMutableString alloc] init];
    NSMutableString *remark = [[NSMutableString alloc] init];
    for (int i = 0; i < _shopArr.count; i ++ ) {
        
        NSArray *product = _shopArr[i];
        //拼接属性的id
        YYShoppingModel *productModel = product[0];
        if (i == 0) {
            
            [shopId appendFormat:@"%@",productModel.shopId];

        }else {
            
            [shopId appendFormat:@"|%@",productModel.shopId];
        }
        
        //将本地数据转化为传递的参数
        for (int j = 0; j < product.count; j ++) {
            
            YYShoppingModel *model = product[j];
            NSMutableDictionary *dic = (NSMutableDictionary *)[model dictionaryFromModel];
    
            //将staic 替换成 standardNames  并将value 的 ”a b“格式替换成 ”a|b“ 格式
            NSString *standardNames = [dic[STAIC] stringByReplacingOccurrencesOfString:@" " withString:@"|"];

            //总价格
            NSString *total = [NSString stringWithFormat:@"%ld",[dic[NUMBER] integerValue] * [dic[PRICE] integerValue]];
            [dic setObject:standardNames forKey:STAND_NAMES];
            [dic setObject:total forKey:TOTAL];
            
            //不需要传递的参数
            [dic removeObjectForKey:STAIC];
            [dic removeObjectForKey:SHOP_IMG];
            [dic removeObjectForKey:NAME];
            [dic removeObjectForKey:SHOP_NAME];
            [dic removeObjectForKey:STOCK];
            [dic removeObjectForKey:AREANO_SHOP];
            
            //拼接成list[0].key形式
            for (NSString *key in dic) {
                
                NSString *newKey = [NSString stringWithFormat:@"list[%d].%@",m,key];
                
                [dataDic setObject:dic[key] forKey:newKey];
            }
            m ++;
        }
     
    }
    
    //后期删除---现在存在的原因是 price 从后台取出来的数据 为乱码
    [dataDic setObject:@"222" forKey:@"list[0].price"];    //没有或者为负的时候会报错
    [dataDic setObject:@"222" forKey:@"list[0].total"];     //，没有回报错
    
    [dataDic setObject:_payTabView.addressId forKey:@"addressId"];
    [dataDic setObject:shopId forKey:SHOP_ID];
    [dataDic setObject:@"1" forKey:@"express"];
    [dataDic setObject:MEMBERID_VALUE forKey:MEMBERID];
    
    /**
     *  配送方式和留言可以写到一个循环中
     *
     *  分开写更加的严谨
     *
     */
    //配送方式
    if (_payTabView.distriArr.count != 0) {
        
        NSMutableString *expressPrice = [[NSMutableString alloc] init];
        NSMutableString *expressType = [[NSMutableString alloc] init];
        for (int i = 0; i < _payTabView.distriArr.count; i ++ ) {
            
            NSString *distrib = _payTabView.distriArr[i];
            NSArray *aim = [distrib componentsSeparatedByString:@" "];
            
            if (aim.count == 1) {
             
                //免费
                [expressPrice appendFormat:@"%@",@"0"];
                [expressType appendFormat:@"%@",aim[0]];
              
            }else {
                if (i == 0) {
                    
                    //aim数组包含两个值 例如：“EMS” “6”
                    [expressPrice appendFormat:@"%@",aim[1]];
                    [expressType appendFormat:@"%@",aim[0]];
                }else {
                    [expressPrice appendFormat:@"|%@",aim[1]];
                    [expressType appendFormat:@"|%@",aim[0]];
                }
            }
        }
        
        [dataDic setObject:expressType forKey: EXPRESS_TYPE];
        [dataDic setObject:expressPrice forKey:EXPRESS_PRICE];
    }
    
    //留言
    if (_payTabView.messageArr.count != 0) {
    
        NSMutableString *message = [[NSMutableString alloc] init];
        for (int i = 0; i < _payTabView.distriArr.count; i ++ ) {
            
            NSString *distrib = _payTabView.distriArr[i];
            
            if (i == 0) {
                
                //aim数组包含两个值 例如：“EMS” “6”
                [message appendFormat:@"%@",distrib];
            }else {
                [message appendFormat:@"|%@",distrib];
            }
        }
        [dataDic setObject:message forKey:MESSAGE];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,@"/app/_createMemberOrder"];
    
    [YYNetWorking postwithURL:url withParam:dataDic withHeader:nil success:^(id responsObjc) {
        
        if (responsObjc[@"data"]) {
            
            NSDictionary *data = responsObjc[@"data"];
            
            NSArray *orderList = data[@"orderList"];
            
            for (NSDictionary *dic in orderList) {
                
                //订单的ids
                pay.orderIds = dic[@"ids"];
            }
        }
       
        
    }];
  
    /*
     productId = 6b671003aae245799556f0400602eedd;
     shopId = f066a2d199d54db9b5d08a6cda4ba0ff;
     shopNO = "<null>";
     name = "\U8001\U738b\U724c\U7fbd\U7ed2\U670d";
     price = "-5764607523034215483";
     number = 1;
     icon = "/upload/20151126/1448528532765.jpg";
 //总价格 自己算
     total = number * price
     active = 0;
     
     standardIds = 526684857afe47e7997a078cc219184c|c99fe3794e7e44a2b8961cfe2a79ec24
     standardValues = 颜色|尺码
     
     
     areaNo = "";
     ids = "862b70e5faaa4c269f4b3f176a26cdf5|cd0db57780ad4517ab3e2f9b15b694dd";
     
     shopImg = "";
     shopName = "\U9047\U89c1";
     
     staic = "\U7eff\U8272 L";
     stock = "-5764607523034215483";
     standardKeys = 1ff80f47e8a44df6ae0d575c7f04e3fc|cd0db57780ad4517ab3e2f9b15b694dd
     */
    
    /*
     
     private String productId;1
     private String shopId;1
     private String shopNo;1
     private String productName;
     private float price;
     private int goodsNum;
     private String imageFile;
     private float total;
     private String active; //商品类型 0  1 清仓 2 团购
     
     private String standardIds;-------颜色或者尺码   属性的ids
     private String standardValues;----属性的    汉字
     private String standardKeys;------ids白色和xl
     private String standardNames;-----ids里面的value
     private String standardValNames;
     
     private String cardId;
     private String id;
     
     */
    
    
#warning CanXue - create order
    
//    NSString *price = [NSString stringWithFormat:@"%@%@",BASE_URL,];
//    
//    NSString *urlStr = [NSString stringWithFormat:@"%@/app/standard_findProductStandard?productId=%@",BASE_URL,_url];
//    
//    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,@"/app/_createMemberOrder"];
    
    
    
    
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
