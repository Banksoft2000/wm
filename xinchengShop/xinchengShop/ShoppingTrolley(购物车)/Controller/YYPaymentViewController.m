//
//  YYPaymentViewController.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/22.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYPaymentViewController.h"
#import "WXApi.h"
#import "lhSharePay.h"
@interface YYPaymentViewController ()

//支付金额
@property (strong, nonatomic) IBOutlet UILabel *money;
//余额
@property (strong, nonatomic) IBOutlet UILabel *surplus;
//支付
@property (strong, nonatomic) IBOutlet UIButton *payBtn;
//支付宝支付
@property (strong, nonatomic) IBOutlet UIButton *alipay;

@end



@implementation YYPaymentViewController

//余额支付
- (IBAction)payAction:(UIButton *)sender {
    
    
    
    
    /*
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",BASE_URL,@"/app/_balancePay" ];
    //缺少一个PassWord
#warning CanXue -- Missing PassWord
    NSDictionary *dic = @{MEMBERID:MEMBERID_VALUE,@"ids":_orderIds};
    
    [YYNetWorking postwithURL:url withParam:dic withHeader:nil success:^(id responsObjc) {
        
        
    }];
    */
    
}
/*微信支付
 
 if (![WXApi isWXAppInstalled]) {//检查用户是否安装微信
 
 NSLog(@"未安装微信客户端");
 //...处理
 
 return;
 }
 
 //请求APP后台服务器下单接口，该接口返回orderDic(订单信息)和payDic(支付账号信息，包括：appID,商户号，APIKey)
 [lhSharePay addActivityView:self.view];
 [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(rechargeEvent:) name:@"recharge" object:nil];
 NSDictionary * dic = @{@"rechargeRule_id":@"1",
 @"users_id":@"a38d4da064054e99840efdd91280ee35",
 @"money":@"1000",
 @"way":@"2"};
 //请求字段
 //    [[lhSharePay alloc] HTTPPOSTNormalRequestForURL:@"填写app服务器的请求接口" parameters:dic method:@"POST" name:@"recharge"];
 
 */


#pragma mark - 充值结果
- (void)rechargeEvent:(NSNotification *)noti
{
    [lhSharePay addActivityView:self.view];
    NSLog(@"请求结果 %@",noti.userInfo);
    [[NSNotificationCenter defaultCenter]removeObserver:self name:noti.name object:nil];
    if (!noti.userInfo || [noti.userInfo class] == [[NSNull alloc]class]) {
        NSLog(@"请求失败，网络或服务器异常");
    }
    else if ([[noti.userInfo objectForKey:@"flag"]integerValue] == 1) {
        
        NSDictionary * pDic = [noti.userInfo objectForKey:@"data"];
        NSMutableDictionary * tempDi = [NSMutableDictionary dictionary];
        NSString * productStr = [NSString stringWithFormat:@"The One逗币充值(%@)",@"10元=120逗币"];
        [tempDi setObject:[pDic objectForKey:@"id"] forKey:@"id"];
        [tempDi setObject:@"1000" forKey:@"money"];
        [tempDi setObject:@"2000" forKey:@"present"];
        [tempDi setObject:productStr forKey:@"productName"];
        [tempDi setObject:productStr forKey:@"productDescription"];
        [tempDi setObject:[pDic objectForKey:@"orderNo"] forKey:@"orderCode"];
        
        NSDictionary * orderDic = tempDi;
        
        NSMutableDictionary * payDic = [NSMutableDictionary dictionaryWithDictionary:[pDic objectForKey:@"wxParams"]];
        [payDic setObject:[payDic objectForKey:@"recharge_notify_url"] forKey:@"notify_url"];
        
#warning payDic和orderDic配置
        /*
         //payDic和orderDic请求实例
         NSDictionary * payDic = @{
         @"api_key":@"在商户平台自己设置的API秘钥",
         @"app_id":@"appID",
         @"app_secret":@"appSecret(可不要)",
         @"mch_id":@"腾讯发商户号",
         @"notify_url":@"回调页面（支付成功后微信会请求改回调页面，服务器需要在该页面中对支付成功进行处理。例如为余额充值，则要给用户增加余额；例如为购买商品，则要为用户增加订单（一般这儿是把之前已生成的订单改一个状态））"
         };
         NSDictionary * orderDic = @{
         @"enable":@"1",
         @"id":@"df2b38795ccd40cea71c2e859aec7e5c",
         @"money":@"1000",
         @"orderCode":@"RE20150713135304624",
         @"rechargeRule_id":@"1",
         @"remark":@"微信充值",
         @"status":@"",
         @"successTime":@"",
         @"time":@"1436766784625",
         @"users_id":@"a38d4da064054e99840efdd91280ee35",
         @"way":@"2",
         @"productName":@"微信充值（自定义）",
         @"productDescription":@"微信充值（自定义）"};
         */
        
        //下单成功，调用微信支付
        [[lhSharePay sharePay]wxPayWithPayDic:payDic OrderDic:orderDic];
        
    }
    else{
        NSLog(@"请求失败，服务器处理异常");
    }
}


//支付宝支付
- (IBAction)alipayAction:(UIButton *)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];


    _payBtn.layer.cornerRadius = 5;
    _payBtn.backgroundColor = SHOPPING_DELETE_BG;

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
