//
//  YYDetailViewController.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/1.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYDetailViewController.h"
#import "YYDetailTableView.h"
#import "YYDetailDownView.h"

#import "YYDetailModel.h"   //详情数据
#import "YYImageModel.h"    //图片数据
#import "YYTextModel.h"     //文字数据
#import "YYPriceModel.h"    //价格model
#import "YYStandardModel.h"

#import "YYMyData.h"

#import "YYPayViewController.h"
#import "YYShoppingModel.h"


#define IMGOLLITEMWIDTH 60
@interface YYDetailViewController ()
{
    
    UIWebView *_webView;
    
    //详情数据
    NSMutableArray *_dataArr;
    //购买请求的数据
    NSMutableArray *_standardArr;   //装载规格数据
    NSMutableArray *_colorArr;      //装载颜色
    NSMutableArray *_sizeArr;       //装载size
    NSMutableArray *_priceArr;      //装载价格

    NSMutableArray *_allData;
    
    //底部购买视图
    YYBuyView *_buyView;
    //遮罩视图
    UIView *_maskView;
    
    NSMutableDictionary *_productDic;   //数据保存传递的参数
    YYDetailDownView *_down;            //底部视图

}

@end

#define DOWNHEIGHT 40
@implementation YYDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"商品详情";

    _productDic = [[NSMutableDictionary alloc] init];

    
    [self initTableView];
    [self initData];
    [self initDownView];
    [self initNavigationBar];
    
    
}

#pragma mark - NavigationBar
- (void)initNavigationBar {
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(0, 0, 30, 30);
    
    [back setImage:[UIImage imageNamed:@"title_back_icon"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back]; 
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)back:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableView
- (void)initTableView {
    
    _detailTableView = [[YYDetailTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-64)];
    
    _detailTableView.detailDelegate = self;
    [self.view addSubview:_detailTableView];
    
}


#pragma mark - 加入购物车
//底部视图
- (void)initDownView {
    
    _down = [[[NSBundle mainBundle] loadNibNamed:@"YYDetailDownView" owner:nil options:nil] lastObject];

    [self.view addSubview:_down];
    
    [_down mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view.mas_bottom);

        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);

        make.height.equalTo(@49);
        
        
    }];
    
    _down.buy.tag = 1800;
    _down.addShopping.tag = 1801;
    
    [_down.buy addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
    [_down.addShopping addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
//    [down.shopCart addTarget:self action:@selector(goToShopCaaart) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)buyAction:(UIButton *)sender {

    //遮罩视图
    _maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    _maskView.backgroundColor = [UIColor blackColor];
    _maskView.alpha = 0.5;
    [self.view addSubview:_maskView];
    
    //购买视图
    _buyView = [[[NSBundle mainBundle] loadNibNamed:@"YYBuyView" owner:nil options:nil] lastObject];
    
    _buyView.buyDelegate = self;
    
    [self.view addSubview:_buyView];
    
    [_buyView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(@330);
        make.top.equalTo(self.view.mas_bottom);
        
    }];
    
    
    [UIView animateWithDuration:.35 animations:^{

        _buyView.transform = CGAffineTransformTranslate(_buyView.transform, 0, -330);
   
    }];
    
    //请求数据
    [self initBuyData];
    
    if (sender.tag == 1800) {
        
        //底部视图点击确定和关闭调用的方法
        [_buyView.makeSure addTarget:self action:@selector(makeSureAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }else {
        
        //底部视图点击确定和关闭调用的方法
        [_buyView.makeSure addTarget:self action:@selector(makeSure:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    [_buyView.close addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
  
}

//添加购物车 点击确认的时候调用的方法
- (void)makeSure:(UIButton *)sender {
    
    [self removeMaskAndBuy];
    
    if (_productDic != NULL) {
        
        //存储数据
        YYMyData *data = [YYMyData new];
        
        [data insertDataWithDic:_productDic];
    }
    
}

// 立即购买  点击确认的时候调用的方法
- (void)makeSureAction:(UIButton *)sender {
    
    [self removeMaskAndBuy];
    
    if (_productDic != NULL) {
        
        //存储数据
        YYMyData *data = [YYMyData new];

        [data insertDataWithDic:_productDic];
    }
    
    YYPayViewController *pay = [[YYPayViewController alloc] init];
   
    //构建YYPayViewController 需要的数据结构
    YYShoppingModel *model = [[YYShoppingModel alloc] initWithDictionary:_productDic];
    NSArray *arr = [[NSArray alloc] initWithObjects:model, nil];
    NSArray *arr1 = [[NSArray alloc] initWithObjects:arr, nil];
    
    pay.shopArr = (NSMutableArray *)arr1;
    
    NSInteger money = [model.price integerValue] * [model.number integerValue];
    
    pay.money = money;
    
    [self.navigationController pushViewController:pay animated:YES];
    
}

#pragma mark - BuyDelegate
//product的属性及价格
- (void)productDetail:(NSDictionary *)dic {

    for (NSString *key in dic) {

        [_productDic setObject:dic[key] forKey:key];
        
    }
}
#pragma mark - DetailTableDelegate
//店铺的id name image
- (void)productWithDic:(NSDictionary *)dictionary {
    
    for (NSString *key in dictionary) {
        
        [_productDic setObject:dictionary[key] forKey:key];
    }
}

//点击关闭调用的方法
- (void)closeAction:(UIButton *)sender {
    
    [self removeMaskAndBuy];
}

//移除遮罩视图和购买视图
- (void)removeMaskAndBuy {

    [_maskView removeFromSuperview];
    [UIView animateWithDuration:.35 animations:^{
        
        _buyView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        [_buyView removeFromSuperview];
    }];
}

#pragma mark - 请求数据
- (void)setUrl:(NSString *)url {

    _url = url;
  
}

- (void)initData {
    
    if (_url.length < 1) {
        
        return;
    }
    
    _dataArr = [[NSMutableArray alloc] init];
    NSString *urlStr = [NSString stringWithFormat:@"%@/app/_searchProduct?id=%@",BASE_URL,_url];

    NSLog(@"%s-%@",__FUNCTION__, urlStr);
 
    [YYNetWorking homeHeaderWithURL:urlStr :^(id responsObjc) {
 
        NSDictionary *dic = responsObjc[@"data"];
        

        YYDetailModel *model = [[YYDetailModel alloc] initWithDictionary:dic];

        [_dataArr addObject:model];

        _detailTableView.describe = dic[@"description"];
        _detailTableView.dataArr = _dataArr;
        
        //底部视图传值
        _down.productId = model.id;
        

    }];
}

- (void)initBuyData {
    
    
    if (_url.length < 1) {
        return;
    }
    
//    http://xinchengguangchang.com/app/standard_findProductStandard?productId=6b671003aae245799556f0400602eedd&app=true
    
    _standardArr = [[NSMutableArray alloc] init];
    _colorArr    = [[NSMutableArray alloc] init];
    _sizeArr     = [[NSMutableArray alloc] init];
    _priceArr    = [[NSMutableArray alloc] init];
    
    _allData = [[NSMutableArray alloc] init];
    NSString *urlStr = [NSString stringWithFormat:@"%@/app/standard_findProductStandard?productId=%@",BASE_URL,_url];
    
    NSLog(@"%s-%@",__FUNCTION__, urlStr);
    
    [YYNetWorking homeHeaderWithURL:urlStr :^(id responsObjc) {
        
        NSDictionary *data = responsObjc[@"data"];
        
        NSArray *standardsList = data[@"standardsList"];
        NSArray *priceList = data[@"priceStock"];
        
        // STAND_IDS
        NSMutableString *standIDs = [[NSMutableString alloc] init];
        //  STAND_VALUES
        NSMutableString  *standValue = [[NSMutableString alloc] init];
        //获取到规格
        for (NSDictionary *dic in standardsList) {
            
            //拼接订单提交时需要的 属性id
            if (standIDs.length < 1) {
                
                [standIDs appendFormat:@"%@",dic[@"id"]];
            }else {
                
                [standIDs appendFormat:@"|%@",dic[@"id"]];
            }
            
            //拼接订单提交时需要的 属性 名称
            if (standValue.length < 1) {
                
                [standValue appendFormat:@"%@",dic[@"name"]];
            }else {
                
                [standValue appendFormat:@"|%@",dic[@"name"]];
            }
            
            //规格订单的详情信息
            YYStandardModel *model = [[YYStandardModel alloc] initWithDictionary:dic];
            
            [_standardArr addObject:model];

            //图片
            if ([model.type isEqual:@"image"]) {
                
                NSArray *list = dic[@"list"];
                
                for (NSDictionary *listDic in list) {
                    
                    YYImageModel *colorModel = [[YYImageModel alloc] initWithDictionary:listDic];
                    
                    [_colorArr addObject:colorModel];
                }
                
                [_allData addObject:_colorArr];
                
            }
            //文字
            else if ([model.type isEqual:@"text"]){
                
                NSArray *list = dic[@"list"];
                
                for (NSDictionary *listDic in list) {
                    
                    YYTextModel *sizeModel = [[YYTextModel alloc] initWithDictionary:listDic];
                    [_sizeArr addObject:sizeModel];
                }
                
                [_allData addObject:_sizeArr];
            }
            
        }
        
        //获取到价格
        for (NSDictionary *dic in priceList) {

            YYPriceModel *model = [[YYPriceModel alloc] initWithDictionary:dic];
            
            [_priceArr addObject:model];
            
        }
        
        _buyView.allData = _allData;
        _buyView.standArr = _standardArr;       //规格
        _buyView.colorArr = _colorArr;
        _buyView.sizeArr = _sizeArr;
        _buyView.priceArr = _priceArr;
        
        //保存数据需要的参数
        [_productDic setObject:standIDs forKey:STAND_IDS];
        [_productDic setObject:standValue forKey:STAND_VALUES];
 
    }];
 
}

@end
